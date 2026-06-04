; ---------------------------------------------------------------------------
; Subroutine to update music
; (Called by vertical interrupts, built to survive horizontal interrupts)
; INPUT:
; a1 = start of driver ram
; ---------------------------------------------------------------------------
RunDriver:
		move.l	a1,a6

HandleRNG:
		move.w	v_random(a6),d0
		rol.w	#2,d0
		addq.w	#1,d0
		add.w	d0,v_random(a6)

HandlePause:
		moveq_	1<<v_driverflags.dopause|1<<v_driverflags.paused,d0
		and.b	v_driverflags(a6),d0
		jmp	.lut(pc,d0.w)		; assumed .paused is b2 and .dopause is b3
.lut:		bra.w	.playmusic
		bra.w	.resumingmusic
		bra.w	.pausedmusic
	;	bra.w	.pausingmusic
.pausingmusic:
		bclr	#v_driverflags.dopause,v_driverflags(a6)
		bsr.w	PauseCDDA

		moveq_	$B4,d0			; Command to set AMS/FMS/panning
		moveq	#0,d1			; No panning, AMS or FMS
		bsr.w	WriteFMI		; FM1
		bsr.w	WriteFMII		; FM4
		addq.b	#1,d0
		bsr.w	WriteFMI		; FM2
		bsr.w	WriteFMII		; FM5
		addq.b	#1,d0
		bsr.w	WriteFMI		; FM3
		tst.b	v_music_fm6_track+TrackPlaybackControl(a6)	; is FM6 playing?
		bpl.s	.notFM6			; if not, don't touch it, because FM6 is owned by Mega PCM then
		bsr.w	WriteFMII		; FM6
.notFM6:
		moveq	#2,d3
		moveq	#$28,d0			; Key on/off register
.noteoffloop:	move.b	d3,d1			; FM1, FM2, FM3
		bsr.w	WriteFMI
		addq.b	#4,d1			; FM4, FM5, FM6
		bsr.w	WriteFMI
		dbf	d3,.noteoffloop
		bsr.w	PSGSilenceAll
		bra.w	DACPauseSample
.unp_pcmloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.unp_pcmnext
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		move.b	TrackAMSFMSPan(a5),d1		; Get value from track RAM
		btst	#v_driverflags.mono,v_driverflags(a6)
		beq.s	.unp_pcmstereo
		or.b	#$C0,d1				; force mono
.unp_pcmstereo:	bsr.w	DACSetPan
.unp_pcmnext:	lea	TrackDacSz(a5),a5
		dbf	d7,.unp_fmloop
		rts
.unp_fmloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.unp_fmnext
		moveq_	$B4,d0				; Command to set AMS/FMS/panning
		move.b	TrackAMSFMSPan(a5),d1		; Get value from track RAM
		btst	#v_driverflags.mono,v_driverflags(a6)
		beq.s	.unp_fmstereo
		or.b	#$C0,d1				; force mono
.unp_fmstereo:	bsr.w	WriteFMIorII
.unp_fmnext:	lea	TrackFmSz(a5),a5
		dbf	d7,.unp_fmloop
.pausedmusic:
		rts
.resumingmusic:
		bclr	#v_driverflags.dopause,v_driverflags(a6)
		bsr.w	ResumeCDDA

		lea	v_music_pcm_tracks(a6),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		bsr.s	.unp_pcmloop
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.unp_fmloop
		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.unp_fmloop
		if __smpsBSFX=1
		lea	v_bsfx_fm_tracks(a6),a5
		moveq	#((v_bsfx_fm_tracks_end-v_bsfx_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.unp_fmloop
		endif
		bsr.w	DACResumeSample
		;bra.s	.playmusic
.playmusic:
		bsr.w	DACUpdateSFX

HandleFading:
		tst.b	v_fadeout_counter(a6)
		beq.s	.skipfadeout
		bsr.w	DoFadeOut
		bra.s	.skipfadein
.skipfadeout:
		tst.b	v_fadein_counter(a6)
		beq.s	.skipfadein
		bsr.w	DoFadeIn
.skipfadein:

HandleMisc:
		tst.b   v_revving_timer(a6)
		beq.s	.norevtimer
		subq.b	#1,v_revving_timer(a6)
.norevtimer:

HandleSoundQueue:
		bsr.w	CycleSoundQueue

HandleSequencer:
		bsr.w	TempoWait

		lea	v_music_pcm_tracks(a6),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
.bgmdacloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.bgmdacnext
		bsr.w	PCMUpdateTrack
.bgmdacnext:	add.w	#TrackDacSz,a5
		dbf	d7,.bgmdacloop

	if __smpsDebug
		lea	v_music_fm_tracks(a6),a0
		cmp.l	a0,a5
		beq.s	.bgmfmvalid
		SMPS_assert "Invalid BGM FM start sequence"
.bgmfmvalid:
	endif
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
.bgmfmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.bgmfmnext
		bsr.w	FMUpdateTrack
.bgmfmnext:	add.w	#TrackFmSz,a5
		dbf	d7,.bgmfmloop

	if __smpsDebug
		lea	v_music_psg_tracks(a6),a0
		cmp.l	a0,a5
		beq.s	.bgmpsgvalid
		SMPS_assert "Invalid BGM PSG start sequence"
.bgmpsgvalid:
	endif
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d7
.bgmpsgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.bgmpsgnext
		bsr.w	PSGUpdateTrack
.bgmpsgnext:	add.w	#TrackPsgSz,a5
		dbf	d7,.bgmpsgloop

; I fucking hate this
HandleCheapPalFix:
		move.b	v_driverflags(a6),d0	; check if it's PAL
		bpl.s	.pal_notyet
		tst.b	v_paltimer(a6)		; check if the song wants to update slowly
		bmi.s	.pal_notyet
		subq.b	#1,v_paltimer(a6)	; count down 5 frames
		bcc.s	.pal_notyet
		move.b	#5,v_paltimer(a6)	; update BGM again
		bra.w	HandleSequencer
.pal_notyet:

; when a BGM is initiated, tempo and playback are skipped on that frame to avoid murdering CPU time
; SFXs are not skipped so they don't sound off
HandleSoundQueueEnd:
	if __smpsJingle=1
		btst	#v_driverflags.jingle,v_driverflags(a6)
		bne.s	.skipsfxs
	endif
		lea	v_sfx_fm_tracks(a6),a5

		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
.sfxfmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.sfxfmnext
		bsr.w	FMUpdateTrack
.sfxfmnext:	adda.w	#TrackFmSz,a5
		dbf	d7,.sfxfmloop

		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/TrackPsgSz)-1,d7
.sfxpsgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.sfxpsgnext
		bsr.w	PSGUpdateTrack
.sfxpsgnext:	adda.w	#TrackPsgSz,a5
		dbf	d7,.sfxpsgloop
; TODO: flesh out
		tst.b	TrackPlaybackControl(a5)
		bpl.s	.specfmdone
		bsr.w	FMUpdateTrack
.specfmdone:	adda.w	#TrackFmSz,a5

		tst.b	TrackPlaybackControl(a5)
		bpl.s	.specpsgdone
		bsr.w	PSGUpdateTrack
.specpsgdone:	;adda.w	#TrackPsgSz,a5
.skipsfxs:

HandleSequencerEnd:
		rts
; ===========================================================================
; Every time the internal music clock overflows, delay the song.
; A tempo of $000x will update every frame, 60 times a second
; A tempo of $800x will update every other frame, 30 times a second.
; ---------------------------------------------------------------------------
TempoWait:
		move.w	v_main_tempo(a6),d2
		moveq_	$FFF0,d0
		and.w	d2,d0
		moveq_	$000F,d1
		and.w	d2,d1
		add.w	d1,d1
		add.w	d1,d1
; if speedup is on and 1up is off, increase the tempo if possible
		moveq	#1<<v_driverflags.speedsong|1<<v_driverflags.jingle,d2
		and.b	v_driverflags(a6),d2
		cmp.b	#1<<v_driverflags.speedsong|0<<v_driverflags.jingle,d2
		bne.s	.nospeedalgo
		move.w	d0,d2				; TODO: good math
		lsr.w	#1,d2
		sub.w	d2,d0
.nospeedalgo:
		jmp	.lut(pc,d1.w)
.lut:		bra.w	.withfractions
		bra.w	.sansfractions
		rept 16-2
		bra.w	.error
		endr
.withfractions:
		add.w	d0,v_main_tempo_timeout(a6)
		bcc.s	.exit
	set .val,v_music_pcm_tracks+TrackDurationTimeout
	rept (v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackDurationTimeout
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackDurationTimeout
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackPsgSz
	endr
.exit:		rts
.sansfractions:
		add.w	d0,v_main_tempo_timeout(a6)
		bcc.s	.exit
		clr.w	v_main_tempo_timeout(a6)
	set .val,v_music_pcm_tracks+TrackDurationTimeout
	rept (v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackDurationTimeout
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackDurationTimeout
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		addq.b	#1,.val(a6)
	set .val,.val+TrackPsgSz
	endr
		rts
.error:
		SMPS_assert "Improper tempo algorithm type, TODO print the algo"
; ===========================================================================
DoFadeOut_Stop:
		bra.w	StopAllSound
DoFadeOut:
		subq.b	#1,v_fadeout_counter(a6)	; Update fade counter
		beq.s	DoFadeOut_Stop			; Branch if fade is done
		moveq	#3,d0				; update every 4 frames
		and.b	v_fadeout_counter(a6),d0
		bne.s	.skipthisframe

		lea	v_music_pcm_tracks(a6),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
.dacloop:	tst.b	TrackPlaybackControl(a5)	; Is track playing?
		bpl.s	.nextdac			; Branch if not
		addq.b	#1,TrackVolume(a5)
		bpl.s	.senddacvol
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	DACStopSample
		bra.s	.nextdac
.senddacvol:	move.b	TrackVolume(a5),d0
		lsr.b	#3,d0
		bsr.w	SetVolume
.nextdac:	add.w	#TrackDacSz,a5
		dbf	d7,.dacloop

		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
.fmloop:	tst.b	TrackPlaybackControl(a5)	; Is track playing?
		bpl.s	.nextfm				; Branch if not
		addq.b	#1,TrackVolume(a5)		; Increase volume attenuation
		bpl.s	.sendfmtl			; Branch if still positive
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bra.s	.nextfm
.sendfmtl:	bsr.w	SetVolume
.nextfm:	add.w	#TrackFmSz,a5
		dbf	d7,.fmloop

		lea	v_music_psg_tracks(a6),a5
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d7
.psgloop:	tst.b	TrackPlaybackControl(a5)	; Is track playing?
		bpl.s	.nextpsg			; branch if not
		addq.b	#1,TrackVolume(a5)		; Increase volume attenuation
		bpl.s	.sendpsgvol
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bra.s	.nextpsg
.sendpsgvol:	bsr.w	SetVolume
.nextpsg:	add.w	#TrackPsgSz,a5
		dbf	d7,.psgloop

.skipthisframe:
		rts
; ---------------------------------------------------------------------------
DoFadeIn:
;		tst.b	v_fadein_counter(a6)		; Is fade done?
;		beq.s	.fadedone			; Branch if yes
		subq.b	#1,v_fadein_counter(a6)		; Update fade counter

		lea	v_music_pcm_tracks(a6),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		moveq	#TrackDacSz,d6
		bsr.s	.fade

		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade

		lea	v_music_psg_tracks(a6),a5
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d7
		moveq	#TrackPsgSz,d6
;		bsr.s	.fade
.fade:
.loop:		tst.b	TrackPlaybackControl(a5)
		bpl.s	.next
		bsr.w	SetVolume
.next:		add.w	d6,a5
		dbf	d7,.loop
		rts
; ===========================================================================
; Pointers to RAM addresses for cross-referencing data between channels
; ---------------------------------------------------------------------------
; smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
smpsMakeChannelRamIndex macro reg,ctrlreg
		clr.w	reg
		move.b	ctrlreg,reg
		bmi.s	.stoppsg
		add.b	reg,reg
		bpl.s	.stopfm
		add.w	#((30/2)-$40)*2,reg
		bra.s	.stopdac
.stoppsg:	lsr.w	#3,reg
.stopfm:
.stopdac:
	endm
; smpsGetChannelFromRamIndex a6,d0,d1,a2,a5
smpsGetChannelFromRamIndex macro ramreg,indexreg,addreg,tempchanreg,chanreg
		lea	RAM_SFXChannel(pc),tempchanreg
		move.w	(tempchanreg,indexreg.w),addreg
		beq.s	.notsfx
		move.l	ramreg,tempchanreg
		add.w	addreg,tempchanreg
		tst.b	TrackPlaybackControl(tempchanreg)
	if __smpsBSFX<>1
		bpl.s	.notsfx
		move.l	tempchanreg,chanreg
.notsfx:
	else
		bmi.s	.sfx
.notsfx:
		lea	RAM_BSFXChannel(pc),tempchanreg
		move.w	(tempchanreg,indexreg.w),addreg
		beq.s	.notbsfx
		move.l	ramreg,tempchanreg
		add.w	addreg,tempchanreg
		tst.b	TrackPlaybackControl(tempchanreg)
		bpl.s	.notbsfx
.sfx:		move.l	tempchanreg,chanreg
.notbsfx:
	endif
	endm

RAM_BGMChannel:
		dc.w v_music_fm1_track,v_music_fm2_track,v_music_fm3_track,v_music_fm3_multifreq
		dc.w v_music_fm4_track,v_music_fm5_track,v_music_fm6_track,0
		dc.w v_music_psg1_track,0	; 16
		dc.w v_music_psg2_track,0
		dc.w v_music_psg3_track,0
		dc.w v_music_psg4_track
		dc.w v_music_pcm1_track		; 30
RAM_SFXChannel:
		dc.w 0,0,v_sfx_fm3_track,v_sfx_fm3_multifreq
		dc.w v_sfx_fm4_track,v_sfx_fm5_track,0,0
		dc.w v_sfx_psg1_track,0
		dc.w v_sfx_psg2_track,0
		dc.w v_sfx_psg3_track,0
		dc.w v_sfx_psg3_track
		dc.w 0
	if __smpsBSFX=1
RAM_BSFXChannel:
		dc.w 0,0,0,0
		dc.w v_bsfx_fm4_track,0,0,0
		dc.w 0,0
		dc.w 0,0
		dc.w v_bsfx_psg3_track,0
		dc.w v_bsfx_psg3_track
		dc.w 0
	endif