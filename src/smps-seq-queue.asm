CycleSoundQueue:
		lea	v_soundqueue0(a6),a0		; load music track number
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
		move.l	v_dataptr(a6),a1
	if drvdata.bgmcnt<>0
		lea	drvdata.bgmcnt(a1),a1
	endif
		subq.w	#1,d7
		cmp.w	(a1),d7				; Is this music?
		blo.w	Sound_PlayBGM			; Branch if yes

		sub.w	(a1)+,d7			; move to sfxcnt
		cmp.w	(a1),d7				; Is this sfx?
		blo.w	Sound_PlaySFX			; Branch if yes

		sub.w	(a1)+,d7			; move to pcmcnt
		cmp.w	(a1),d7				; Is this pcm?
		blo.w	Sound_PlayPCM			; Branch if yes
		rts
; ---------------------------------------------------------------------------
Cmd_FadeOutMusicStopSFX:
		move.w	d7,-(sp)
		bsr.w	StopSFX
	if __smpsBFX=1
		bsr.w	StopBSFX
	endif
		move.w	(sp)+,d7

Cmd_FadeOutMusic:
		move.b	d7,v_fadeout_counter(a6)
		rts
; ---------------------------------------------------------------------------
Cmd_FadeIn:
		move.b	d7,v_fadein_counter(a6)
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
; ---------------------------------------------------------------------------
Cmd_StopSound:
	if __smpsBFX=1
		cmp.b	#1<<3,d7
	else
		cmp.b	#1<<2,d7
	endif
		blo.s	.valid
		SMPS_assert "Invalid channel stop command, TODO: print bitfield"
.valid:
		tst.b	d7
		beq.w	StopAllSound
		btst	#0,d7
		beq.s	.notbgm
		bsr.w	StopBGM
.notbgm:
		btst	#1,d7
		beq.s	.notsfx
		bsr.w	StopSFX
.notsfx:
	if __smpsBFX=1
		btst	#2,d7
		beq.s	.notbsfx
		bsr.w	StopBSFX
.notbsfx:
	endif
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
.clr:		bclr	d1,(a6,d0.w)
		bne.s	.ack
		rts
.set:		bset	d1,(a6,d0.w)
		beq.s	.ack
		rts
.ack:		move.w	(a2)+,d0
		jmp	.table(pc,d0.w)
.table:
		dc.w 1<<13|v_driverflags,Cmd_SetBitFlag_Speed-.table	; 0 ; tempo speedup
		dc.w 5<<13|v_driverflags,Cmd_SetBitFlag_Mono-.table	; 2 ; stereo/mono
		dc.w 4<<13|v_driverflags,Cmd_SetBitFlag_SSG-.table	; 4 ; SSG-EG
		dc.w 7<<13|v_driverflags2,Cmd_SetBitFlag_Muffle-.table	; 6 ; water muffle
.tend:

Cmd_SetBitFlag_Speed:
		rts

Cmd_SetBitFlag_Mono:
		lea	v_music_dac_tracks(a6),a5
		moveq	#((v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz)-1,d7
		bsr.s	.dacloop
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.fmloop
		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		if __smpsBFX=1
		bsr.s	.fmloop
		lea	v_spcsfx_fm_tracks(a6),a5
		moveq	#((v_spcsfx_fm_tracks_end-v_spcsfx_fm_tracks)/TrackFmSz)-1,d7
		endif
.fmloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.fmnext
		moveq_	$B4,d0
		move.b	TrackAMSFMSPan(a5),d1
		btst	#5,v_driverflags(a6)
		beq.s	.fmstereo
		or.b	#$C0,d1				; force mono
.fmstereo:	bsr.w	WriteFMIorII
.fmnext:	lea	TrackFmSz(a5),a5
		dbf	d7,.fmloop
		rts
.dacloop:
		moveq_	1<<_playing|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		cmp.b	#1<<_playing|0<<_sfxoverride,d0
		bne.s	.dacnext
		moveq_	$B4,d0
		move.b	TrackAMSFMSPan(a5),d1
		btst	#5,v_driverflags(a6)
		beq.s	.dacstereo
		or.b	#$C0,d1				; force mono
.dacstereo:	move.b	d1,d0
		bsr.w	DACSetPan
.dacnext:	lea	TrackDacSz(a5),a5
		dbf	d7,.dacloop
		rts

Cmd_SetBitFlag_SSG:
		lea	v_music_fm_tracks(a6),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		bsr.s	.loop
		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		if __smpsBFX=1
		bsr.s	.loop
		lea	v_spcsfx_fm_tracks(a6),a5
		moveq	#((v_spcsfx_fm_tracks_end-v_spcsfx_fm_tracks)/TrackFmSz)-1,d7
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
		lea	v_sfx_fm_tracks(a6),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_sfx_psg_tracks(a6),a5
		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/TrackPsgSz)-1,d7
		moveq	#TrackPsgSz,d6
		bsr.s	.fade
	if __smpsBFX=1
		lea	v_spcsfx_fm_tracks(a6),a5
		moveq	#((v_spcsfx_fm_tracks_end-v_spcsfx_fm_tracks)/TrackFmSz)-1,d7
		moveq	#TrackFmSz,d6
		bsr.s	.fade
		lea	v_spcsfx_psg_tracks(a6),a5
		moveq	#((v_spcsfx_psg_tracks_end-v_spcsfx_psg_tracks)/TrackPsgSz)-1,d7
		moveq	#TrackPsgSz,d6
		bsr.s	.fade
	endif
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
Sound_PlayPCM:
		add.w	#$81,d7
		move.w	d7,d0
		bra.w	DACQueueSampleSFX
; ===========================================================================
DACInitBytes:	dc.b $40, $41
; notice the 0, 1, 2 then 4, 5, 6
; this is the gap between parts I and II for YM2612 port writes
FMInitBytes:	dc.b 0, 1, 2, 4, 5, 6
; Specifically, these configure writes to the PSG port for each channel
PSGInitBytes:	dc.b $80, $A0, $C0, $E0
	even
; ===========================================================================
Sound_PlayBGM:
		move.l	v_dataptr(a6),a3
		moveq	#0,d0
		move.w	drvdata.bgm(a3),d0
		add.l	d0,a3
		;moveq	#0,d0				; x4
		move.w	d7,d0
		add.l	d0,d0
		add.l	d0,d0
		move.l	a3,a4
		add.l	d0,a4

		move.b	(a4),d1
		move.l	(a4),d0
		add.l	d0,a3				; a3 now points to song header

		move.b	#5,v_paltimer(a6)
		btst	#6,d1				; bit 22 is the PAL slow play flag
		beq.s	.pal_playnorm
		st.b	v_paltimer(a6)
.pal_playnorm:
	if __smpsJingle=1
		btst	#7,d1				; bit 23 is the "1up" song flag
		beq.s	.bgmnot1up
		bset	#0,v_driverflags(a6)		; if 1up is already playing, branch
		bne.s	.bgm_loadMusic

		moveq_	$FF!(1<<_sfxoverride),d2
	set .val,v_music_dac_tracks+TrackPlaybackControl
	rept (v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz
		and.b	d2,.val(a6)
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackPlaybackControl
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		and.b	d2,.val(a6)
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackPlaybackControl
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		and.b	d2,.val(a6)
	set .val,.val+TrackPsgSz
	endr

		lea	v_1up_save_ram(a6),a0
		lea	v_1up_ram_copy(a6),a1
		moveq	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d2
.backupramloop:	move.l	(a0)+,(a1)+
		dbf	d2,.backupramloop
		if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	(a0)+,(a1)+
		endif
		bra.s	.bgm_loadMusic
.bgmnot1up:
		bclr	#0,v_driverflags(a6)
		beq.s	.bgm_loadMusic
		lea	v_1up_ram_copy(a6),a0
		moveq	#0,d0
		moveq	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d2
.saveclrloop:	move.l	d0,(a0)+
		dbf	d2,.saveclrloop
		if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	d0,(a0)+
		endif
.bgm_loadMusic:
	endif
		clr.b	v_fadein_counter(a6)
		clr.b	v_fadeout_counter(a6)
; start going through the header
		moveq	#0,d3		; fm instruments
		move.w	(a3)+,d3
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.fmuvb
		move.l	v_dataptr(a6),a0
		move.w	drvdata.uvbfm(a0),d3
.fmuvb:		add.l	a0,d3

		moveq	#0,d0		; volume envelopes
		move.w	(a3)+,d0
		move.l	a3,a1		; doesn't effect ccr
		bne.s	.volenvuvb
		move.l	v_dataptr(a6),a1
		move.w	drvdata.uvbvol(a1),d0
.volenvuvb:	add.l	d0,a1

		move.w	(a3)+,d0
		move.w	d0,v_main_tempo(a6)
		and.w	#$FFF0,d0
		move.w	d0,v_main_tempo_timeout(a6)

		move.b	(a3)+,d4				; load tempo divider
		moveq	#1,d5					; Note duration for first "note"
		moveq_	1<<_playing,d6
		btst	#5,d1
		beq.s	.ctrlinit
		moveq_	1<<_playing|1<<_nouservol,d6
.ctrlinit:
		lea	3(a3),a4

; init allocated dac channels
		lea	v_music_dac_tracks(a6),a5
		lea	DACInitBytes(pc),a2
	if __smpsPCM<>"MegaPCM2"
		moveq_	0<<7,d1					; disable DAC
	endif
		moveq	#0,d7
		move.b	(a3),d7
		beq.w	.dacdone
		if __smpsDebug
		cmp.w	#(v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz,d7
		bls.s	.as1
		SMPS_assert "Exceeding maximum BGM DAC channels"
.as1:
		endif
		subq.w	#1,d7
.dacloadloop:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		or.b	d6,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackDacSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackDacSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d4,TrackTempoDivider(a5)
		move.b	d5,TrackDurationTimeout(a5)		; Set duration of first "note"
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	(a4)+,TrackTranspose(a5)
		move.b	(a4)+,TrackVolume(a5)

		move.l	a1,d0
		move.w	d0,TrackVolEnvPtr+2(a5)
		swap	d0
		move.b	d0,TrackVolEnvPtr+1(a5)
		clr.b	TrackVolEnvCtrl(a5)

		move.b	#$C0,TrackAMSFMSPan(a5)			; Set AMS/FMS/Panning
		bsr.w	DACStopSample				; TODO: all this doesn't check for SFX PCM
		move.b	TrackAMSFMSPan(a5),d0
		btst	#5,v_driverflags(a6)
		beq.s	.dacstereo
		or.b	#$C0,d0
.dacstereo:	bsr.w	DACSetPan

		add.w	#TrackDacSz,a5
		dbf	d7,.dacloadloop
	if __smpsPCM<>"MegaPCM2"
		cmp.b	#6,1(a3)				; if FM6 isn't allocated, enable DAC
		slo	d1					; if it is, disable DAC
		and.b	#1<<7,d1				; it's probably safe but just to be extra safe
	endif
.dacdone:
	if __smpsPCM<>"MegaPCM2"
		moveq_	$2B,d0
		bsr.w	WriteFMI
	endif
; mute remaining dac channels
		moveq	#(v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz-1,d7
		sub.b	(a3)+,d7
		bcs.s	.dacallon
.dacmute:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits
		bsr.w	DACStopSample				; TODO: all this doesn't check for SFX PCM
		add.w	#TrackDacSz,a5
		dbf	d7,.dacmute
.dacallon:
; init allocated fm channels
		lea	v_music_fm_tracks(a6),a5
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
		or.b	d6,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackFmSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackFmSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d4,TrackTempoDivider(a5)
		move.b	d5,TrackDurationTimeout(a5)		; Set duration of first "note"
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		moveq	#0,d0
		move.w	(a4)+,d0
		add.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	(a4)+,TrackTranspose(a5)
		move.b	(a4)+,TrackVolume(a5)

		move.l	a1,d0
		move.w	d0,TrackVolEnvPtr+2(a5)
		swap	d0
		move.b	d0,TrackVolEnvPtr+1(a5)
		clr.b	TrackVolEnvCtrl(a5)

		move.b	#$C0,TrackAMSFMSPan(a5)			; Set AMS/FMS/Panning
		move.l	d3,d0
		move.w	d0,TrackFmVoicePtr+2(a5)
		swap	d0
		move.b	d0,TrackFmVoicePtr+1(a5)

		movem.l	a0/d2-d3,-(sp)
		bsr.w	FMSilence
		moveq_	$B4,d0					; Register for AMS/FMS/Panning
		move.b	TrackAMSFMSPan(a5),d1			; Value to send
		btst	#5,v_driverflags(a6)
		beq.s	.fmstereo
		or.b	#$C0,d1
.fmstereo:	bsr.w	WriteFMIorII
		movem.l	(sp)+,a0/d2-d3

		add.w	#TrackFmSz,a5
		dbf	d7,.fmloadloop
.fmdone:
; mute remaining fm channels
		moveq	#(v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz-1,d7
		sub.b	(a3)+,d7
		bcs.s	.fmallon
.fmmute:	and.b	#1<<_sfxoverride,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)		; Voice control bits
		movem.l	a0/d2-d3,-(sp)
		bsr.w	FMSilence
		movem.l	(sp)+,a0/d2-d3
		add.w	#TrackFmSz,a5
		dbf	d7,.fmmute
.fmallon:
; init allocated psg channels
		lea	v_music_psg_tracks(a6),a5
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
		or.b	d6,TrackPlaybackControl(a5)
		move.b	(a2)+,TrackVoiceControl(a5)

		moveq	#0,d0
		lea	TrackVoiceControl+1(a5),a0
	rept (TrackPsgSz-(TrackVoiceControl+1))/4
		move.l	d0,(a0)+
	endr
	if (TrackPsgSz-(TrackVoiceControl+1))&2
		move.w	d0,(a0)+
	endif

		move.b	d4,TrackTempoDivider(a5)
		move.b	d5,TrackDurationTimeout(a5)		; Set duration of first "note"
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
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

		move.l	a1,d0
		move.w	d0,TrackVolEnvPtr+2(a5)
		swap	d0
		move.b	d0,TrackVolEnvPtr+1(a5)

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
		bsr.w	PSGNoteOff
		add.w	#TrackPsgSz,a5
		dbf	d7,.psgmute
.psgallon:
		addq.w	#4,sp
		bra.w	HandleSoundQueueEnd
; ===========================================================================
	if __smpsJingle=1
Sound_PlaySFX_NoInit:
		clr.b	v_sndprio(a6)
	endif
Sound_PlaySFX_Exit:
		rts
Sound_PlaySFX_SameCSFX:
		move.b	5(a3),v_contsfx_loop(a6)		; set number of SFX tracks as the sfx loop
		rts
Sound_PlaySFX:
	if __smpsJingle=1
		btst	#0,v_driverflags(a6)	; Is 1-up playing?
		bne.s	Sound_PlaySFX_NoInit	; Exit if so
	endif
		move.l	v_dataptr(a6),a3
		moveq	#0,d0
		move.w	drvdata.sfx(a3),d0
		add.l	d0,a3
		;moveq	#0,d0			; x3
		move.w	d7,d0
		move.l	d0,d1
		add.l	d1,d0
		add.l	d1,d0
		move.l	a3,a4
		add.l	d0,a4

		move.b	(a4)+,d1		; u8 commands
		moveq	#0,d0			; u16 offset
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		add.l	d0,a3			; SFX data pointer

		moveq	#$3F,d0
		and.b	d1,d0
		beq.s	.noprio
		cmp.b	v_sndprio(a6),d0
		blo.s	Sound_PlaySFX_Exit
		move.b	d0,v_sndprio(a6)
.noprio:
		btst	#6,d1
		beq.s	.notcontsfx
		move.w	d7,d0
		addq.w	#1,d0
		cmp.w	v_contsfx_lastid(a6),d0
		beq.s	Sound_PlaySFX_SameCSFX
		move.w	d0,v_contsfx_lastid(a6)
		clr.b	v_contsfx_loop(a6)
.notcontsfx:
		moveq	#0,d0		; fm instruments
		move.w	(a3)+,d0
		move.l	a3,a0		; doesn't effect ccr
		bne.s	.fmuvb
		move.l	v_dataptr(a6),a0
		move.w	drvdata.uvbfm(a0),d0
.fmuvb:		add.l	d0,a0
	
		moveq	#0,d0		; volume envelopes
		move.w	(a3)+,d0
		move.l	a3,a1		; doesn't effect ccr
		bne.s	.volenvuvb
		move.l	v_dataptr(a6),a1
		move.w	drvdata.uvbvol(a1),d0
.volenvuvb:	add.l	d0,a1

		move.b	(a3)+,d5		; Dividing timing
		moveq	#0,d7
		move.b	(a3)+,d7		; Number of tracks (FM + PSG)
		subq.b	#1,d7
	if __smpsBFX=1
		btst	#7,d1
		bne.w	Sound_PlaySFX_BSFX
	endif
; ---------------------------------------------------------------------------
.loadloop:
		moveq	#0,d3
		move.b	(a3),d3			; Channel assignment bits
		move.b	d3,d4
		bmi.s	.initpsg		; Branch if PSG
		add.b	d3,d3
		bpl.s	.initfm
		add.w	#((30/2)-$40)*2,d3
		bra.s	.initdac
.initpsg:
		lsr.w	#3,d3
; TODO: hackish PSG3 fix
		cmpi.b	#$C0,d4
		bne.s	.init
		move.b	#$DF,(psginput).l
		move.b	#$FF,(psginput).l
.initfm:
.initdac:
.init:
		lea	RAM_SFXChannel(pc),a5
		move.w	(a5,d3.w),d0
		bne.s	.validsfxch
		if __smpsDebug
		SMPS_assert "Invalid SFX load, TODO print channel ID"
		else
		addq.w	#6,a3		; invalid channel, skip
		bra.s	.nop
		endif
.validsfxch:
		move.l	a6,a5
		add.w	d0,a5

		lea	RAM_BGMChannel(pc),a2
		move.w	(a2,d3.w),d0
		beq.s	.nobgmequ
		move.l	a6,a2
		add.w	d0,a2
		tst.b	TrackPlaybackControl(a2)
		bpl.s	.nobgmequ
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nobgmequ:
	if __smpsBFX=1
		lea	RAM_BSFXChannel(pc),a2
		move.w	(a2,d3.w),d0
		beq.s	.nossfxequ
		move.l	a6,a2
		add.w	d0,a2
		tst.b	TrackPlaybackControl(a2)
		bpl.s	.nossfxequ
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nossfxequ:
	endif
		bsr.s	Sound_PlaySFX_Setup
		dbf	d7,.loadloop
.nop:
		rts

Sound_PlaySFX_Setup:
		add.b	d4,d4
		bcs.s	.dopsg
		bpl.s	.dofm
.dodac:
		move.l	a5,a2
		moveq	#0,d0
		moveq	#(TrackDacSz/2)-1,d1
.dodac2:	move.w	d0,(a2)+
		dbf	d1,.dodac2
		bsr.s	.do

		move.b	#$C0,TrackAMSFMSPan(a5)
		bsr.w	DACStopSample
		move.b	TrackAMSFMSPan(a5),d0
		btst	#5,v_driverflags(a6)
		beq.s	.dacstereo
		or.b	#$C0,d0
.dacstereo:	bsr.w	DACSetPan
		rts

.dopsg:
		move.l	a5,a2
		moveq	#0,d0
		moveq	#(TrackPsgSz/2)-1,d1
.dopsg2:	move.w	d0,(a2)+
		dbf	d1,.dopsg2
		bra.s	.do

.dofm:
		move.l	a5,a2
		moveq	#0,d0
		moveq	#(TrackFmSz/2)-1,d1
.dofm2:		move.w	d0,(a2)+
		dbf	d1,.dofm2
		bsr.s	.do

		move.b	#$C0,TrackAMSFMSPan(a5)
		move.l	a0,d0
		move.w	d0,TrackFmVoicePtr+2(a5)
		swap	d0
		move.b	d0,TrackFmVoicePtr+1(a5)

		movem.l	a0/d2,-(sp)
		moveq_	$B4,d0					; Register for AMS/FMS/Panning
		move.b	TrackAMSFMSPan(a5),d1			; Value to send
		btst	#5,v_driverflags(a6)
		beq.s	.fmstereo
		or.b	#$C0,d1
.fmstereo:	bsr.w	WriteFMIorII
		movem.l	(sp)+,a0/d2
		rts
.do:
		move.b	#1<<_playing,TrackPlaybackControl(a5)
		move.b	(a3)+,TrackVoiceControl(a5)
		move.b	(a3)+,TrackTranspose(a5)
		move.b	(a3)+,TrackVolume(a5)
		moveq	#0,d0					; Track data pointer, relative to start
		move.b	(a3)+,d0				; u8
		add.l	a3,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	d5,TrackTempoDivider(a5)		; Initial voice control bits
		move.b	#1,TrackDurationTimeout(a5)		; Set duration of first "note"
		move.b	#TrackGoSubStack,TrackStackPointer(a5)
		move.l	a1,d0
		move.w	d0,TrackVolEnvPtr+2(a5)
		swap	d0
		move.b	d0,TrackVolEnvPtr+1(a5)
		rts
; ---------------------------------------------------------------------------
	if __smpsBFX=1
Sound_PlaySFX_BSFX:
.loadloop:
		moveq	#0,d3
		move.b	(a3),d3			; Channel assignment bits
		move.b	d3,d4
		bmi.s	.initpsg		; Branch if PSG
		add.b	d3,d3
		bpl.s	.initfm
		add.w	#((30/2)-$40)*2,d3
		bra.s	.initdac
.initpsg:
		lsr.w	#3,d3
; TODO: hackish PSG3 fix
		cmpi.b	#$C0,d4
		bne.s	.init
		move.b	#$DF,(psginput).l
		move.b	#$FF,(psginput).l
.initfm:
.initdac:
.init:
		lea	RAM_BSFXChannel(pc),a5
		move.w	(a5,d3.w),d0
		bne.s	.validsfxch
		if __smpsDebug
		SMPS_assert "Invalid BSFX load, TODO print channel ID"
		else
		addq.w	#6,a3		; invalid channel, skip
		bra.s	.nop
		endif
.validsfxch:
		move.l	a6,a5
		add.w	d0,a5

		lea	RAM_BGMChannel(pc),a2
		move.w	(a2,d3.w),d0
		beq.s	.nobgmequ
		move.l	a6,a2
		add.w	d0,a2
		tst.b	TrackPlaybackControl(a2)
		bpl.s	.nobgmequ
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nobgmequ:
		lea	RAM_SFXChannel(pc),a2
		move.w	(a2,d3.w),d0
		beq.s	.nosfxequ
		move.l	a6,a2
		add.w	d0,a2
		tst.b	TrackPlaybackControl(a2)
		bpl.s	.nosfxequ
		or.b	#1<<_sfxoverride,TrackPlaybackControl(a2)
.nosfxequ:
		bsr.w	Sound_PlaySFX_Setup
.nop:
		dbf	d7,.loadloop
		rts
	endif