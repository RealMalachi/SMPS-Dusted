; INPUT
; d5.w = duration (expected to be between $01-$7F)
SetDuration:
	if __smpsDebug
		tst.w	d5
		bne.s	.durationgood
		cmp.w	#$7F,d5
		bls.s	.durationgood
.durationbad:
		SMPS_assert "Invalid base sequence duration, TODO print bad duration"
.durationgood:
	endif
		clr.w	d1
		move.b	TrackTempoDivider(a5),d1			; Get dividing timing
		mulu.w	d1,d5
	if __smpsDebug
		move.w	d5,d1
		clr.b	d1
		tst.w	d1
		beq.s	.noU8overflow
		SMPS_assert "Duration timer multiplication U8 overflow"
.noU8overflow:
	endif
		move.b	d5,TrackSavedDuration(a5)			; Save duration
		move.b	d5,TrackDurationTimeout(a5)			; Save duration timeout
		rts
; ===========================================================================
FinishTrackUpdate:
		move.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	TrackSavedDuration(a5),TrackDurationTimeout(a5)	; Reset note timeout
		moveq	#1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.locret
		move.b	TrackNoteTimeoutMaster(a5),TrackNoteTimeout(a5)	; Reset note fill timeout
		clr.b	TrackVolEnvIndex(a5)				; Reset volume envelope index
	if __smpsModEnv
		clr.b	TrackModEnvIndex(a5)
;		clr.b	TrackModEnvMultiply(a5)				; umm what the sigma
	endif
		tst.b	TrackModulationCtrl(a5)
		bpl.s	.nomod
		move.l	TrackModulationPtr(a5),a0			; Modulation data pointer
		move.b	(a0)+,TrackModulationWait(a5)			; Reset wait
		move.b	(a0)+,TrackModulationSpeed(a5)			; Reset speed
		move.b	(a0)+,TrackModulationDelta(a5)			; Reset delta
		move.b	(a0)+,d0					; Get steps
		lsr.b	#1,d0						; Halve them
		move.b	d0,TrackModulationSteps(a5)			; Then store
		clr.w	TrackModulationVal(a5)				; Reset frequency change
.nomod:
.locret:
		rts
; ===========================================================================
NoteTimeoutUpdate:
		subq.b	#1,TrackNoteTimeout(a5)				; Update note fill timeout
		bcs.s	.already					; if already expired or not set to run, branch
		bne.s	.exit						; if not yet expired, branch
		addq.w	#4,sp						; Do not return to caller
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit
		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bcs.w	SendPSGNoteOff
		bpl.w	FMNoteOff					; also checks for noattack
		bra.w	DACStopSample
.already:	clr.b	TrackNoteTimeout(a5)				; make sure it doesn't overflow
.exit:		rts
; ===========================================================================
DoModulation:
		move.b	TrackModulationCtrl(a5),d0
		bpl.s	.locret
		add.b	d0,d0
		bmi.s	.z80mode
;.68kmode:
		subq.b	#1,TrackModulationWait(a5)			; Has modulation wait expired?
		bcc.s	.locret						; If not, exit
		clr.b	TrackModulationWait(a5)				; Make sure wait doesn't overflow
		subq.b	#1,TrackModulationSpeed(a5)			; Update speed
		bne.s	.locret						; If it expired, want to update modulation
		move.l	TrackModulationPtr(a5),a0			; Get modulation data
		move.b	1(a0),TrackModulationSpeed(a5)			; Restore modulation speed
		tst.b	TrackModulationSteps(a5)			; Check number of steps
		bne.s	.calcfreq					; If nonzero, branch
		move.b	3(a0),TrackModulationSteps(a5)			; Restore from modulation data
		neg.b	TrackModulationDelta(a5)			; Negate modulation delta
.locret:
		rts
.calcfreq:
		subq.b	#1,TrackModulationSteps(a5)			; Update modulation steps
		move.b	TrackModulationDelta(a5),d6			; Get modulation delta
		ext.w	d6
		add.w	d6,TrackModulationVal(a5)			; Add to cumulative modulation change
		rts
.z80mode:
		subq.b	#1,TrackModulationWait(a5)			; Has modulation wait expired?
		bne.s	.z80_locret					; If not, exit
		addq.b	#1,TrackModulationWait(a5)			; Make sure wait doesn't overflow

		move.l	TrackModulationPtr(a5),a0			; Get modulation data
		subq.b	#1,TrackModulationSpeed(a5)			; Update speed
		bne.s	.z80_modsust					; If it expired, want to update modulation
		move.b	1(a0),TrackModulationSpeed(a5)			; Restore modulation speed
		move.b	TrackModulationDelta(a5),d6			; Get modulation delta
		ext.w	d6
		add.w	d6,TrackModulationVal(a5)			; Add to cumulative modulation change
.z80_modsust:
		subq.b	#1,TrackModulationSteps(a5)			; Check number of steps
		bne.s	.z80_locret					; If nonzero, branch
		move.b	3(a0),TrackModulationSteps(a5)			; Restore from modulation data
		neg.b	TrackModulationDelta(a5)			; Negate modulation delta
.z80_locret:
		;rts
; ===========================================================================
; OUTPUT
; d6.w = note, rest 
; ccr = n-bit clear (bpl) if valid frequency was found
; TRASHES: d0-d1/a0
GetFrequency_Rest:
		rts
GetFrequency:
		move.w	TrackFreq(a5),d6			; Get current note frequency
		bmi.s	GetFrequency_Rest
.cont:
		move.b	TrackDetune(a5),d0 			; Get detune value
		ext.w	d0
		add.w	d0,d6					; Add note frequency
		move.b	TrackModulationCtrl(a5),d0
		bpl.s	.nomod
		add.w	TrackModulationVal(a5),d6
.nomod:
; TODO: modulation envolopes
		;move.b	TrackModulationCtrl(a5),d0
		and.w	#$3F,d0
		beq.s	.nomodenv
	if __smpsModEnv
		add.b	d0,d0
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
		add.w	d1,d6
		move.b	d0,TrackModEnvIndex(a5)
	else
		SMPS_assert "Driver disabled Modulation Envelopes"
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
		bra.s	.Reset					; $10
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
.Reset:
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
		pea	.RestEnd(pc)
		move.b	TrackVoiceControl(a5),d0
		add.b	d0,d0
		bcs.w	PSGNoteOff
		bpl.w	FMNoteOff
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
VolEnvCommands_SizeAssert:
	;	lsr.b	#1,d0					; reobtain id
	;	tas.b	d0					; 1<<7
		SMPS_assert "Volume envelope with invalid command, TODO: print command"
VolEnvCommands:
		add.b	d0,d0					; (cmd-$80)*2
		cmp.w	#3*2,d0
		bhi.s	VolEnvCommands_SizeAssert
		jmp	.lut(pc,d0.w)
.lut:		bra.s	.Reset					; $80
		bra.s	.Hold					; $81
		bra.s	.Index					; $82
		bra.s	.Rest					; $83
.Reset:
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
		bra.w	DACStopSample
; ---------------------------------------------------------------------------
DoVolEnv_IncEnv:
		addq.b	#1,TrackVolEnvIndex(a5)			; Increment volume envelope index
UpdateVolume_exit:
		rts
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
; d0-d3/a0-a2
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
		lsr.w	#3,d0
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
		and.b	TrackVoiceControl(a5),d1		; Add in track selector bits
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
		tst.b	v_driverflags2(a6)			; is underwater muffle enabled?
		bpl.s	.nouservol
		btst	#_nouservol,TrackPlaybackControl(a5)
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
		move.l	a6,a0
		add.w	d1,a0
		cmp.l	a5,a0
		bne.s	.nobgm
		moveq	#0,d1
		move.b	v_fadein_counter(a6),d1
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
		bra.w	cfEnableModulation			; cModOn
		bra.w	cfDisableModulation			; cModOff
		bra.w	cfSetTempoDivider			; cTempoDiv
		bra.w	cfJumpTo				; cJump
		bra.w	cfJumpToN8				; cJumpN8
		bra.w	cfRepeatAtPos				; cRept
		bra.w	cfSetRept				; cSetRept
		bra.w	cfJumpToGosub				; cCall
		bra.w	cfJumpReturn				; cReturn
		bra.w	cfStopTrack				; cStop
;		bra.w	cfExtCmd				; cExtCmd
; ===========================================================================
cfExtCmd:
		move.b	(a4)+,d5
		add.w	d5,d5
	if __smpsDebug
		cmp.w	#.lute-.lut,d5
		bhs.w	cfxUnk
	endif
		move.w	.lut(pc,d5.w),d5
		jmp	.lut(pc,d5.w)
.lut:
		dc.w  cfxWriteFMIorII-.lut			; cxWriteReg
		dc.w  cfxWriteFMI-.lut				; cxWriteFM1
		dc.w  cfxWriteFMII-.lut				; cxWriteFM2
		dc.w  cfxPanAuto-.lut				; cPanAuto
		dc.w  cfxPanningAMSFMS-.lut			; cxPanAMSFMS
		dc.w  cfxSetLFO-.lut				; cxSetLFO
		dc.w  cfxSetCommunication-.lut			; cxCommunicate
		dc.w  cfxFadeInToPrevious-.lut			; cxSongFadeIn
		dc.w  cfxUnk-.lut				; cxSpecialFM3
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
		dc.w  cfxModChg-.lut				; cxModChg
		dc.w  cfxModChg2-.lut				; cxModChg2
		dc.w  cfxRandPitch-.lut				; cxRandPitch
		dc.w  cfxPlaySampleID-.lut			; cxSample
		dc.w  cfxSetTempoMod-.lut			; cxTempoMod
		dc.w  cfxSetTempoDividerAll-.lut		; cxTempoDivAll
.lute:
; ===========================================================================
cfxUnk:
cfUnk:		
		SMPS_assert "Invalid sequence control flag, TODO print cf"
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
		move.b	(a4)+,d1			; New AMS/FMS/panning value
		bclr	#3,d1				; bit 3 is a flag to not retain previous AMS/FMS
		bne.s	cfxSetPanAMSFMS
cfPanOnly:
		moveq	#%00111111,d0			; Change panning, retain AMS/FMS
		and.b	TrackAMSFMSPan(a5),d0
		or.b	d0,d1				; logically OR previous pan/AMS/FMS on top of the new AMS/FMS

cfxSetPanAMSFMS:
		move.b	TrackVoiceControl(a5),d2	; this isn't the game gear
		bmi.s	.psg
		move.b	d1,TrackAMSFMSPan(a5)		; Save pan value
		btst	#5,v_driverflags(a6)
		bne.s	.mono
		add.b	d2,d2
		bmi.s	.pcm
		moveq_	$B4,d0				; Command to set AMS/FMS/panning
		bra.w	WriteFMIorIIMain
; ---------------------------------------------------------------------------
.pcm:		move.b	d1,d0
		bra.w	DACSetPan
; ---------------------------------------------------------------------------
.psg:
.mono:		rts
; ===========================================================================
cfxPanAuto:
	if __smpsDebug
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		SMPS_assert "cfxPanAuto: Attempted PSG channel panning"
.notpsg:
	endif
;		move.b	(a4)+,pan_no(a5)		; pan no. set
;		beq.s	.off				; if pan no.= 0 then AUTOPAN OFF
;		move.b	(a4)+,pan_tb(a5)		; pan table set
;		move.b	(a4)+,pan_start(a5)		; pan start no. set
;		move.b	(a4)+,pan_limit(a5)		; pan limit set
;		move.b	(a4),pan_leng(a5)		; pan length set
;		move.b	(a4)+,pan_cont(a5)		; pan control set (=length)
;		rts
; restore previous panning
.off:
		move.b	TrackAMSFMSPan(a5),d1
		bra.w	cfPanOnly
; ===========================================================================
cfDetune:
		move.b	(a4)+,TrackDetune(a5)		; Set detune value
		rts
; ===========================================================================
cfAddVolume:
		move.b	(a4)+,d0
		add.b	d0,TrackVolume(a5)
		rts
cfAddFMVolume:
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	.notfm
		move.b	(a4)+,d0
		add.b	d0,TrackVolume(a5)
.notfm:		rts
cfAddPSGVolume:
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		move.b	(a4)+,d0
		add.b	d0,TrackVolume(a5)
.notpsg:	rts
; ---------------------------------------------------------------------------
cfSetVolume:
		move.b	(a4)+,TrackVolume(a5)
		rts
cfSetFMVolume:
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	.notfm
		move.b	(a4)+,TrackVolume(a5)
.notfm:		rts
cfSetPSGVolume:
		tst.b	TrackVoiceControl(a5)
		bpl.s	.notpsg
		move.b	(a4)+,TrackVolume(a5)
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
cfSetTranspose:
		move.b	(a4)+,TrackTranspose(a5)
		rts
; RAND16 % (from-to) + to
cfxRandPitch:
		moveq	#0,d0
		move.w	v_random(a6),d0
		move.b	(a4)+,d1
		ext.w	d1
		divs.w	d1,d0
		swap	d0
		move.b	(a4)+,d1
		add.w	d1,d0
		move.b	d0,TrackTranspose(a5)
		rts
; ===========================================================================
cfSetTempoDivider:
		move.b	(a4)+,TrackTempoDivider(a5)
		rts

cfxSetTempoDividerAll:
		if __smpsDebug=1
; ensure that it's a bgm track using this bgm exclusive command
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		lea	RAM_BGMChannel(pc),a3	; check if this channel even has bgm channel
		move.w	(a3,d0.w),d0
		beq.s	.error
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a3,a5				; check that the location matches
		beq.s	.valid
.error:		SMPS_assert "cfxSetTempoDividerAll: Non-BGM, TODO: print SFX channel"
.valid:
		endif
		move.b	(a4)+,d0
	set .val,v_music_dac_tracks+TrackTempoDivider
	rept (v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz
		move.b	d0,.val(a6)
	set .val,.val+TrackDacSz
	endr
	set .val,v_music_fm_tracks+TrackTempoDivider
	rept (v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz
		move.b	d0,.val(a6)
	set .val,.val+TrackFmSz
	endr
	set .val,v_music_psg_tracks+TrackTempoDivider
	rept (v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz
		move.b	d0,.val(a6)
	set .val,.val+TrackPsgSz
	endr

		rts
cfxSetTempoMod:
		if __smpsDebug=1
; ensure that it's a bgm track using this bgm exclusive command
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		lea	RAM_BGMChannel(pc),a3	; check if this channel even has bgm channel
		move.w	(a3,d0.w),d0
		beq.s	.error
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a3,a5				; check that the location matches
		beq.s	.valid
.error:		SMPS_assert "cfxSetTempoMod: Non-BGM, TODO: print SFX channel"
.valid:
		endif
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		move.w	d0,v_main_tempo(a6)			; Set main tempo
		and.w	#$FFF0,d0
		move.w	d0,v_main_tempo_timeout(a6)		; And reset timeout (!)
		rts
; ===========================================================================
cfxPlaySampleID:
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		move.w	d0,TrackSavedDAC(a5)
		bra.w	DACQueueSample
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
		move.b	TrackVoiceControl(a5),d0
		if __smpsDebug=1
; ensure that this channel was PSG3 or PSG noise
		cmp.b	#$C0,d0
		beq.s	.valid
		cmp.b	#$E0,d0
		blo.s	.invalid
		cmp.b	#$E7,d0
		bls.s	.valid
.invalid:	SMPS_assert "cfSetPSGNoise: Non-PSG3 or PSG4 usage, TODO: print channel"
.valid:
		endif
; set PSG noise mode
		move.b	(a4)+,d1
		move.b	d1,TrackVoiceControl(a5)		; Turn channel into noise, save noise tone
		moveq	#3,d0					; Figure out if noise mode uses PSG3
		and.b	d1,d0
		cmp.b	#3,d0
		seq.b	d0
		and.b	#1<<_special,d0				; Turn it into a bitmask for the special flag
		or.b	d0,TrackPlaybackControl(a5)

		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		tst.b	d0
		beq.s	.notpsg34shared
		move.b	#$DF,(psginput).l			; mute PSG3
.notpsg34shared:
		move.b	d1,(psginput).l				; Set noise tone
.locret:
		rts
; ---------------------------------------------------------------------------
cfxSetPSG3:
		move.b	TrackVoiceControl(a5),d0
		if __smpsDebug=1
; ensure that this channel was PSG3 or PSG noise
		cmp.b	#$C0,d0
		beq.s	.valid
		cmp.b	#$E0,d0
		blo.s	.invalid
		cmp.b	#$E7,d0
		bls.s	.valid
.invalid:	SMPS_assert "cfxSetPSG3: Non-PSG3 or PSG4 usage, TODO: print channel"
.valid:
; ensure that only PSG3 channels are trying to use this
		move.w	RAM_BGMChannel+24(pc),d0
		beq.s	.nopsg3bgm
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.psg3channel
.nopsg3bgm:
		move.w	RAM_SFXChannel+24(pc),d0
		beq.s	.nopsg3sfx
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.psg3channel
.nopsg3sfx:
	if __smpsBFX
		move.w	RAM_BSFXChannel+24(pc),d0
		beq.s	.nopsg3bsfx
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a3,a5
		beq.s	.psg3channel
.nopsg3bsfx:
	endif
		SMPS_assert "cfxSetPSG3: Non-PSG3 usage, TODO: print channel"
.psg3channel:
		endif
		move.b	#$C0,TrackVoiceControl(a5)		; Turn channel into psg3
		bclr	#_special,TrackPlaybackControl(a5)	; clear special flag
		sne.b	d0					; if it was set then mute PSG noise...
		btst	#_sfxoverride,TrackPlaybackControl(a5)	; ...if SFXs aren't using it
		bne.s	.locret
		tst.b	d0
		beq.s	.notpsg34shared
		move.b	#$FF,(psginput).l			; mute PSG noise
.notpsg34shared:
.locret:	rts
; ===========================================================================
cfModulation68K:
		move.b	#1<<7,TrackModulationCtrl(a5)
		move.b	TrackModulationPtr(a5),d0
		move.l	a4,TrackModulationPtr(a5)
		move.b	d0,TrackModulationPtr(a5)
		move.b	(a4)+,TrackModulationWait(a5)
		move.b	(a4)+,TrackModulationSpeed(a5)
		move.b	(a4)+,TrackModulationDelta(a5)
		move.b	(a4)+,d0				; Modulation steps...
		lsr.b	#1,d0					; ... divided by 2...
		move.b	d0,TrackModulationSteps(a5)		; ... before being stored
		clr.w	TrackModulationVal(a5)			; Total accumulated modulation frequency change
		rts

cfModulationZ80:
; As noted in Clone Driver, envelope clear is important for S3 miniboss theme
		move.b	#1<<7|1<<6,TrackModulationCtrl(a5)
		move.b	TrackModulationPtr(a5),d0
		move.l	a4,TrackModulationPtr(a5)
		move.b	d0,TrackModulationPtr(a5)
		addq.w	#4,a4
		rts

cfEnableModulation:
		or.b	#1<<7,TrackModulationCtrl(a5)
		rts

cfDisableModulation:
		and.b	#(1<<7)!$FF,TrackModulationCtrl(a5)
		rts

cfxModChg:
		move.b	(a4)+,TrackModulationCtrl(a5)
		rts
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
cfxLoopCSFX:
		tst.b	v_contsfx_loop(a6)
		bne.s	.nope
		clr.w	v_contsfx_lastid(a6)
		addq.w	#2,a4
		rts
.nope:
		subq.b	#1,v_contsfx_loop(a6)
		bra.s	cfJumpTo
; ---------------------------------------------------------------------------
cfJumpToGosub:
		moveq	#0,d0
		move.b	TrackStackPointer(a5),d0
		lea	(a5,d0.w),a0
		subq.b	#3,d0					; decrement stack
		if __smpsDebug=1
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
		bra.s	cfJumpTo

		if __smpsDebug=1
.exceeding:	SMPS_assert "cfJumpToGosub: Stack overflow, TODO: print stack offset"
		endif
; ---------------------------------------------------------------------------
cfJumpReturn:
		moveq	#0,d0
		move.b	TrackStackPointer(a5),d0
		lea	(a5,d0.w),a0
		addq.b	#3,d0					; increment stack
		if __smpsDebug=1
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
		move.b	d0,-(a0)					; clear stack (might get used by loops later)
		move.b	d0,-(a0)
		move.b	d0,-(a0)
		move.l	d1,a4
		rts

		if __smpsDebug=1
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
cfxSetCommunication:
		move.b	(a4)+,v_communication_byte(a6)
		rts
; ===========================================================================
cfxStopFM:
		cmp.b	#$40,TrackVoiceControl(a5)
		bhs.s	cfStopTrack
		bsr.w	FMSilence
		;bra.s	cfStopTrack
; ---------------------------------------------------------------------------
cfStopTrack:
		addq.w	#8,sp						; stop processing this channel
		and.b	#(1<<_playing|1<<_noattack)!$FF,TrackPlaybackControl(a5)
		smpsMakeChannelRamIndex d3,TrackVoiceControl(a5)
; check which channel we're using
		lea	RAM_SFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.notsfx
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a5,a3
		bne.s	.notsfx
		clr.b	v_sndprio(a6)					; Clear priority
		bra.s	.nosfx
.notsfx:
; find parallel channels to restore
		lea	RAM_SFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nosfx
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a5,a3
		bne.s	.nosfx
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.restore
.nosfx:
	if __smpsBFX=1
		lea	RAM_BSFXChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nobsfx
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a5,a3
		bne.s	.nobsfx
		tst.b	TrackPlaybackControl(a3)
		bmi.s	.restore
.nobsfx:
	endif
		lea	RAM_BGMChannel(pc),a3
		move.w	(a3,d3.w),d0
		beq.s	.nobgm
		move.l	a6,a3
		adda.w	d0,a3
		cmp.l	a5,a3
		bne.s	.nobgm
		tst.b	TrackPlaybackControl(a3)			; Is track playing?
		bmi.s	.restore					; Branch if not
.nobgm:
; no channel to restore, just turn the current one off
		move.b	TrackVoiceControl(a5),d0			; Get voice control bits
		add.b	d0,d0
		bcs.s	.psg
		bmi.s	.dac
		;bpl.s	.fm
.fm:		bra.w	FMNoteOff
.psg:		bra.w	PSGNoteOff
.dac:		bra.w	DACStopSample

; found channel to restore, initiate the new one
.restore:
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a3)
		or.b	#1<<_resting,TrackPlaybackControl(a3)
		move.b	TrackVoiceControl(a5),d0			; Get voice control bits
		add.b	d0,d0
		bcs.s	.r_psg
		bmi.s	.r_dac
		;bpl.s	.r_fm
.r_fm:		bsr.w	FMNoteOff
		exg.l	a3,a5
		bsr.w	SetVoicePan
		move.l	a3,a5
		rts
.r_psg:		bsr.w	PSGNoteOff
		move.b	TrackVoiceControl(a3),d0			; If PSG4...
		cmp.b	#$E0,d0
		bhs.s	.r_psgnoise
		btst	#_special,TrackPlaybackControl(a3)		; ...or PSG3 using PSG4 for noise...
		beq.s	.r_psgnah
		or.b	#$E0,d0						; ...set noise tone
.r_psgnoise:	move.b	d0,(psginput).l
.r_psgnah:	rts
.r_dac:		bra.w	DACStopSample
; TODO: like fm I think you need to set pan
; ===========================================================================
cfxRevUp:
		move.b	v_revving_pitch(a6),d0
		tst.b	v_revving_timer(a6)
		bne.s	.sfx_timeractive
		moveq	#-1,d0				; start pitch at 0

.sfx_timeractive:
		addq.b	#1,d0
		cmpi.b	#12-1,d0
		bhs.s	.sfx_limitreached
		move.b	d0,v_revving_pitch(a6)

.sfx_limitreached:
		move.b	#60,v_revving_timer(a6)		; Set timer
;		bra.s	cfRevAddCurr
; ---------------------------------------------------------------------------
cfxRevAddCur:
		tst.b	v_revving_timer(a6)
		beq.s	.norevving
		move.b	v_revving_pitch(a6),d0
		add.b	d0,TrackTranspose(a5)
.norevving:
		rts
; ---------------------------------------------------------------------------
cfxRevReset:
		clr.b	v_revving_timer(a6)
		rts
; ===========================================================================
cfxFadeInToPrevious:
	if __smpsJingle=1
		lea	v_1up_save_ram(a6),a0
		lea	v_1up_ram_copy(a6),a1
		moveq	#0,d0
		moveq	#((v_1up_ram_copy_end-v_1up_ram_copy)/4)-1,d2
.restore:
		move.l	(a1),(a0)+
		move.l	d0,(a1)+
		dbf	d2,.restore
	if (v_1up_ram_copy_end-v_1up_ram_copy)&2
		move.w	(a1),(a0)+
		move.w	d0,(a1)+
	endif
		move.b	#$50,v_fadein_counter(a6)		; Trigger fade-in
		bclr	#0,v_driverflags(a6)

		move.l	a5,a3
		move.l	d7,-(sp)

		moveq	#((v_music_dac_tracks_end-v_music_dac_tracks)/TrackDacSz)-1,d7
		lea	v_music_dac_tracks(a6),a5
.dacloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextdac
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		;bsr.w	SetVolume.send
.nextdac:	add.w	#TrackDacSz,a5
		dbf	d7,.dacloop

		moveq	#((v_music_fm_tracks_end-v_music_fm_tracks)/TrackFmSz)-1,d7
		lea	v_music_fm_tracks(a6),a5
.fmloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextfm
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		bsr.w	SetVoicePan
.nextfm:	add.w	#TrackFmSz,a5
		dbf	d7,.fmloop

		moveq	#((v_music_psg_tracks_end-v_music_psg_tracks)/TrackPsgSz)-1,d7
		lea	v_music_psg_tracks(a6),a5
.psgloop:	tst.b	TrackPlaybackControl(a5)
		bpl.s	.nextpsg
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		and.b	#(1<<_sfxoverride)!$FF,TrackPlaybackControl(a5)
		bsr.w	PSGNoteOff
		move.b	TrackVoiceControl(a5),d0
		cmpi.b	#$E0,d0
		blo.s	.nextpsg
		cmpi.b	#$E7,d0
		bhi.s	.nextpsg
		move.b	d0,(psginput).l
.nextpsg:	add.w	#TrackPsgSz,a5
		dbf	d7,.psgloop

		move.l	(sp)+,d7
		move.l	a3,a5
		lea	12(sp),sp				; stop processing all BGM channels
		move.l	(sp),d2
		bra.w	HandleSequencerEnd
	else
		SMPS_assert "smpsFade: __smpsJingle is disabled"
	endif
; ===========================================================================
cfxPlayID:
		move.b	(a4)+,-(sp)
		move.w	(sp)+,d0
		move.b	(a4)+,d0
		lea	v_soundqueue_start(a6),a3
		moveq	#(v_soundqueue_end-v_soundqueue_start)/2-1,d1
.next:		tst.w	(a3)+
		dbeq	d1,.next
		bne.s	.full
		move.w	d0,-(a3)
.full:		rts
; ===========================================================================
cfxSetLFO:
		move.b	TrackVoiceControl(a5),d0
		bmi.s	.psg
		moveq_	$22,d0
		move.b	(a4)+,d1
		bsr.w	WriteFMI
		moveq_	%11000000,d1			; Change AMS/FMS, retain panning
		and.b	TrackAMSFMSPan(a5),d1
		or.b	(a4)+,d1
		bra.w	cfxSetPanAMSFMS
.psg:
		SMPS_assert "cfxSetLFO: PSG usage of an FM command, TODO: print channel"
; ===========================================================================
; cfxToggleAltFreqMode:
;cfxSetFreqMode1:
;		and.b	#(1<<_freqmode)!$FF,TrackPlaybackControl(a5)
;		rts
;cfxSetFreqMode2:
;		or.b	#1<<_freqmode,TrackPlaybackControl(a5)
;		rts