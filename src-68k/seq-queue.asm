CycleSoundQueue:
		lea	v_soundqueue0(a1),a0		; load music track number
		rept (v_soundqueue_end-v_soundqueue_start)/2
		move.w	(a0)+,d7
		bne.s	.success
		endr
.locret:
		rts
.success:
		clr.w	-(a0)				; clear entry
		move.w	d7,d0
		sub.w	#$F000,d0
		blo.s	.notcmd
		cmp.w	#(.inde-.ind)<<(8-2),d0
		bhs.s	.locret
		and.w	#$FF00,d0
		lsr.w	#8-2,d0
		jmp	.ind(pc,d0.w)
.ind:		bra.w	Cmd_FadeOutMusic		; $F0xx
		bra.w	Cmd_FadeOutMusicStopSFX		; $F1xx
		bra.w	Cmd_FadeIn			; $F2xx
		bra.w	Cmd_StopSound			; $F3xx
		bra.w	Cmd_SetBitFlag			; $F4xx
.inde:
.notcmd:
		move.l	v_dataptr(a1),a0
	if drvdata.bgmcnt<>0
		lea	drvdata.bgmcnt(a0),a0
	endif
		subq.w	#1,d7
		cmp.w	(a0),d7				; Is this music?
		blo.w	Sound_PlayBGM			; Branch if yes

		sub.w	(a0)+,d7			; move to sfxcnt
		cmp.w	(a0),d7				; Is this sfx?
		blo.w	Sound_PlaySFX			; Branch if yes

		sub.w	(a0)+,d7			; move to pcmcnt
		cmp.w	(a0),d7				; Is this pcm?
		blo.w	Sound_PlayPCM			; Branch if yes
		rts
; ---------------------------------------------------------------------------
Cmd_FadeOutMusicStopSFX:
		move.w	d7,-(sp)
		bsr.w	StopSFX
	if __smpsBSFX
		bsr.w	StopBSFX
	endif
		move.w	(sp)+,d7

Cmd_FadeOutMusic:
		move.b	d7,v_fadeout_counter(a1)
		rts
; ---------------------------------------------------------------------------
Cmd_FadeIn:
		move.b	d7,v_fadein_counter(a1)
		lea	v_music_pcm_tracks(a1),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		moveq	#TrackDacSz,d6
		bsr.s	.fade
		lea	v_music_fm_tracks(a1),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_music_psg_tracks(a1),a5
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
; ---------------------------------------------------------------------------
; no bits set stops all sound
; bit 0 set stops BGM
; bit 1 set stops SFX
; bit 2 set stops Background SFX (BSFX)
; bit 3 set stops PCM SFX (PSFX)
; bit 7 set clears various sound-altering flags
Cmd_StopSound:
	if __smpsBSFX
		moveq_	$FF!%10001111,d0
	else
		moveq_	$FF!%10001011,d0
	endif
		and.b	d7,d0
		beq.s	.valid
		SMPS_assert "Invalid channel stop command, TODO: print bitfield"
.valid:
		tst.b	d7
		beq.w	StopAllSound
;		tst.b	d7
		bpl.s	.notflags
		bsr.w	StopSoundFlags
.notflags:
		btst	#3,d7
		beq.s	.notpsfx
		moveq	#-1,d0
		bsr.w	DACStopSampleSFX
.notpsfx:
		btst	#1,d7
		beq.s	.notsfx
		bsr.w	StopSFX
.notsfx:
	if __smpsBSFX
		btst	#2,d7
		beq.s	.notbsfx
		bsr.w	StopBSFX
.notbsfx:
	endif
		btst	#0,d7
		bne.w	StopBGM
		rts
; ---------------------------------------------------------------------------
Cmd_SetBitFlag:
		cmp.b	#.tend-.table,d7
		blo.s	.valid
		SMPS_assert "Invalid bit flag set command, TODO: print bitfield"
.valid:
		move.w	#$FE,d0
		and.w	d7,d0
		add.w	d0,d0
		lea	.table(pc,d0.w),a2
		move.w	(a2)+,d0				; BBBR RRRR  RRRR RRRR
		move.w	d0,d1
		rol.w	#3,d1
		and.w	#7,d1
		and.w	#$1FFF,d0

		and.b	#1,d7
		bne.s	.set
.clr:		bclr	d1,(a1,d0.w)
		bne.s	.ack
		rts
.set:		bset	d1,(a1,d0.w)
		beq.s	.ack
		rts
.ack:		move.w	(a2)+,d0
		jmp	.table(pc,d0.w)
.table:
		dc.w (v_driverflags.speedsong)<<13|v_driverflags,Cmd_SetBitFlag_Speed-.table	; 0 ; tempo speedup
		dc.w (v_driverflags.mono)<<13     |v_driverflags,Cmd_SetBitFlag_Mono-.table	; 2 ; stereo/mono
		dc.w (v_driverflags.ssgoff)<<13   |v_driverflags,Cmd_SetBitFlag_SSG-.table	; 4 ; SSG-EG
		dc.w (v_driverflags.muffle)<<13   |v_driverflags,Cmd_SetBitFlag_Muffle-.table	; 6 ; water muffle
.tend:

Cmd_SetBitFlag_Speed:
		rts

Cmd_SetBitFlag_Mono:
		lea	v_music_pcm_tracks(a1),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		bsr.s	.dacloop
		lea	v_music_fm_tracks(a1),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.fmloop
		lea	v_sfx_fm_tracks(a1),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		if __smpsBSFX
		bsr.s	.fmloop
		lea	v_bsfx_fm_tracks(a1),a5
		moveq	#((v_bsfx_fm_tracks_end-v_bsfx_fm_tracks)/TrackFmSz)-1,d7
		endif
.fmloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.fmnext
		moveq_	fmreg.panamspms,d0
		move.b	TrackAMSFMSPan(a5),d1
		btst	#v_driverflags.mono,v_driverflags(a1)
		beq.s	.fmstereo
		or.b	#$C0,d1				; force mono
.fmstereo:	bsr.w	WriteFMIorIIMain
.fmnext:	lea	TrackFmSz(a5),a5
		dbf	d7,.fmloop
		rts
.dacloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.dacnext
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		move.b	TrackAMSFMSPan(a5),d1
		btst	#v_driverflags.mono,v_driverflags(a1)
		beq.s	.dacstereo
		or.b	#$C0,d1				; force mono
.dacstereo:	bsr.w	DACSetPan
.dacnext:	lea	TrackDacSz(a5),a5
		dbf	d7,.dacloop
		rts

Cmd_SetBitFlag_SSG:
		lea	v_music_fm_tracks(a1),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.loop
		lea	v_sfx_fm_tracks(a1),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		if __smpsBSFX
		bsr.s	.loop
		lea	v_bsfx_fm_tracks(a1),a5
		moveq	#((v_bsfx_fm_tracks_end-v_bsfx_fm_tracks)/TrackFmSz)-1,d7
		endif
.loop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.next
		bsr.w	SendVoiceSSG
.next:		lea	TrackFmSz(a5),a5
		dbf	d7,.loop
		rts

Cmd_SetBitFlag_Muffle:
		lea	v_sfx_fm_tracks(a1),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_sfx_psg_tracks(a1),a5
		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/TrackPsgSz)-1,d7
		moveq	#TrackPsgSz,d6
		bsr.s	.fade
	if __smpsBSFX
		lea	v_bsfx_fm_tracks(a1),a5
		moveq	#((v_bsfx_fm_tracks_end-v_bsfx_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_bsfx_psg_tracks(a1),a5
		moveq	#((v_bsfx_psg_tracks_end-v_bsfx_psg_tracks)/TrackPsgSz)-1,d7
		moveq	#TrackPsgSz,d6
		bsr.s	.fade
	endif
		lea	v_music_pcm_tracks(a1),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		moveq	#TrackDacSz,d6
		bsr.s	.fade
		lea	v_music_fm_tracks(a1),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_music_psg_tracks(a1),a5
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
Sound_PlayPCM:
		move.w	d7,d1
		moveq	#0,d0
		bra.w	DACQueueSampleSFX
; ===========================================================================
DACInitBytes:
	dc.b $40,1<<_drummode	; PCM1
	dc.b $41,1<<_drummode	; PCM2
FMInitBytes:
	dc.b $00,0	; FM1
	dc.b $01,0	; FM2
	dc.b $02,0	; FM3
	dc.b $04,0	; FM4
	dc.b $05,0	; FM5
	dc.b $06,0	; FM6
PSGInitBytes:
	dc.b $80,0	; PSG1
	dc.b $A0,0	; PSG2
	dc.b $C0,0	; PSG3
	dc.b $E0,1<<_drummode	; PSG4
	even
; ===========================================================================
; TODO: enums?
-
	phase 0
	if __smpsPanEnv
queue_panenvptr	ds.l 1
	endif
	if __smpsModEnv
queue_modenvptr	ds.l 1
	endif
queue_volenvptr	ds.l 1
queue_fminstptr	ds.l 1
queue_stacksize	ds.l 0
	dephase
	!org -
; ---------------------------------------------------------------------------
Sound_PlayBGM:
		move.l	v_dataptr(a1),a3
		moveq	#0,d0
		move.w	drvdata.bgm(a3),d0
		add.l	d0,a3
		;moveq	#0,d0				; x4
		move.w	d7,d0
		add.l	d0,d0
		add.l	d0,d0
		add.l	d0,a3

		move.b	(a3),d6
		move.l	(a3)+,d0
		add.l	d0,a3				; a3 now points to song header
; misc initiation
		clr.b	v_fadein_counter(a1)
		clr.b	v_fadeout_counter(a1)
; distinguish between main songs and jingles
	if __smpsJingle
		btst	#7,d6						; bit 23 is the "1up" song flag
		beq.s	.bgmnot1up
		bset	#v_driverflags.jingle,v_driverflags(a1)		; if 1up is already playing, branch
		bne.s	.bgm_loadJingle

		moveq_	$FF!(1<<_sfxoverride),d1

		set .val,v_music_pcm_tracks+TrackPlaybackControl
		rept (v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz
		and.b	d1,.val(a1)
		set .val,.val+TrackDacSz
		endr

		set .val,v_music_fm_tracks+TrackPlaybackControl
		rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		and.b	d1,.val(a1)
		set .val,.val+TrackFmSz
		endr

		set .val,v_music_psg_tracks+TrackPlaybackControl
		rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		and.b	d1,.val(a1)
		set .val,.val+TrackPsgSz
		endr

		lea	v_1up_save_ram(a1),a0
		lea	v_1up_ram_copy(a1),a2
		move.w	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d1
.backupramloop:	move.l	(a0)+,(a2)+
		dbf	d1,.backupramloop
		if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	(a0)+,(a2)+
		endif
		bra.s	.bgm_loadJingle
.bgmnot1up:
		bclr	#v_driverflags.jingle,v_driverflags(a1)
		beq.s	.bgm_loadMusic
		lea	v_1up_ram_copy(a1),a0
		moveq	#0,d0
		move.w	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d1
.saveclrloop:	move.l	d0,(a0)+
		dbf	d1,.saveclrloop
		if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	d0,(a0)+
		endif
	endif
.bgm_loadMusic:
.bgm_loadJingle:
		addq.w	#4,sp
		pea	HandleSoundQueueEnd(pc)
; setup PAL timer
		moveq	#5,d0
		btst	#6,d6					; bit 22 is the PAL slow play flag
		beq.s	.pal_playnorm
		moveq	#-1,d0
.pal_playnorm:	move.b	d0,v_paltimer(a1)

		move.l	v_dataptr(a1),a6
		moveq	#0,d0
		move.w	(a3)+,d0	; fm instruments
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.fmuvb
		move.l	a6,a0
		move.w	drvdata.uvbfm(a0),d0
.fmuvb:		add.l	d0,a0
		move.l	a0,-(sp)

		move.w	(a3)+,d0	; volume envelopes
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.volenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbvol(a0),d0
.volenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)

		move.w	(a3)+,d0	; modulation envelopes
	if __smpsModEnv
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.modenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbmod(a0),d0
.modenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)
	endif
		move.w	(a3)+,d0	; panning animations
	if __smpsPanEnv
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.panenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbpan(a0),d0
.panenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)
	endif
		move.l	sp,a6

		move.w	(a3)+,v_main_tempo(a1)
		clr.w	v_main_tempo_timeout(a1)

		move.b	(a3)+,d5				; load tempo divider
		btst	#5,d6
		sne.b	d6
		and.b	#1<<_nomuffle,d6			; enable muffle disable if bit 5 is set
		or.b	#1<<_playing,d6				; set playing regardless
		lea	3(a3),a4
; init allocated dac channels
		lea	v_music_pcm_tracks(a1),a5
		lea	DACInitBytes(pc),a2
	if __smpsPCM<>"MegaPCM2"
		moveq_	0<<7,d1					; disable DAC
	endif
		moveq	#0,d7
		move.b	(a3),d7
		beq.w	.dacdone
		if __smpsDebug
		cmp.w	#(v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz,d7
		bls.s	.as1
		SMPS_assert "Exceeding maximum BGM DAC channels"
.as1:
		endif
		subq.w	#1,d7
.dacloadloop:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits
		move.b	d6,d0
		or.b	(a2)+,d0
		or.b	d0,TrackPlaybackControl(a5)

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackDacSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackDacSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d5,TrackTempoDivider(a5)
	if __smpsSeqTimeSize
		move.w	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	else
		move.b	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	endif
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		move.w	#-1,TrackFreq(a5)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	(a4)+,TrackTranspose(a5)
		move.b	(a4)+,TrackVolume(a5)
		clr.b	TrackVolEnvCtrl(a5)
		move.b	queue_volenvptr+1(a6),TrackVolEnvPtr+1(a5)
		move.w	queue_volenvptr+2(a6),TrackVolEnvPtr+2(a5)
	if __smpsPanEnv
		move.b	queue_panenvptr+1(a6),TrackPanEnvPtr+1(a5)
		move.w	queue_panenvptr+2(a6),TrackPanEnvPtr+2(a5)
	endif
		move.b	#$C0,TrackAMSFMSPan(a5)			; Set AMS/FMS/Panning
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bsr.w	DACStopSample
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		moveq_	$C0,d1
		bsr.w	DACSetPan
		add.w	#TrackDacSz,a5
		dbf	d7,.dacloadloop
	if __smpsPCM<>"MegaPCM2"
		cmp.b	#6,1(a3)				; if FM6 isn't allocated, enable DAC
		slo	d1					; if it is, disable DAC
		and.b	#1<<7,d1				; it's probably safe but just to be extra safe
	endif
.dacdone:
	if __smpsPCM<>"MegaPCM2"
		moveq_	fmreg.dacen,d0
		bsr.w	WriteFMI
	endif
; mute remaining dac channels
		moveq	#(v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz-1,d7
		sub.b	(a3)+,d7
		bcs.s	.dacallon
.dacmute:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits
		addq.w	#1,a2
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bsr.w	DACStopSample				; TODO: all this doesn't check for SFX PCM
		add.w	#TrackDacSz,a5
		dbf	d7,.dacmute
.dacallon:
; init allocated fm channels
		lea	v_music_fm_tracks(a1),a5
		lea	FMInitBytes(pc),a2
		moveq	#0,d7
		move.b	(a3),d7
		beq.w	.fmdone
		if __smpsDebug
		cmp.w	#(v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz,d7
		bls.s	.as2
		SMPS_assert "Exceeding maximum BGM FM channels"
.as2:
		endif
		subq.w	#1,d7
.fmloadloop:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)
		move.b	d6,d0
		or.b	(a2)+,d0
		or.b	d0,TrackPlaybackControl(a5)

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackFmSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackFmSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d5,TrackTempoDivider(a5)
	if __smpsSeqTimeSize
		move.w	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	else
		move.b	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	endif
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		move.w	#-1,TrackFreq(a5)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	(a4)+,TrackTranspose(a5)
		move.b	(a4)+,TrackVolume(a5)
		clr.b	TrackVolEnvCtrl(a5)
		move.b	queue_volenvptr+1(a6),TrackVolEnvPtr+1(a5)
		move.w	queue_volenvptr+2(a6),TrackVolEnvPtr+2(a5)
	if __smpsModEnv
		move.b	queue_modenvptr+1(a6),TrackModEnvPtr+1(a5)
		move.w	queue_modenvptr+2(a6),TrackModEnvPtr+2(a5)
	endif
	if __smpsPanEnv
		move.b	queue_panenvptr+1(a6),TrackPanEnvPtr+1(a5)
		move.w	queue_panenvptr+2(a6),TrackPanEnvPtr+2(a5)
	endif
		move.b	queue_fminstptr+1(a6),TrackFmVoicePtr+1(a5)
		move.w	queue_fminstptr+2(a6),TrackFmVoicePtr+2(a5)
		move.b	#$F0,TrackFmOperators(a5)
		move.b	#$C0,TrackAMSFMSPan(a5)			; Set AMS/FMS/Panning
		bsr.w	FMSilence
		add.w	#TrackFmSz,a5
		dbf	d7,.fmloadloop
.fmdone:
; mute remaining fm channels
		moveq	#(v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz-1,d7
		sub.b	(a3)+,d7
		bcs.s	.fmallon
.fmmute:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits
		addq.w	#1,a2
		bsr.w	FMSilence
		add.w	#TrackFmSz,a5
		dbf	d7,.fmmute
.fmallon:
; init allocated psg channels
		lea	v_music_psg_tracks(a1),a5
		lea	PSGInitBytes(pc),a2
		moveq	#0,d7
		move.b	(a3),d7					; Load number of PSG tracks
		beq.w	.psgdone				; branch if zero
		if __smpsDebug
		cmp.w	#(v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz,d7
		bls.s	.as3
		SMPS_assert "Exceeding maximum BGM PSG channels"
.as3:
		endif
		subq.w	#1,d7
.psgloadloop:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)
		move.b	d6,d0
		or.b	(a2)+,d0
		or.b	d0,TrackPlaybackControl(a5)

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackPsgSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackPsgSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d5,TrackTempoDivider(a5)
	if (__smpsTarget=="md68k")&&(__smpsPCM=="DualPCM-FlexEd")
		equ .std,2
	else
		equ .std,1
	endif
	if __smpsSeqTimeSize
		move.w	#.std,TrackDurationTimeout(a5)		; Set duration of first "note"
	else
		move.b	#.std,TrackDurationTimeout(a5)		; Set duration of first "note"
	endif
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
	if __smpsDefaultFreq=0
		move.w	#0,TrackFreq(a5)	; max
	else
		move.w	#-1,TrackFreq(a5)
	endif
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	(a4)+,TrackTranspose(a5)
		move.b	(a4)+,TrackVolume(a5)
		move.b	(a4)+,TrackModulationCtrl(a5)
		move.b	(a4)+,TrackVolEnvCtrl(a5)
		move.b	queue_volenvptr+1(a6),TrackVolEnvPtr+1(a5)
		move.w	queue_volenvptr+2(a6),TrackVolEnvPtr+2(a5)
	if __smpsModEnv
		move.b	queue_modenvptr+1(a6),TrackModEnvPtr+1(a5)
		move.w	queue_modenvptr+2(a6),TrackModEnvPtr+2(a5)
	endif
		bsr.w	PSGNoteOff
		add.w	#TrackPsgSz,a5
		dbf	d7,.psgloadloop
.psgdone:
; mute remaining psg channels
		moveq	#(v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz-1,d7
		sub.b	(a3)+,d7
		bcs.s	.psgallon
.psgmute:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)
		addq.w	#1,a2
		bsr.w	PSGNoteOff
		add.w	#TrackPsgSz,a5
		dbf	d7,.psgmute
.psgallon:
	if (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz<4
		move.b	#$FF,(psginput).l
	endif
; alright we're done
		lea	queue_stacksize(sp),sp			; deallocate pointers
		rts
; ===========================================================================
	if __smpsJingle
Sound_PlaySFX_NoInit:
		clr.b	v_sndprio(a1)
	endif
Sound_PlaySFX_Exit:
		rts
Sound_PlaySFX_SameCSFX:
		move.b	7(a3),v_contsfx_loop(a1)		; set number of SFX tracks as the sfx loop
		rts
Sound_PlaySFX:
	if __smpsJingle
		btst	#v_driverflags.jingle,v_driverflags(a1)	; Is 1-up playing?
		bne.s	Sound_PlaySFX_NoInit	; Exit if so
	endif
		move.l	v_dataptr(a1),a3
		moveq	#0,d0
		move.w	drvdata.sfx(a3),d0
		add.l	d0,a3
		;moveq	#0,d0			; x4
		move.w	d7,d0
		add.l	d0,d0
		add.l	d0,d0
		add.l	d0,a3

		move.b	(a3)+,d0		; sfx priority
		beq.s	.noprio
		cmp.b	v_sndprio(a1),d0
		blo.s	Sound_PlaySFX_Exit
		move.b	d0,v_sndprio(a1)
.noprio:	move.b	(a3)+,d1		; commands
		moveq	#0,d0			; u16 offset relative to the end of the sound effects index
		move.b	(a3)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a3)+,d0
		add.l	d0,a3

		btst	#6,d1
		beq.s	.notcontsfx
		move.w	d7,d0
		addq.w	#1,d0
		cmp.w	v_contsfx_lastid(a1),d0
		beq.s	Sound_PlaySFX_SameCSFX
		move.w	d0,v_contsfx_lastid(a1)
		clr.b	v_contsfx_loop(a1)
.notcontsfx:
		move.l	v_dataptr(a1),a6
		moveq	#0,d0
		move.w	(a3)+,d0	; fm instruments
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.fmuvb
		move.l	a6,a0
		move.w	drvdata.uvbfm(a0),d0
.fmuvb:		add.l	d0,a0
		move.l	a0,-(sp)

		move.w	(a3)+,d0	; volume envelopes
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.volenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbvol(a0),d0
.volenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)

		move.w	(a3)+,d0	; modulation envelopes
	if __smpsModEnv
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.modenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbmod(a0),d0
.modenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)
	endif
		move.w	(a3)+,d0	; panning animations
	if __smpsPanEnv
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.panenvuvb
		move.l	a6,a0
		move.w	drvdata.uvbpan(a0),d0
.panenvuvb:	add.l	d0,a0
		move.l	a0,-(sp)
	endif
		move.l	sp,a6

		btst	#5,d1
		sne.b	d6
		and.b	#1<<_nomuffle,d6			; enable muffle disable if bit 5 is set
		or.b	#1<<_playing,d6				; set playing regardless
;		btst	#4,d1

		move.b	(a3)+,d5		; Dividing timing
		moveq	#0,d7
		move.b	(a3)+,d7		; Number of tracks (FM + PSG)
		subq.b	#1,d7
	if __smpsBSFX
		btst	#7,d1
		beq.w	Sound_PlaySFX_SFX
; ---------------------------------------------------------------------------
Sound_PlaySFX_BSFX:
.loadloop:
		move.b	(a3)+,d2				; Channel assignment bits
		smpsMakeChannelRamIndex d1,d2
		lea	RAM_BSFXChannel(pc),a5
		move.w	(a5,d1.w),d0
		bne.s	.validsfxch
		SMPS_assert "Invalid BSFX load, TODO print channel ID"
.validsfxch:
		move.l	a1,a5
		add.w	d0,a5

		lea	RAM_BGMChannel(pc),a2
		move.w	(a2,d1.w),d0
		beq.s	.nobgmequ
		move.l	a1,a2
		add.w	d0,a2
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nobgmequ:
;		lea	RAM_SFXChannel(pc),a2
;		move.w	(a2,d1.w),d0
;		beq.s	.nosfxequ
;		move.l	a1,a2
;		add.w	d0,a2
;		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
;.nosfxequ:
		bsr.w	Sound_PlaySFX_Setup
		dbf	d7,.loadloop
		lea	queue_stacksize(sp),sp			; deallocate pointers
		rts
	endif
; ---------------------------------------------------------------------------
Sound_PlaySFX_SFX:
.loadloop:
		move.b	(a3)+,d2				; Channel assignment bits
		smpsMakeChannelRamIndex d1,d2
		lea	RAM_SFXChannel(pc),a5
		move.w	(a5,d1.w),d0
		bne.s	.validsfxch
		SMPS_assert "Invalid SFX load, TODO print channel ID"
.validsfxch:
		move.l	a1,a5
		add.w	d0,a5

		lea	RAM_BGMChannel(pc),a2
		move.w	(a2,d1.w),d0
		beq.s	.nobgmequ
		move.l	a1,a2
		add.w	d0,a2
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nobgmequ:
	if __smpsBSFX
		lea	RAM_BSFXChannel(pc),a2
		move.w	(a2,d1.w),d0
		beq.s	.nossfxequ
		move.l	a1,a2
		add.w	d0,a2
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nossfxequ:
	endif
		bsr.s	Sound_PlaySFX_Setup
		dbf	d7,.loadloop
		lea	queue_stacksize(sp),sp			; deallocate pointers
		rts

Sound_PlaySFX_Setup:
		move.b	d2,d1
		add.b	d1,d1
		bcs.s	.dopsg
		bmi.s	.dodac
.dofm:
		moveq	#(TrackFmSz/2)-1,d1
		bsr.s	.do
		move.b	#$C0,TrackAMSFMSPan(a5)
	if __smpsPanEnv
		move.b	queue_panenvptr+1(a6),TrackPanEnvPtr+1(a5)
		move.w	queue_panenvptr+2(a6),TrackPanEnvPtr+2(a5)
	endif
		move.b	queue_fminstptr+1(a6),TrackFmVoicePtr+1(a5)
		move.w	queue_fminstptr+2(a6),TrackFmVoicePtr+2(a5)
		move.b	#$F0,TrackFmOperators(a5)
;		bra.w	FMSilence
		rts
.dodac:
		moveq	#(TrackDacSz/2)-1,d1
		bsr.s	.do
		move.b	#$C0,TrackAMSFMSPan(a5)
	if __smpsPanEnv
		move.b	queue_panenvptr+1(a6),TrackPanEnvPtr+1(a5)
		move.w	queue_panenvptr+2(a6),TrackPanEnvPtr+2(a5)
	endif
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
.dopsg:
		moveq	#(TrackPsgSz/2)-1,d1
		bsr.s	.do
	if __smpsDefaultFreq=0
		move.w	#0,TrackFreq(a5)	; max
	endif
	if (__smpsTarget=="md68k")&&(__smpsPCM=="DualPCM-FlexEd")
		equ .std,2
		if __smpsSeqTimeSize
		move.w	#.std,TrackDurationTimeout(a5)		; Set duration of first "note"
		else
		move.b	#.std,TrackDurationTimeout(a5)		; Set duration of first "note"
		endif
	endif
;		bra.w	PSGSilence
		cmp.b	#$C0,d2
		blo.s	.psg34
		move.b	#$DF,(psginput).l
		move.b	#$FF,(psginput).l
.psg34:
		rts

.do:
		move.l	a5,a2
		moveq	#0,d0
.doclr:		move.w	d0,(a2)+
		dbf	d1,.doclr

		move.b	d6,TrackPlaybackControl(a5)
		move.b	d2,TrackVoiceControl(a5)
		move.b	(a3)+,TrackTranspose(a5)
		move.b	(a3)+,TrackVolume(a5)
		;moveq	#0,d0					; Track data pointer, relative to start
		move.b	(a3)+,d0				; u8
		add.l	a3,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	d5,TrackTempoDivider(a5)		; Initial voice control bits
	if __smpsSeqTimeSize
		move.w	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	else
		move.b	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
	endif
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		move.w	#-1,TrackFreq(a5)
		move.b	queue_volenvptr+1(a6),TrackVolEnvPtr+1(a5)
		move.w	queue_volenvptr+2(a6),TrackVolEnvPtr+2(a5)
	if __smpsModEnv
		move.b	queue_modenvptr+1(a6),TrackModEnvPtr+1(a5)
		move.w	queue_modenvptr+2(a6),TrackModEnvPtr+2(a5)
	endif
		rts