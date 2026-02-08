DoFadeOut:
		subq.b	#1,v_fadeout_counter(a6)	; Update fade counter
		beq.w	StopAllSound			; Branch if fade is done
		moveq	#3,d0				; update every 4 frames
		and.b	v_fadeout_counter(a6),d0
		bne.s	.skipthisframe

		lea	v_music_dac_tracks(a6),a5
		moveq	#((v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz)-1,d7
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
; ===========================================================================
DoFadeIn:
;		tst.b	v_fadein_counter(a6)		; Is fade done?
;		beq.s	.fadedone			; Branch if yes
		subq.b	#1,v_fadein_counter(a6)		; Update fade counter

		lea	v_music_dac_tracks(a6),a5
		moveq	#((v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz)-1,d7
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
StopAllSound:
.startaddr	= v_startofvariables
.endaddr	= v_endofvariables
.clrLen		= .endaddr-.startaddr
		lea	.startaddr(a6),a1
		moveq	#0,d0
		move.w	#(.clrLen)/4-1,d1
.clrLoop:	move.l	d0,(a1)+
		dbf	d1,.clrLoop
	if (.clrLen)&2
		move.w	d0,(a1)+
	endif
	if (.clrLen)&1
		move.b	d0,(a1)+
	endif
		moveq_	$FF!(1<<1|1<<0),d0		; clear 1up and speedup
		and.b	v_driverflags(a6),d0
		move.b	d0,v_driverflags(a6)
.skipram:
		moveq	#$27,d0				; Timers, FM3 mode
		moveq	#0,d1				; FM3 normal mode, disable timers
		bsr.w	WriteFMI

		bsr.w	DACStopSample
		bsr.w	FMSilenceAll
		bra.w	PSGSilenceAll
; ===========================================================================
StopBGM:
		lea	v_music_dac_tracks(a6),a5
		moveq	#((v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz)-1,d6
.dacloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.dacnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	DACStopSample
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
		add.w	#((30/2)-$40)*2,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBFX=1
		move.w	(a3,d3.w),d0
		beq.s	.dacgetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.dacgotptr
.dacgetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.dacnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.dacnext
.dacgotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
.dacnext:
		dbf	d6,.dacloop


		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d6
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.fmnext
		and.b	#$FF!(1<<_playing|1<<_noattack),TrackPlaybackControl(a5)
		bsr.w	FMSilence
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBFX=1
		move.w	(a3,d3.w),d0
		beq.s	.fmgetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.fmgotptr
.fmgetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.fmnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.fmnext
.fmgotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		exg.l	a3,a5
		bsr.w	SetVoice
		move.l	a3,a5
.fmnext:
		add.w	#TrackFmSz,a5
		dbf	d6,.fmloop


		lea	v_music_psg_tracks(a6),a5
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d6
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.psgnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		lsr.b	#3,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBFX=1
		move.w	(a3,d3.w),d0
		beq.s	.psggetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		move.b	TrackVoiceControl(a3),d0
		cmpi.b	#$E0,d0
		blo.s	.psgnext
		cmpi.b	#$E7,d0
		bhi.s	.psgnext
		move.b	d0,(psginput).l				; Set noise tone
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop

		rts
; ===========================================================================
StopSFX:
		clr.b	v_sndprio(a6)

		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d6
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.fmnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	FMSilence
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
	if __smpsBFX=1
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.fmgetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bmi.s	.fmgotptr
.fmgetptr:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
	 	beq.s	.fmnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bpl.s	.fmnext
.fmgotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		exg.l	a3,a5
		bsr.w	SetVoice
		move.l	a3,a5
.fmnext:
		add.w	#TrackFmSz,a5
		dbf	d6,.fmloop


		lea	v_sfx_psg_tracks(a6),a5
		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/TrackPsgSz)-1,d6
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.psgnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		lsr.b	#3,d3
	if __smpsBFX=1
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psggetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		move.b	TrackVoiceControl(a3),d0
		cmpi.b	#$E0,d0
		blo.s	.psgnext
		cmpi.b	#$E7,d0
		bhi.s	.psgnext
		move.b	d0,(psginput).l				; Set noise tone
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop

		rts
; ===========================================================================
		if __smpsBFX=1
StopBSFX:
		lea	v_spcsfx_fm_tracks(a6),a5
		moveq	#((v_spcsfx_fm_tracks_end-v_spcsfx_fm_tracks)/TrackFmSz)-1,d6
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.fmnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	FMSilence
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
		lea	RAM_SFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.fmgetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bmi.s	.fmgotptr
.fmgetptr:
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
	 	beq.s	.fmnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bpl.s	.fmnext
.fmgotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		exg.l	a3,a5
		bsr.w	SetVoice
		move.l	a3,a5
.fmnext:
		add.w	#TrackFmSz,a5
		dbf	d6,.fmloop


		lea	v_spcsfx_psg_tracks(a6),a5
		moveq	#((v_spcsfx_psg_tracks_end-v_spcsfx_psg_tracks)/TrackPsgSz)-1,d6
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.psgnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		lsr.b	#3,d3
		lea	RAM_SFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psggetptr
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a6,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		move.b	TrackVoiceControl(a3),d0
		cmpi.b	#$E0,d0
		blo.s	.psgnext
		cmpi.b	#$E7,d0
		bhi.s	.psgnext
		move.b	d0,(psginput).l				; Set noise tone
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop

		rts
		endif