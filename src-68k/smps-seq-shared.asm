StopAllSound:
.startaddr	= v_startofvariables
.endaddr	= v_endofvariables
.clrLen		= .endaddr-.startaddr
		lea	.startaddr(a1),a2
		moveq	#0,d0
		move.w	#(.clrLen)/4-1,d1
.clrLoop:	move.l	d0,(a2)+
		dbf	d1,.clrLoop
	if (.clrLen)&2
		move.w	d0,(a2)+
	endif
	if (.clrLen)&1
		move.b	d0,(a2)+
	endif
		moveq_	$FF!(1<<v_driverflags.speedsong|1<<v_driverflags.jingle),d0
		and.b	v_driverflags(a1),d0
		move.b	d0,v_driverflags(a1)
.skipram:
		bsr.w	StopCDDA
		bsr.w	DACStopSample			; TODO: DACStopAll
		bsr.w	FMSilenceAll
		bra.w	PSGSilenceAll
; ===========================================================================
StopBGM:
		lea	v_music_pcm_tracks(a1),a5
		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d6
.dacloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.dacnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bsr.w	DACStopSample
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
		add.w	#((30/2)-$40)*2,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBSFX
		move.w	(a3,d3.w),d0
		beq.s	.dacgetptr
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.dacgotptr
.dacgetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.dacnext
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.dacnext
.dacgotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
.dacnext:
		dbf	d6,.dacloop


		lea	v_music_fm_tracks(a1),a5
		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d6
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.fmnext
		and.b	#$FF!(1<<_playing|1<<_noattack),TrackPlaybackControl(a5)
		bsr.w	FMSilence
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBSFX
		move.w	(a3,d3.w),d0
		beq.s	.fmgetptr
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.fmgotptr
.fmgetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.fmnext
		move.l	a1,a3
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


		lea	v_music_psg_tracks(a1),a5
		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d6
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.psgnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		lsr.b	#3,d3
		lea	RAM_SFXChannel(pc),a3
	if __smpsBSFX
		move.w	(a3,d3.w),d0
		beq.s	.psggetptr
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
		lea	RAM_BSFXChannel(pc),a3
	endif
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop

		rts
; ===========================================================================
StopSFX:
		clr.b	v_sndprio(a1)
		btst	#v_driverflags.jingle,v_driverflags(a1)
		bne.w	.exit

		lea	v_sfx_fm_tracks(a1),a5
		moveq	#((v_sfx_fm_tracks_end-v_sfx_fm_tracks)/TrackFmSz)-1,d6
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.fmnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	FMSilence
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		add.b	d3,d3
	if __smpsBSFX
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.fmgetptr
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bmi.s	.fmgotptr
.fmgetptr:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
	 	beq.s	.fmnext
		move.l	a1,a3
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


		lea	v_sfx_psg_tracks(a1),a5
		moveq	#((v_sfx_psg_tracks_end-v_sfx_psg_tracks)/TrackPsgSz)-1,d6
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.psgnext
		and.b	#$FF!(1<<_playing),TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		moveq	#0,d3
		move.b	TrackVoiceControl(a5),d3
		lsr.b	#3,d3
	if __smpsBSFX
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psggetptr
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop
.exit:
		rts
		if __smpsBSFX
; ===========================================================================
StopBSFX:
		btst	#v_driverflags.jingle,v_driverflags(a1)
		bne.w	.exit
		lea	v_bsfx_fm_tracks(a1),a5
		moveq	#((v_bsfx_fm_tracks_end-v_bsfx_fm_tracks)/TrackFmSz)-1,d6
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
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
	 	bmi.s	.fmgotptr
.fmgetptr:
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
	 	beq.s	.fmnext
		move.l	a1,a3
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


		lea	v_bsfx_psg_tracks(a1),a5
		moveq	#((v_bsfx_psg_tracks_end-v_bsfx_psg_tracks)/TrackPsgSz)-1,d6
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
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.psggotptr
.psggetptr:
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.psgnext
		move.l	a1,a3
		add.w	d0,a3
		and.b	#$FF!(1<<_sfxoverride),TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)
		bpl.s	.psgnext
.psggotptr:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
.psgnext:
		add.w	#TrackPsgSz,a5
		dbf	d6,.psgloop
.exit:
		rts
		endif
; ===========================================================================
; INPUT
; d5.w = duration (expected to be between $01-$7F)
SetDuration:
	if __smpsDebug
		tst.w	d5
		bne.s	.durationisntzero
		SMPS_assert "SetDuration: Time is $00, TODO print extra data"
.durationisntzero:
		cmp.w	#$7F,d5
		bls.s	.durationgood
		SMPS_assert "SetDuration: Time exceeds $7F, TODO print extra data"
.durationgood:
	endif
		clr.w	d1
		move.b	TrackTempoDivider(a5),d1			; Get dividing timing
	if __smpsDebug
		bne.s	.mulisntzero
		SMPS_assert "SetDuration: Multiplier is $00, TODO print extra data"
.mulisntzero:
	endif
		mulu.w	d1,d5
	if __smpsDebug
		move.w	d5,d1
		clr.b	d1
		tst.w	d1
		beq.s	.mulgood
		SMPS_assert "SetDuration: Time x Multiplier exceeds $FF, TODO print extra data"
.mulgood:
	endif
		move.b	d5,TrackSavedDuration(a5)			; Save duration
		move.b	d5,TrackDurationTimeout(a5)			; Save duration timeout
		rts
; ===========================================================================
PCMFinishTrackUpdate:
		move.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	TrackSavedDuration(a5),TrackDurationTimeout(a5)	; Reset note timeout
		moveq	#1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.exit
		move.b	TrackNoteTimeoutMaster(a5),TrackNoteTimeout(a5)	; Reset note fill timeout
		clr.b	TrackVolEnvIndex(a5)				; Reset volume envelope index
.exit:		rts
PSGFinishTrackUpdate:
FMFinishTrackUpdate:
		move.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	TrackSavedDuration(a5),TrackDurationTimeout(a5)	; Reset note timeout
		moveq	#1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.exit
		move.b	TrackNoteTimeoutMaster(a5),TrackNoteTimeout(a5)	; Reset note fill timeout
		clr.b	TrackVolEnvIndex(a5)				; Reset volume envelope index
	if __smpsModEnv
		clr.b	TrackModEnvIndex(a5)
;		clr.b	TrackModEnvMultiply(a5)				; umm what the sigma
	endif
		tst.b	TrackModulationCtrl(a5)
		bpl.s	.nomod
		cmp.b	#1<<7|1,TrackModulationCtrl(a5)			; if using Z80 mod algo and resting, don't set anything
		bne.s	.yesmod
		btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.z80mod
.yesmod:
		move.l	TrackModulationPtr(a5),a0			; Modulation data pointer
		move.b	(a0)+,TrackModulationWait(a5)			; Reset wait
		move.b	(a0)+,TrackModulationSpeed(a5)			; Reset speed
		move.b	(a0)+,TrackModulationDelta(a5)			; Reset delta
		move.b	(a0)+,d0					; Get steps
		lsr.b	#1,d0						; Halve them
		move.b	d0,TrackModulationSteps(a5)			; Then store
		clr.w	TrackModulationVal(a5)				; Reset frequency change
.nomod:
.exit:		rts
.z80mod:
;		clr.b	TrackModulationSpeed(a5)			; Clear ModEnvIndex (shared with ModAlgoSpeed)
;		clr.b	TrackModulationVal+1(a5)			; Clear ModEnvMul (shared with LSB of ModAlgoVal)
		rts
; ===========================================================================
NoteTimeoutUpdate:
		subq.b	#1,TrackNoteTimeout(a5)			; Update note fill timeout
		bcs.s	.already				; if already expired or not set to run, branch
		bne.s	.exit					; if not yet expired, branch
		addq.w	#4,sp					; Do not return to caller
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit
		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bcs.w	SendPSGNoteOff
		bpl.w	FMNoteOff				; also checks for noattack
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
.already:	clr.b	TrackNoteTimeout(a5)			; make sure it doesn't overflow
.exit:		rts
; ===========================================================================
StartModulation:
		moveq	#0,d0
		move.b	TrackModulationCtrl(a5),d0
		bpl.s	.locret
		if __smpsDebug
		cmp.b	#1<<7|2,d0
		bls.s	.valid
		SMPS_assert "StartModulation: Invalid modalgo id; TODO: print id"
.valid:
		endif
		add.b	d0,d0					; remove sign bit
		add.w	d0,d0
		jmp	.lut(pc,d0.w)
.locret:
		rts
.lut:
		bra.w	ModAlgo_Null
		bra.w	ModAlgo_Z80
		bra.w	ModAlgo_68K
DoModulation:
		moveq	#0,d0
		move.b	TrackModulationCtrl(a5),d0
		bpl.s	.locret
		if __smpsDebug
		cmp.b	#1<<7|2,d0
		bls.s	.valid
		SMPS_assert "DoModulation: Invalid modalgo id; TODO: print id"
.valid:
		endif
		add.b	d0,d0					; remove sign bit
		add.w	d0,d0
		jmp	.lut(pc,d0.w)
.locret:
		rts
.lut:
		bra.w	ModAlgo_68K
		bra.w	ModAlgo_Z80
		bra.w	ModAlgo_68K
; ---------------------------------------------------------------------------
ModAlgo_68K:
		subq.b	#1,TrackModulationWait(a5)		; Has modulation wait expired?
		bcc.s	.locret					; If not, exit
		clr.b	TrackModulationWait(a5)			; Make sure wait doesn't overflow

		subq.b	#1,TrackModulationSpeed(a5)		; Update speed
		bne.s	.locret					; If it expired, want to update modulation
		move.l	TrackModulationPtr(a5),a0		; Get modulation data
		move.b	1(a0),TrackModulationSpeed(a5)		; Restore modulation speed
		tst.b	TrackModulationSteps(a5)		; Check number of steps
		bne.s	.calcfreq				; If nonzero, branch
		move.b	3(a0),TrackModulationSteps(a5)		; Restore from modulation data
		neg.b	TrackModulationDelta(a5)		; Negate modulation delta
.locret:
		rts
.calcfreq:
		subq.b	#1,TrackModulationSteps(a5)		; Update modulation steps
		move.b	TrackModulationDelta(a5),d6		; Get modulation delta
		ext.w	d6
		add.w	d6,TrackModulationVal(a5)		; Add to cumulative modulation change
ModAlgo_Null:
		rts
; ---------------------------------------------------------------------------
ModAlgo_Z80:
		subq.b	#1,TrackModulationWait(a5)		; Has modulation wait expired?
		bne.s	.locret					; If not, exit
		addq.b	#1,TrackModulationWait(a5)		; Make sure wait doesn't overflow

		move.l	TrackModulationPtr(a5),a0		; Get modulation data
		subq.b	#1,TrackModulationSpeed(a5)		; Update speed
		bne.s	.modsust				; If it expired, want to update modulation
		move.b	1(a0),TrackModulationSpeed(a5)		; Restore modulation speed
		move.b	TrackModulationDelta(a5),d6		; Get modulation delta
		ext.w	d6
		add.w	d6,TrackModulationVal(a5)		; Add to cumulative modulation change
.modsust:
		subq.b	#1,TrackModulationSteps(a5)		; Check number of steps
		bne.s	.locret					; If nonzero, branch
		move.b	3(a0),TrackModulationSteps(a5)		; Restore from modulation data
		neg.b	TrackModulationDelta(a5)		; Negate modulation delta
.locret:
		;rts
; ===========================================================================
; INPUT
; d2.b = frequency-related algorithm updater
;        0 for sequence updates
;        1 for tick updates
;        -1 for no updates
; OUTPUT
; d6.w = note, rest 
; ccr = n-bit clear (bpl) if valid frequency was found
; TRASHES: d0-d1/a0
GetFrequency_Rest:
		rts
GetFrequency:
; base frequency
		move.w	TrackFreq(a5),d6			; Get current note frequency
		bmi.s	GetFrequency_Rest
	if __smpsPortamento
		moveq	#0,d1
		move.b	TrackPortamentoTime(a5),d1
		beq.s	.doneportin
		move.w	d6,d0
		move.w	TrackPortamentoFreq(a5),d6
		cmp.w	d0,d6
		beq.s	.doneportin
		blt.s	.portlow	; note < newnote
		;bgt.s	.porthigh	; note > newnote
.porthigh:		
		sub.w	d1,d6
		cmp.w	d0,d6
		bgt.s	.doneportin
		bra.s	.portset
.portlow:
		add.w	d1,d6
		cmp.w	d0,d6
		blt.s	.doneportin
.portset:
		move.w	d0,d6
		;bra.s	.doneportin
.doneportin:
		tst.b	d2
		bmi.s	.noporta
		move.w	d6,TrackPortamentoFreq(a5)
.noporta:
	endif
; detune
		move.b	TrackDetune(a5),d0 			; Get detune value
		ext.w	d0
	if __smpsRevFreq<2
		add.w	d0,d6					; Add note frequency
	else
		sub.w	d0,d6					; Add note frequency
	endif
; modulation algorithm
		moveq	#0,d0
		move.b	TrackModulationCtrl(a5),d0
		bpl.s	.nomodalgo
; stupid fucking edgecase with SMPS 68K
;		cmp.b	#$81,d0
;		beq.s	.modalgo
;		tst.b	d2
;		beq.s	.nomodalgo
;;		move.l	TrackModulationPtr(a5),a0		; Get modulation data
;;		move.b	1(a0),d0
;;		cmp.b	TrackModulationSpeed(a5),d0		; mod speed must match
;;		bne.s	.nomodalgo
;;		tst.b	TrackModulationSteps(a5)		; Steps must still be running
;;		beq.s	.nomodalgo
.modalgo:
	if __smpsRevFreq<2
		add.w	TrackModulationVal(a5),d6
	else
		sub.w	TrackModulationVal(a5),d6
	endif
		bra.s	.nomodenv
.nomodalgo:
; modulation envelopes
		;moveq	#0,d0
		;move.b	TrackModulationCtrl(a5),d0
		add.b	d0,d0			; remove sign bit
		beq.s	.nomodenv
	if __smpsModEnv
		move.l	TrackModEnvPtr(a5),a0
		move.b	-2(a0,d0.w),-(sp)
		move.w	(sp)+,d1
		move.b	1-2(a0,d0.w),d1
		adda.w	d1,a0

		move.b	TrackModEnvIndex(a5),d0
.loop:
		move.b	(a0,d0.w),d1
		cmp.b	#$80,d1
		bne.s	.gotmodenv
		if __smpsDebug
		addq.b	#1,d0
		bcs.w	.ass_indexcarryage
		subq.b	#1,d0
		endif
		clr.w	d1
		move.b	1(a0,d0.w),d1
		add.w	d1,d1
		if __smpsDebug
		cmp.w	#.modenvcmde-.modenvcmd,d1
		bhs.w	.ass_modenvcmdtoobig
		endif
		jmp	.modenvcmd(pc,d1.w)
.gotmodenv:
		addq.b	#1,d0
		if __smpsDebug
		bcs.w	.ass_indexcarryage
		endif
		ext.w	d1
.gotmodenv2:
	if __smpsRevFreq<2
		add.w	d1,d6
	else
		sub.w	d1,d6
	endif
		tst.b	d2					; we're just updating the frequency dont change the index
		bmi.s	.nomodenv
		move.b	d0,TrackModEnvIndex(a5)
	elseif __smpsWarnDisabledUsage
		SMPS_assert "GetFrequency: __smpsModEnv is disabled"
	endif
.nomodenv:
		and.w	#$7FFF,d6				; clear sign bit and ccr n-bit
		;moveq	#0,d0					; clear n-bit
		rts
	if __smpsModEnv
; ---------------------------------------------------------------------------
.modenvcmd:
		bra.s	.EnvS12P				; $00
		bra.s	.EnvS12P				; $01
		bra.s	.EnvS12P				; $02
		bra.s	.EnvS12P				; $03
		bra.s	.EnvS12P				; $04
		bra.s	.EnvS12P				; $05
		bra.s	.EnvS12P				; $06
		bra.s	.EnvS12P				; $07
		bra.s	.EnvS12N				; $08
		bra.s	.EnvS12N				; $09
		bra.s	.EnvS12N				; $0A
		bra.s	.EnvS12N				; $0B
		bra.s	.EnvS12N				; $0C
		bra.s	.EnvS12N				; $0D
		bra.s	.EnvS12N				; $0E
		bra.s	.EnvS12N				; $0F
		bra.s	.Repeat					; $10
		bra.s	.Hold					; $11
		bra.s	.Index					; $12
		bra.s	.Rest					; $13
		bra.s	.EnvS16					; $14
.modenvcmde:
.EnvS12N:
		or.w	#$F0<<1,d1				; 1111XXXX
.EnvS12P:
		asl.w	#8-1,d1					; ....XXXX 00000000
		move.b	2(a0,d0.w),d1				; ....XXXX YYYYYYYY
		addq.b	#3,d0
		if __smpsDebug
		bcc.s	.gotmodenv2
		bcs.w	.ass_indexcarryage
		else
		bra.s	.gotmodenv2
		endif
.EnvS16:
		move.b	2(a0,d0.w),-(sp)
		move.w	(sp)+,d1
		move.b	3(a0,d0.w),d1
		addq.b	#4,d0
		if __smpsDebug
		bcc.s	.gotmodenv2
		bcs.w	.ass_indexcarryage
		else
		bra.s	.gotmodenv2
		endif
.Repeat:
		moveq	#0,d0
		bra.w	.loop
.Hold:
		subq.b	#1,d0
		bra.w	.loop
.Index:
		if __smpsDebug
		addq.b	#2,d0
		bcs.w	.ass_indexcarryage
		move.b	(a0,d0.w),d0
		else
		move.b	2(a0,d0.w),d0
		endif
		bra.w	.loop
.Rest:
		tst.b	d2					; we're just updating the frequency dont mute the audio again
		bmi.s	.RestEnd
		pea	.RestEnd(pc)
		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bcs.w	PSGNoteOff
		bpl.w	FMNoteOff
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
.RestEnd:
		moveq	#-1,d6
		rts
.ass_indexcarryage:
		SMPS_assert "Error: Modulation envelope index carriage error, TODO: print channel"
.ass_modenvcmdtoobig:
		SMPS_assert "Error: Modulation envelope command exceeds the table, TODO: print command"
	endif
; ===========================================================================
DoVolEnv_IncEnv:
		addq.b	#1,TrackVolEnvIndex(a5)			; Increment volume envelope index
		rts
; ---------------------------------------------------------------------------
VolEnvCommands_SizeAssert:
	;	lsr.b	#1,d0					; reobtain id
	;	tas.b	d0					; 1<<7
		SMPS_assert "Volume envelope with invalid command, TODO: print command"
VolEnvCommands:
		add.b	d0,d0					; (cmd-$80)*2
		cmp.w	#3*2,d0
		bhi.s	VolEnvCommands_SizeAssert
		jmp	.lut(pc,d0.w)
.lut:		bra.s	.Repeat					; $80
		bra.s	.Hold					; $81
		bra.s	.Index					; $82
		bra.s	.Rest					; $83
.Repeat:
		clr.b	TrackVolEnvIndex(a5)
		bra.w	DoVolEnv.loop
.Hold:
; Decrement to last PSG volume. This ensures that the fade-in volume gets processed
		subq.b	#1,TrackVolEnvIndex(a5)
		bra.w	DoVolEnv.loop
.Index:
		move.b	1(a0,d1.w),TrackVolEnvIndex(a5)
		bra.w	DoVolEnv.loop
.Rest:
		addq.w	#4,sp					; Do not return to caller
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bcs.w	PSGNoteOff
		bpl.w	FMNoteOff
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
; ---------------------------------------------------------------------------
UpdateVolume:
		moveq	#0,d1
		move.b	TrackVolEnvCtrl(a5),d1
		bne.s	DoVolEnv.env
		rts
DoVolEnv:
		moveq	#0,d1
		move.b	TrackVolEnvCtrl(a5),d1
		beq.s	.noenv
.env:
		move.l	TrackVolEnvPtr(a5),a0
		add.w	d1,d1
		move.b	-2(a0,d1.w),-(sp)
		move.w	(sp)+,d2
		move.b	1-2(a0,d1.w),d2
		adda.w	d2,a0
		moveq	#0,d0
		moveq	#0,d1
.loop:		move.b	TrackVolEnvIndex(a5),d1			; Get volume envelope index
		move.b	(a0,d1.w),d0				; Volume envelope value
		bmi.s	VolEnvCommands				; If value is a command, branch
.nocmd:		pea	DoVolEnv_IncEnv(pc)			; increment envelope after it's sent ; TODO: kinda hackish
.noenv:
; ---------------------------------------------------------------------------
; TRASHES
; d0-d3/a0/a2-a3
SetVolume:
		moveq	#1<<_resting|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.exit
		moveq	#1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.checktimeout
.send:
		bsr.s	GetVolume
		move.b	TrackVoiceControl(a5),d1
		add.b	d1,d1
		bcs.s	.psgvol
		bpl.s	.fmvol
.pcmvol:
		move.b	d0,d1
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACSetVolume
.checktimeout:
	if (TrackNoteTimeoutMaster=TrackNoteTimeout+1)&&(TrackNoteTimeout&1=0)
		move.w	TrackNoteTimeout(a5),d0			; TrackNoteTimeout<<8|TrackNoteTimeoutMaster
		not.b	d0
		tst.w	d0
		bne.s	.send					; If note timeout is on and has expired, branch
	else
		tst.b	TrackNoteTimeoutMaster(a5)		; Is note timeout on?
		beq.s	.send					; Branch if not
		tst.b	TrackNoteTimeout(a5)			; Has note timeout expired?
		bne.s	.send					; Branch if not
	endif
.exit:		rts
.fmvol:
		bra.w	SendVoiceTL.gotvol
.psgvol:
		lsr.w	#3,d0
		or.b	#1<<4,d0				; Mark it as a volume command
		moveq_	$E0,d1
		btst	#_special,TrackPlaybackControl(a5)
		bne.s	.psg3noisemode
		and.b	TrackVoiceControl(a5),d1		; Add in track selector bits
.psg3noisemode:
		or.b	d1,d0
		move.b	d0,(psginput).l
		rts
; ---------------------------------------------------------------------------
; get volume with applied envelope, fade-in and user controlled volume
; d0.w = volume
; TRASHES
; d0-d3/a0
GetVolume:
		moveq	#0,d0
		move.b	TrackVolume(a5),d0

		moveq	#0,d1
		move.b	TrackVolEnvCtrl(a5),d1
		beq.s	.noenv
		add.w	d1,d1
		move.l	TrackVolEnvPtr(a5),a0
		move.b	-2(a0,d1.w),-(sp)
		move.w	(sp)+,d2
		move.b	1-2(a0,d1.w),d2
		add.w	d2,a0
		moveq	#0,d1
		move.b	TrackVolEnvIndex(a5),d1
		add.w	d1,a0
		move.b	(a0),d1
	;	ext.w	d1					; Sign extension for negative envelopes
	;	bmi.s	.noenv					; If it's stopped at a command, skip
	;	bpl.s	.envcmd					; If it's stopped at a command, mute it (will occur naturally)
	;	moveq	#$7F,d1					; ^
.envcmd:	add.w	d1,d0
.noenv:
		move.b	TrackVoiceControl(a5),d3
		tst.b	v_driverflags2(a1)			; is underwater muffle enabled?
		bpl.s	.nouservol
		btst	#_nomuffle,TrackPlaybackControl(a5)
		bne.s	.nouservol
		cmp.b	#$40,d3					; SendVoiceTL handles it for FM
		blo.s	.nouservol
		add.w	#$10,d0					; PSG volume
		tst.b	d3
		bmi.s	.nouservol
		add.w	#$38-$10,d0				; PCM volume ; TODO: if supported, specific muffling flag on the PCM driver side
.nouservol:
		smpsMakeChannelRamIndex d1,d3
		lea	RAM_BGMChannel(pc),a0
		move.w	d1,d2
		move.w	(a0,d1.w),d1
		move.l	a1,a0
		add.w	d1,a0
		cmp.l	a5,a0
		bne.s	.nobgm
		moveq	#0,d1
		move.b	v_fadein_counter(a1),d1
		cmp.b	#$40,d3
		blo.s	.fmbgm
		add.w	d1,d1
.fmbgm:		add.w	d1,d0
.nobgm:
		cmpi.w	#$7F,d0					; apply volume cap
		bls.s	.nocap
		moveq	#$7F,d0
.nocap:
		rts
; ===========================================================================
	if __smpsPanEnv
DoPanEnv:
		moveq	#7,d0
		and.b	TrackPanCtrl(a5),d0
		if __smpsDebug
		cmp.b	#3,d0
		bls.s	.valid
		SMPS_assert "DoPanEnv: Invalid panning type; TODO: print ID"
.valid:
		endif
		add.w	d0,d0
		jmp	.lut(pc,d0.w)
.lut:		bra.s	PanType_Off		; Off
		bra.s	PanType_UpdRepeat	; Per-Update, repeat
		bra.s	PanType_TickHold	; Per-Tick, hold
		bra.s	PanType_TickRepeat	; Per-Tick, repeat
UpdatePanning:
		moveq	#7,d0
		and.b	TrackPanCtrl(a5),d0
		if __smpsDebug
		cmp.b	#3,d0
		bls.s	.valid
		SMPS_assert "UpdatePanning: Invalid panning type; TODO: print ID"
.valid:
		endif
		add.w	d0,d0
		jmp	.lut(pc,d0.w)
.lut:		bra.s	PanType_Off_1
		bra.s	PanType_UpdRepeat_1
		bra.s	PanType_TickHold_1
		bra.s	PanType_TickRepeat_1
PanType_Off:
PanType_Off_1:
PanType_UpdRepeat_1:
		rts

PanType_TickHold:
PanType_TickRepeat:
		move.b	TrackPanSavedDelay(a5),TrackPanDelay(a5)
		clr.b	TrackPanIndex(a5)

PanType_UpdRepeat:
PanType_TickHold_1:
PanType_TickRepeat_1:
		subq.b	#1,TrackPanDelay(a5)
		bne.s	.exit

		move.b	TrackPanEndIndex(a5),d0
		cmp.b	TrackPanIndex(a5),d0
		bne.s	.notend
; (hackishly) check for hold types
		moveq	#7,d0
		and.b	TrackPanCtrl(a5),d0
		cmp.b	#2,d0
		beq.s	.exit
; repeat
		clr.b	TrackPanIndex(a5)
.notend:
		addq.b	#1,TrackPanIndex(a5)
		move.b	TrackPanSavedDelay(a5),TrackPanDelay(a5)

		btst	#v_driverflags.mono,v_driverflags(a1)
		bne.s	.exit
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit

		move.l	TrackPanEnvPtr(a5),a0
		move.b	TrackPanCtrl(a5),d0
		lsr.b	#3-1,d0
		and.w	#$1F<<1,d0
		move.b	(a0,d0.w),-(sp)
		move.w	(sp)+,d1
		move.b	1(a0,d0.w),d1
		adda.w	d1,a0

		moveq	#0,d0
		move.b	TrackPanIndex(a5),d0
		move.b	-1(a0,d0.w),d1				; pan data

		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bmi.s	.pcm
.fm:
		moveq	#%00110111,d0
		and.b	TrackAMSFMSPan(a5),d0
		or.b	d0,d1
		moveq_	fmreg.panamspms,d0			; Command to set AMS/FMS/panning
		bra.w	WriteFMIorII
.exit:
		rts
.pcm:
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACSetPan
	elseif __smpsWarnDisabledUsage
UpdatePanning:	SMPS_assert "UpdatePanning: __smpsPanEnv is disabled"
DoPanEnv:	SMPS_assert "DoPanEnv: __smpsPanEnv is disabled"
	else
UpdatePanning:
DoPanEnv:
		rts
	endif
; ===========================================================================
; handle control flags 
CoordFlag:
		subi.w	#$E0,d5
		add.w	d5,d5
		add.w	d5,d5
		jmp	.lut(pc,d5.w)
; ---------------------------------------------------------------------------
.lut:		bra.w	cfPanLeft				; cPanLeft
		bra.w	cfPanRight				; cPanRight
		bra.w	cfPanCentre				; cPanCentre
		bra.w	cfAddVolume				; cVolAdd
		bra.w	cfAddFMVolume				; cVolAddFM
		bra.w	cfAddPSGVolume				; cVolAddPSG
		bra.w	cfSetVolume				; cVolSet
		bra.w	cfSetFMVolume				; cVolSetFM
		bra.w	cfSetPSGVolume				; cVolSetPSG
		bra.w	cfSetFMVoice				; cVoiceFM
		bra.w	cfSetVolEnv				; cVolEnv
		bra.w	cfSetPSGNoise				; cNoisePSG
		bra.w	cfDetune				; cDetune
		bra.w	cfHoldNote				; cDontAttack
		bra.w	cfNoteTimeout				; cNoteFill
		bra.w	cfNoteTimeoutZ80			; cNoteFillZ80
		bra.w	cfAddTranspose				; cAddTranspose
		bra.w	cfSetTranspose				; cSetTranspose
		bra.w	cfModulation68K				; cModSet68K
		bra.w	cfModulationZ80				; cxModSetZ80
		bra.w	cfModulation68K2			; cModSet68K2
		bra.w	cfModChg				; cModChg
		bra.w	cfSample				; cSample
		bra.w	cfJumpTo				; cJump
		bra.w	cfJumpToN8				; cJumpN8
		bra.w	cfRepeatAtPos				; cRept
		bra.w	cfSetRept				; cSetRept
		bra.w	cfJumpToGosub				; cCall
		bra.w	cfJumpReturn				; cReturn
		bra.w	cfStopTrack				; cStop
		bra.w	cfCommunicate				; cCommunicate
;		bra.w	cfExtCmd				; cExtCmd
.lute:
; ===========================================================================
cfExtCmd:
		move.b	(a4)+,d5
		add.w	d5,d5
	if __smpsDebug
		cmp.w	#.lute-.lut,d5
		bhs.s	.unk
	endif
		move.w	.lut(pc,d5.w),d0
		jmp	.lut(pc,d0.w)
.unk:		SMPS_assert "cfExtCmd: Invalid control flag, TODO print cfx"
.lut:
		dc.w  cfxWriteFMIorII-.lut			; cxWriteReg
		dc.w  cfxWriteFMI-.lut				; cxWriteFM1
		dc.w  cfxWriteFMII-.lut				; cxWriteFM2
		dc.w  cfxPanAuto-.lut				; cxPanAuto
		dc.w  cfxPanManual-.lut				; cxPanManual
		dc.w  cfxPanningAMSFMS-.lut			; cxPanAMSFMS
		dc.w  cfxSetLFORate-.lut			; cxSetLFORate
		dc.w  cfxRevUp-.lut				; cxRevUp
		dc.w  cfxRevAddCur-.lut				; cxRevAddCur
		dc.w  cfxRevReset-.lut				; cxRevReset
		dc.w  cfxPlayID-.lut				; cxPlayID
		dc.w  cfxStopFM-.lut				; cxStopFM
		dc.w  cfxConditionalJump-.lut			; cxConditionalJump
		dc.w  cfxHoldNoteIndefinitely-.lut		; cxHoldNoteIndefinitely
		dc.w  cfxReleaseNote-.lut			; cxReleaseNote
		dc.w  cfxSetPSG3-.lut				; cxSetPSG3
		dc.w  cfxLoopCSFX-.lut				; cxLoopCSFX
		dc.w  cfxPortamentoSpeed-.lut			; cxPortamentoSpeed
		dc.w  cfxModChg2-.lut				; cxModChg2
		dc.w  cfxRandPitch-.lut				; cxRandPitch
		dc.w  cfxSetTempoMod-.lut			; cxTempoMod
		dc.w  cfxSetTempoDivider-.lut			; cxTempoDiv
		dc.w  cfxSetTempoDividerAll-.lut		; cxTempoDivAll
		dc.w  cfxDrumModeOn-.lut			; cxDrumModeOn
		dc.w  cfxDrumModeOff-.lut			; cxDrumModeOff
		dc.w  cfxCommJump-.lut				; cxCommJump
		dc.w  cfxFmKeyOnMask-.lut			; cxFmKeyOnMask
.lute:
; ===========================================================================
	if __smpsDrum
cfxDrumModeOn:
		or.b	#1<<_drummode,TrackPlaybackControl(a5)
		rts
cfxDrumModeOff:
		and.b	#(1<<_drummode)!$FF,TrackPlaybackControl(a5)
		rts
	elseif __smpsWarnDisabledUsage
cfxDrumModeOn:	SMPS_assert "cfxDrumModeOn: __smpsDrum setting was disabled"
cfxDrumModeOff:	SMPS_assert "cfxDrumModeOff: __smpsDrum setting was disabled"
	else
cfxDrumModeOn:
cfxDrumModeOff:	rts
	endif
; ===========================================================================
; set LFOs global modulation rate
cfxSetLFORate:
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	.notfm
		moveq_	fmreg.lfofreq,d0
		move.b	(a4)+,d1
		bra.w	WriteFMI
.notfm:		SMPS_assert "cfxSetLFORate: Non-FM channel using FM command, TODO: print channel"
; ===========================================================================
cfPanRight:
		moveq_	$40,d1
		bra.s	cfPanOnly
cfPanLeft:
		moveq_	$80,d1
		bra.s	cfPanOnly
cfPanCentre:
		moveq_	$C0,d1
		bra.s	cfPanOnly
; ---------------------------------------------------------------------------
cfxPanningAMSFMS:
		move.b	(a4)+,d1				; New AMS/FMS/panning value
		bclr	#3,d1					; bit 3 is a flag to not retain previous AMS/FMS
		bne.s	cfxSetPanAMSFMS
cfPanOnly:
		moveq	#%00111111,d0				; Change panning, retain AMS/FMS
		and.b	TrackAMSFMSPan(a5),d0
		or.b	d0,d1					; logically OR previous pan/AMS/FMS on top of the new AMS/FMS

cfxSetPanAMSFMS:
		move.b	TrackVoiceControl(a5),d2		; this isn't the game gear
		bmi.s	.psg
		move.b	d1,TrackAMSFMSPan(a5)			; Save pan value
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit
		btst	#v_driverflags.mono,v_driverflags(a1)
		bne.s	.mono
		add.b	d2,d2
		bmi.s	.pcm
		moveq_	fmreg.panamspms,d0			; Command to set AMS/FMS/panning
		bra.w	WriteFMIorII
; ---------------------------------------------------------------------------
.pcm:		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACSetPan
; ---------------------------------------------------------------------------
.psg:
.mono:
.exit:		rts
; ===========================================================================
	if __smpsPanEnv
cfxPanAuto:
		if __smpsDebug
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		SMPS_assert "cfxPanAuto: Attempted PSG channel panning"
.notpsg:
		endif
		move.b	(a4)+,TrackPanCtrl(a5)
		move.b	(a4)+,TrackPanEndIndex(a5)
		move.b	(a4)+,TrackPanSavedDelay(a5)
		clr.b	TrackPanIndex(a5)
		move.b	#1,TrackPanDelay(a5)
		rts
cfxPanManual:
		if __smpsDebug
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		SMPS_assert "cfxPanManual: Attempted PSG channel panning"
.notpsg:
		endif
		clr.b	TrackPanCtrl(a5)
; restore previous panning
		move.b	TrackAMSFMSPan(a5),d1
		bra.w	cfPanOnly
	elseif __smpsWarnDisabledUsage
cfxPanAuto:	SMPS_assert "cfxPanAuto: __smpsPanEnv is disabled"
cfxPanManual:	SMPS_assert "cfxPanManual: __smpsPanEnv is disabled"
	else
cfxPanAuto:	addq.w	#5,a4
cfxPanManual:	rts
	endif
; ===========================================================================
cfDetune:
		move.b	(a4)+,TrackDetune(a5)			; Set detune value
		rts
; ===========================================================================
cfxPortamentoSpeed:
	if __smpsPortamento
		if __smpsDebug
		move.b	TrackVoiceControl(a5),d0
		bmi.s	.valid
		cmp.b	#$40,d0
		blo.s	.valid
		SMPS_assert "cfxPortamentoSpeed: PCM attempted use"
.valid:
		endif
		move.b	(a4)+,TrackPortamentoTime(a5)
		rts
	elseif __smpsWarnDisabledUsage
		SMPS_assert "cfxPortamentoSpeed: __smpsPortamento is disabled"
	else
		addq.w	#1,a4
		rts
	endif
; ===========================================================================
cfAddVolume:
		move.b	(a4)+,d0
		add.b	d0,TrackVolume(a5)
		rts
cfAddFMVolume:
		move.b	(a4)+,d0
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	.notfm
		add.b	d0,TrackVolume(a5)
.notfm:		rts
cfAddPSGVolume:
		move.b	(a4)+,d0
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		add.b	d0,TrackVolume(a5)
.notpsg:	rts
; ---------------------------------------------------------------------------
cfSetVolume:
		move.b	(a4)+,TrackVolume(a5)
		rts
cfSetFMVolume:
		move.b	(a4)+,d0
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	.notfm
		move.b	d0,TrackVolume(a5)
.notfm:		rts
cfSetPSGVolume:
		move.b	(a4)+,d0
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		move.b	d0,TrackVolume(a5)
.notpsg:	rts
; ===========================================================================
cfHoldNote:
		or.b	#1<<_noattack,TrackPlaybackControl(a5)
		rts
; ---------------------------------------------------------------------------
cfxHoldNoteIndefinitely:
		or.b	#1<<_noattack|1<<_holdnotes,TrackPlaybackControl(a5)
		rts
; ---------------------------------------------------------------------------
cfxReleaseNote:
		and.b	#(1<<_noattack|1<<_holdnotes)!$FF,TrackPlaybackControl(a5)
		rts
; ===========================================================================
cfNoteTimeout:
		move.b	(a4)+,d1
		move.b	d1,TrackNoteTimeout(a5)
		move.b	d1,TrackNoteTimeoutMaster(a5)
		rts
; ---------------------------------------------------------------------------
; timeout is the u8 result of parameter x tempo divider. It's highly prone to overflowing
cfNoteTimeoutZ80:
		moveq	#0,d0
		moveq	#0,d1
		move.b	(a4)+,d1
		move.b	TrackTempoDivider(a5),d0
		mulu.w	d0,d1
		move.b	d1,TrackNoteTimeout(a5)
		move.b	d1,TrackNoteTimeoutMaster(a5)
		rts
; ===========================================================================
cfAddTranspose:
		move.b	(a4)+,d0
		add.b	d0,TrackTranspose(a5)
		rts
; ---------------------------------------------------------------------------
cfSetTranspose:
		move.b	(a4)+,TrackTranspose(a5)
		rts
; ---------------------------------------------------------------------------
; RAND16 % (from-to) + to
cfxRandPitch:
		moveq	#0,d0
		move.w	v_random(a1),d0
		move.b	(a4)+,d1
		ext.w	d1
		divs.w	d1,d0
		swap	d0
		move.b	(a4)+,d1
		add.w	d1,d0
		move.b	d0,TrackTranspose(a5)
		rts
; ---------------------------------------------------------------------------
cfxRevUp:
		move.b	v_revving_pitch(a1),d0
		tst.b	v_revving_timer(a1)
		bne.s	.timeractive
		moveq	#-1,d0					; start pitch at 0

.timeractive:
		addq.b	#1,d0
		cmpi.b	#12-1,d0
		bhs.s	.limitreached
		move.b	d0,v_revving_pitch(a1)

.limitreached:
		move.b	#60,v_revving_timer(a1)			; Set timer
;		bra.s	cfRevAddCurr
; ---------------------------------------------------------------------------
cfxRevAddCur:
		tst.b	v_revving_timer(a1)
		beq.s	.norevving
		move.b	v_revving_pitch(a1),d0
		add.b	d0,TrackTranspose(a5)
.norevving:
		rts
; ---------------------------------------------------------------------------
cfxRevReset:
		clr.b	v_revving_timer(a1)
		rts
; ===========================================================================
cfxSetTempoDivider:
		move.b	(a4)+,TrackTempoDivider(a5)
		rts
; ---------------------------------------------------------------------------
cfxSetTempoDividerAll:
		if __smpsDebug
; ensure that it's a bgm track using this bgm exclusive command
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		lea	RAM_BGMChannel(pc),a3			; check if this channel even has bgm channel
		move.w	(a3,d0.w),d0
		beq.s	.error
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5					; check that the location matches
		beq.s	.valid
.error:		SMPS_assert "cfxSetTempoDividerAll: Non-BGM, TODO: print SFX channel"
.valid:
		endif
		move.b	(a4)+,d0
	set .val,v_music_pcm_tracks+TrackTempoDivider
	rept (v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz
		move.b	d0,.val(a1)
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackTempoDivider
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		move.b	d0,.val(a1)
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackTempoDivider
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		move.b	d0,.val(a1)
	set .val,.val+TrackPsgSz
	endr
		rts
; ---------------------------------------------------------------------------
cfxSetTempoMod:
		if __smpsDebug
; ensure that it's a bgm track using this bgm exclusive command
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		lea	RAM_BGMChannel(pc),a3			; check if this channel even has bgm channel
		move.w	(a3,d0.w),d0
		beq.s	.error
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5					; check that the location matches
		beq.s	.valid
.error:		SMPS_assert "cfxSetTempoMod: Non-BGM, TODO: print SFX channel"
.valid:
		endif
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		move.w	d0,v_main_tempo(a1)			; Set main tempo
		clr.w	v_main_tempo_timeout(a1)		; And reset timeout
		rts
; ===========================================================================
cfSample:
		move.b	(a4)+,d1
		cmp.b	#$40,TrackVoiceControl(a5)
		blo.s	.nope
		tst.b	TrackVoiceControl(a5)
		bmi.s	.nope
		move.b	d1,TrackSavedDAC(a5)
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		beq.w	DACQueueSample
		rts
.nope:		SMPS_assert "cfSample: Attempted non-DAC usage; TODO print channel"
; ===========================================================================
cfSetFMVoice:
		move.b	(a4)+,d0
		cmp.b	#$40,TrackVoiceControl(a5)		; only set voice for FM
		bhs.s	.nope
		move.b	d0,TrackFmVoiceIndex(a5)
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		beq.w	SetVoice
.nope:		rts
; ---------------------------------------------------------------------------
cfSetVolEnv:
		move.b	(a4)+,TrackVolEnvCtrl(a5)
		rts
; ---------------------------------------------------------------------------
cfSetPSGNoise:
		if __smpsDebug
; ensure that only PSG3 or PSG4 channels are trying to use this
		move.w	RAM_BGMChannel+24(pc),d0
		beq.s	.nopsg3bgm
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3bgm:
		move.w	RAM_BGMChannel+28(pc),d0
		beq.s	.nopsg4bgm
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg4bgm:
		move.w	RAM_SFXChannel+24(pc),d0
		beq.s	.nopsg3sfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3sfx:
		move.w	RAM_SFXChannel+28(pc),d0
		beq.s	.nopsg4sfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg4sfx:
	if __smpsBSFX
		move.w	RAM_BSFXChannel+24(pc),d0
		beq.s	.nopsg3bsfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3bsfx:
		move.w	RAM_BSFXChannel+28(pc),d0
		beq.s	.nopsg4bsfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg4bsfx:
	endif
		SMPS_assert "cfxSetPSG3: Non-PSG3 usage, TODO: print channel"
.valid:
		endif
; if channel is PSG4, simply save the new noise type
		move.b	(a4)+,d1
		cmp.b	#$E0,TrackVoiceControl(a5)
		bhs.s	.psg4
.psg3:
		and.b	#$C7,d1					; acknowledge it as PSG3, but save the noise type
		bset	#_special,TrackPlaybackControl(a5)	; enable PSG special mode
		tas.b	d1					; Test d0 then set bit 7 (yes this works, tas is fine on registers)
		bpl.s	.exit					; If bit 7 was clear, don't silence psg 3
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit
		move.b	#$DF,(psginput).l			; mute PSG3
.psg4:
		clr.b	v_lastpsg4(a1)
.exit:
		move.b	d1,TrackVoiceControl(a5)
		rts
; ---------------------------------------------------------------------------
cfxSetPSG3:
		if __smpsDebug
; ensure that only PSG3 channels are trying to use this
		move.w	RAM_BGMChannel+24(pc),d0
		beq.s	.nopsg3bgm
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3bgm:
		move.w	RAM_SFXChannel+24(pc),d0
		beq.s	.nopsg3sfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3sfx:
	if __smpsBSFX
		move.w	RAM_BSFXChannel+24(pc),d0
		beq.s	.nopsg3bsfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.valid
.nopsg3bsfx:
	endif
		SMPS_assert "cfxSetPSG3: Non-PSG3 usage, TODO: print channel"
.valid:
		endif
		move.b	#$C0,TrackVoiceControl(a5)		; Discard noise
		bclr	#_special,TrackPlaybackControl(a5)	; clear special flag
		sne.b	d0					; if it was set then mute PSG noise...
		btst	#_sfxoverride,TrackPlaybackControl(a5)	; ...if SFXs aren't using it
		bne.s	.locret
		tst.b	d0
		beq.s	.notpsg34shared
		move.b	#$FF,(psginput).l			; mute PSG noise
.notpsg34shared:
.locret:	rts
; ---------------------------------------------------------------------------
cfxFmKeyOnMask:
	if __smpsDebug
		cmp.b	#$40,TrackVoiceControl(a5)
		blo.s	.valid
		SMPS_assert "cfxFmKeyOnMask: Attemped use outside of FM"
.valid:
	endif
		move.b	(a4)+,d0
		and.b	#$F,TrackFmOperators(a5)
		or.b	d0,TrackFmOperators(a5)
		rts
; ===========================================================================
cfModulation68K2:
		move.b	#1<<7|2,TrackModulationCtrl(a5)
		bra.s	cfModulation68K_cont

cfModulation68K:
		move.b	#1<<7|0,TrackModulationCtrl(a5)

cfModulation68K_cont:
		move.l	a4,d0
		move.w	d0,TrackModulationPtr+2(a5)
		swap	d0
		move.b	d0,TrackModulationPtr+1(a5)
		move.b	(a4)+,TrackModulationWait(a5)
		move.b	(a4)+,TrackModulationSpeed(a5)
		move.b	(a4)+,TrackModulationDelta(a5)
		move.b	(a4)+,d0				; Modulation steps...
		lsr.b	#1,d0					; ... divided by 2...
		move.b	d0,TrackModulationSteps(a5)		; ... before being stored
		clr.w	TrackModulationVal(a5)			; Total accumulated modulation frequency change
		rts
; ---------------------------------------------------------------------------
cfModulationZ80:
; NOTE: clear modenv
; As noted in Clone Driver, envelope clear is important for S3 miniboss theme
		move.b	#1<<7|1,TrackModulationCtrl(a5)
		move.l	a4,d0
		move.w	d0,TrackModulationPtr+2(a5)
		swap	d0
		move.b	d0,TrackModulationPtr+1(a5)
		addq.w	#4,a4
		rts
; ---------------------------------------------------------------------------
cfDisableModulation:
		clr.b	TrackModulationCtrl(a5)
		rts
; ---------------------------------------------------------------------------
; cfEnableModulation:
cfModChg:
		move.b	(a4)+,TrackModulationCtrl(a5)
		rts
; ---------------------------------------------------------------------------
cfxModChg2:
		move.b	(a4)+,d1	; PSG mod
		move.b	(a4)+,d2	; FM mod
		move.b	TrackVoiceControl(a5),d0
		bmi.s	.psg
;		add.b	d0,d0
		move.b	d2,d1
.psg:		move.b	d1,TrackModulationCtrl(a5)
		rts
; ===========================================================================
; relocate sequence to n8 offset starting from cf-(*)
cfJumpToN8:
		moveq	#-1,d0
		move.b	(a4),d0
		subq.w	#1,d0					; start from the control flag byte
		adda.w	d0,a4					; Add to current position
		rts
; ---------------------------------------------------------------------------
; relocate sequence to s16 offset starting from loc-(*)+1
; the backbone of all sequence relocation commands
cfJumpTo:
		move.b	(a4)+,-(sp)				; Get high byte of offset, increment position by 1
		move.w	(sp)+,d0				; Shift it into place
		move.b	(a4),d0					; Get low byte of offset
		adda.w	d0,a4					; Add to current position
		rts
; ---------------------------------------------------------------------------
cfRepeatAtPos:
		moveq	#0,d0
		move.b	(a4)+,d0				; Loop index
		move.b	(a4)+,d1				; Repeat count
		lea	TrackLoopCounters(a5,d0.w),a3
		tst.b	(a3)					; Has this loop already started?
		bne.s	.loopexists				; Branch if yes
		move.b	d1,(a3)					; Initialize repeat count
.loopexists:
		subq.b	#1,(a3)					; Decrease loop's repeat count
		bne.s	cfJumpTo				; If nonzero, branch to target
		addq.w	#2,a4					; Skip target address
		rts
; ---------------------------------------------------------------------------
cfSetRept:
		moveq	#0,d0
		move.b	(a4)+,d0				; Get index
		move.b	(a4)+,TrackLoopCounters(a5,d0.w)	; Set loop value
		rts
; ---------------------------------------------------------------------------
; Shares loop counters with cfRepeatAtPos/cRept
; If the loop hits 1 (about to hit 0), set to 0 and perform a jump
cfxConditionalJump:
		moveq	#0,d0
		move.b	(a4)+,d0
		lea	TrackLoopCounters(a5,d0.w),a3
		cmp.b	#1,(a3)
		beq.s	.jump
		addq.w	#2,a4
		rts
.jump:		clr.b	(a3)
		bra.s	cfJumpTo
; ---------------------------------------------------------------------------
; Jump until and decrement contsfx until it's zero
cfxLoopCSFX:
		tst.b	v_contsfx_loop(a1)
		bne.s	.nope
		clr.w	v_contsfx_lastid(a1)
		addq.w	#2,a4
		rts
.nope:
		subq.b	#1,v_contsfx_loop(a1)
		bra.s	cfJumpTo
; ---------------------------------------------------------------------------
; If the chosen communication byte is zero, continue looping
cfxCommJump:
		moveq	#0,d1
		move.b	(a4)+,d1
		if __smpsDebug
		cmp.b	#__smpsCommBytes,d1
		bhs.s	.index
		endif
		tst.b	v_communication(a1,d1.w)
		beq.s	cfJumpTo
		addq.w	#2,a4
		rts
		if __smpsDebug
.index:		SMPS_assert "cfxCommJump: Index is too large"
		endif
; ---------------------------------------------------------------------------
cfJumpToGosub:
		moveq	#0,d0
		move.b	TrackStackPointer(a5),d0
		lea	(a5,d0.w),a0
		subq.b	#3,d0					; decrement stack
		if __smpsDebug
		cmp.b	#TrackGoSubStackEnd,d0
		blo.s	.exceeding
		endif
		move.b	d0,TrackStackPointer(a5)		; Store new stack pointer

		moveq	#2,d1					; store address after cCall command into stack (3 bytes)
		add.l	a4,d1
		move.b	d1,-(a0)
		move.w	d1,-(sp)
		move.b	(sp)+,-(a0)
		swap	d1
		move.b	d1,-(a0)
		bra.w	cfJumpTo

		if __smpsDebug
.exceeding:	SMPS_assert "cfJumpToGosub: Stack overflow, TODO: print stack offset"
		endif
; ---------------------------------------------------------------------------
cfJumpReturn:
		moveq	#0,d0
		move.b	TrackStackPointer(a5),d0
		lea	(a5,d0.w),a0
		addq.b	#3,d0					; increment stack
		if __smpsDebug
		cmp.b	#TrackGoSubStack,d0
		bhi.s	.exceeding
		endif
		move.b	d0,TrackStackPointer(a5)

		moveq	#0,d1					; return saved address after cCall from stack (3 bytes)
		move.b	(a0)+,d1
		swap	d1
		move.b	(a0)+,-(sp)
		move.w	(sp)+,d1
		move.b	(a0)+,d1
		moveq	#0,d0
		move.b	d0,-(a0)				; clear stack (might get used by loops later)
		move.b	d0,-(a0)
		move.b	d0,-(a0)
		move.l	d1,a4
		rts

		if __smpsDebug
.exceeding:	SMPS_assert "cfJumpReturn: Stack overflow, TODO: print stack offset"
		endif
; ===========================================================================
cfxWriteFMIorII:
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		beq.w	WriteFMIorII
		rts
cfxWriteFMI:
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	WriteFMI
cfxWriteFMII:
		move.b	(a4)+,d0
		move.b	(a4)+,d1
		bra.w	WriteFMII
; ===========================================================================
cfCommunicate:
		moveq	#0,d1
		move.b	(a4)+,d1
		if __smpsDebug
		cmp.b	#__smpsCommBytes,d1
		blo.s	.index
		SMPS_assert "cfCommunicate: Index is too large"
.index:
		endif
		move.b	(a4)+,v_communication(a1,d1.w)
		rts
; ===========================================================================
cfxStopFM:
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	cfStopTrack
		bsr.w	FMSilence
		;bra.s	cfStopTrack
; ---------------------------------------------------------------------------
cfStopTrack:
; stop processing this channel
		addq.w	#8,sp
		and.b	#(1<<_playing|1<<_noattack)!$FF,TrackPlaybackControl(a5)
; check if a bgm needs to be restored
	if __smpsJingle
		btst	#v_driverflags.jingle,v_driverflags(a1)		; is a jingle playing?
		beq.s	.nojingle
		moveq	#0,d0
	set .val,v_music_pcm_tracks+TrackPlaybackControl
	rept (v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz
		or.b	.val(a1),d0
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackPlaybackControl
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		or.b	.val(a1),d0
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackPlaybackControl
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		or.b	.val(a1),d0
	set .val,.val+TrackPsgSz
	endr
		and.b	#1<<_playing,d0				; check if any bgm channels are playing
		bne.w	.nobgm					; if there's any left, don't restore the prior bgm
		bra.w	cfStopTrack_Jingle			; restore
.nojingle:
	endif
; find parallel channels to restore
		smpsMakeChannelRamIndex d3,TrackVoiceControl(a5)
		lea	RAM_SFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nosfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a5,a3						; if we're stopping the SFX channel...
		bne.s	.notsfx						; ...clear SFX priority and check other channels
		clr.b	v_sndprio(a1)
		bra.s	.nosfx
.notsfx:	and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)			; restore SFX if track is playing
		bmi.s	.restore
.nosfx:
	if __smpsBSFX
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nobsfx
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a5,a3						; if we're stopping the BSFX channel...
		beq.s	.nobsfx						; ...check other channels
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)			; restore BSFX if track is playing
		bmi.s	.restore
.nobsfx:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nobgm
		move.l	a1,a3
		adda.w	d0,a3
		cmp.l	a5,a3						; if we're stopping the BGM channel...
		beq.s	.nobgm						; ...check other channels
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a3)
		tst.b	TrackPlaybackControl(a3)			; restore BGM if track is playing
		bmi.s	.restore
.nobgm:
; no channel to restore, just turn the current one off
		move.b	TrackVoiceControl(a5),d0			; Get voice control bits
		add.b	d0,d0
		bcs.s	.psg
		bmi.s	.dac
		;bpl.s	.fm
.fm:		bra.w	FMNoteOff
.psg:
		btst	#_special,TrackPlaybackControl(a5)
		beq.s	.psgnah
		cmp.b	#$E0,TrackVoiceControl(a5)
		blo.s	.psgnah
		clr.b	v_lastpsg4(a1)
.psgnah:
		bra.w	PSGNoteOff
.dac:
	if __smpsRestPCM=0
		rts
	else
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
	endif

; found channel to restore, initiate the new one
.restore:
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		move.b	TrackVoiceControl(a5),d0		; Get voice control bits
		add.b	d0,d0
		bcs.s	.r_psg
		bmi.s	.r_dac
		;bpl.s	.r_fm
.r_fm:
		bsr.w	FMNoteOff
		exg.l	a3,a5
		bsr.w	SetVoicePan
		move.l	a3,a5
		rts
.r_psg:
		bra.w	PSGNoteOff
.r_psgnah:	rts
.r_dac:
		exg.l	a3,a5
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bsr.w	DACStopSample
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		move.b	TrackAMSFMSPan(a5),d1
		btst	#v_driverflags.mono,v_driverflags(a1)
		beq.s	.stereo
		or.b	#$C0,d1
.stereo:	bsr.w	DACSetPan
		exg.l	a3,a5
		rts

	if __smpsJingle
cfStopTrack_Jingle:
		bclr	#v_driverflags.jingle,v_driverflags(a1)	; Disable jingle
		move.b	#$50,v_fadein_counter(a1)		; Trigger fade-in
; restore prior track
		lea	v_1up_save_ram(a1),a0
		lea	v_1up_ram_copy(a1),a2
		moveq	#0,d0
		move.w	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d1
.prior:		move.l	(a2),(a0)+
		move.l	d0,(a2)+
		dbf	d1,.prior
	if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	(a2),(a0)+
		move.w	d0,(a2)+
	endif

		moveq	#((v_music_pcm_tracks_end-v_music_pcm_tracks)/TrackDacSz)-1,d7
		lea	v_music_pcm_tracks(a1),a5
.dacloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextdac
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		;bsr.w	SetVolume.send
.nextdac:	add.w	#TrackDacSz,a5
		dbf	d7,.dacloop

		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		lea	v_music_fm_tracks(a1),a5
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextfm
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		bsr.w	SetVoicePan
.nextfm:	add.w	#TrackFmSz,a5
		dbf	d7,.fmloop

		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d7
		lea	v_music_psg_tracks(a1),a5
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextpsg
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		add.w	#TrackPsgSz,a5
.nextpsg:
		dbf	d7,.psgloop
; stop processing all sequences for this frame
		addq.w	#4,sp
		bra.w	HandleSequencerEnd
	endif
; ===========================================================================
cfxPlayID:
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		lea	v_soundqueue_start(a1),a3
		moveq	#(v_soundqueue_end-v_soundqueue_start)/2-1,d1
.next:		tst.w	(a3)+
		dbeq	d1,.next
		bne.s	.full
		move.w	d0,-(a3)
.full:		rts