; ---------------------------------------------------------------------------
FMUpdateTrack:
	if __smpsTarget="fuckFM"
	rts
	endif
		subq.b	#1,TrackDurationTimeout(a5)
		bne.s	.notegoing
		bsr.s	FMDoNext
		btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	DoVolEnv				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	DoPanEnv				; bsr is necessary for stack reasons
		bsr.w	DoModulation
		bsr.w	FMPrepareNote
		bra.w	FMNoteOn
; ---------------------------------------------------------------------------
.notegoing:	btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	NoteTimeoutUpdate			; bsr is necessary for stack reasons
		bsr.w	UpdateVolume				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	UpdatePanning				; bsr is necessary for stack reasons
		bsr.w	DoModulation
		bra.w	FMUpdateFreq
; ---------------------------------------------------------------------------
.locret:	rts
; ===========================================================================
FMDoNext:
		and.b	#$FF!(1<<_resting|1<<_noattack),TrackPlaybackControl(a5)
		btst	#_holdnotes,TrackPlaybackControl(a5)
		beq.s	.notheld
		or.b	#1<<_noattack,TrackPlaybackControl(a5)
.notheld:
		move.l	TrackDataPointer(a5),a4
.noteloop:	moveq	#0,d5
		move.b	(a4)+,d5
		bpl.s	.gotonlytime
		cmpi.b	#$E0,d5
		blo.s	.gotnote
		pea	.noteloop(pc)
		bra.w	CoordFlag				; manipulates stack
; ---------------------------------------------------------------------------
.gotnote:	bsr.s	FMSetFreq
		move.b	(a4)+,d5
		bpl.s	.gotnotetime
		subq.w	#1,a4
		bra.w	FMFinishTrackUpdate
.gotnotetime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.norest:	pea	FMFinishTrackUpdate(pc)
		bra.w	SetDuration
; ---------------------------------------------------------------------------
.gotonlytime:	bsr.w	FMNoteOff
		tst.w	TrackFreq(a5)
		bpl.s	.norest
	if __smpsDebug
; note-rest-time-time varies on different versions of SMPS, as noted in Clone Drivers asserts
		SMPS_assert "FM note-rest-time-time"
	else
; note-rest-time-time
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		pea	FMFinishTrackUpdate(pc)
		bra.w	SetDuration
	endif
; ===========================================================================
FMSetFreq:
	if __smpsFMTable=0
; Unlike PSGSetFreq, this uses a 1-based index. This is a long standing oddity with SMPS-68K
; If note nC0 is played and transpose is -1, it can reach the hidden nB-1
		subi.b	#$80,d5					; Make it a 1-based index
		beq.s	.rest
	else
		subi.b	#$81,d5
		bcs.s	.rest
	endif
		add.b	TrackTranspose(a5),d5			; Add track transposition
	if __smpsDebug
		cmp.w	#12*8,d5
		bhi.s	.assert
	endif
		add.b	d5,d5					; Clear high byte and sign bit
		move.w	FMFrequencies(pc,d5.w),TrackFreq(a5)	; Store new frequency
		bra.w	FMNoteOff
.rest:		or.b	#1<<_resting,TrackPlaybackControl(a5)
		move.w	#-1,TrackFreq(a5)
		bra.w	FMNoteOff
.assert:	SMPS_assert "FMSetFreq: invalid frequency, TODO: print freq id"
; ===========================================================================
; FM Note Values:
;
; Rather than use a complete lookup table, other SMPS drivers such as
; Sonic 3's compute the octave, and only store a single octave's worth of
; notes in the table.
; Said computation caps invalid notes to the highest octave (val%12+octave8),
; such as the note below the lowest note becoming the highest note, whereas
; with the table it goes out of bounds
; This is important to keep this in mind when porting buggy songs.
; ---------------------------------------------------------------------------
FMFrequencies:
	if __smpsFMTable=0
; b-0 to a#8
	dc.w $025E,$0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C
	dc.w $0A5E,$0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C
	dc.w $125E,$1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C
	dc.w $1A5E,$1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C
	dc.w $225E,$2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C
	dc.w $2A5E,$2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C
	dc.w $325E,$3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C
	dc.w $3A5E,$3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C
	else
; c-0 to a-6
	dc.w $0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C,$04C0
	dc.w $0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C,$0CC0
	dc.w $1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C,$14C0
	dc.w $1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C,$1CC0
	dc.w $2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C,$24C0
	dc.w $2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C,$2CC0
	dc.w $3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C,$34C0
	dc.w $3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C,$3CC0
	endif
FMFrequenciesEnd:
; ===========================================================================
FMUpdateFreq:
		moveq_	%10111111,d0
		and.b	TrackModulationCtrl(a5),d0		; is modulation (calculated or envelopes) enabled?
		beq.s	FMPrepareNote.exit			; if not, branch

FMPrepareNote:
		moveq	#0,d2
		bsr.w	GetFrequency
		bpl.s	.valid
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.exit:
		rts
.valid:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit

		fmstart	a0
		move.w	d6,-(sp)				; d1.b = d6>>8
		move.b	(sp)+,d1
		move.b	TrackVoiceControl(a5),d0	; Get voice control bits
		if __smpsDebug
		cmp.b	#3,d0
		beq.s	.ivfm
		cmp.b	#6,d0
		bls.s	.vfm
.ivfm:		SMPS_assert "FMPrepareNote: Invalid FM channel, TODO: print channel"
.vfm:
		endif
		subq.b	#1<<2,d0			; Is this bound for part I or II? (also clear chip toggle)
		bcc.s	.fm2				; Branch if for part II
		addq.b	#1<<2,d0
.fm1:
		add.b	#$A4,d0
		fmwrite	a0,d0,d1,0
		subq.w	#4,d0
		fmwrite	a0,d0,d6,0
		fmstop	a0
		rts
.fm2:
		add.b	#$A4,d0
		fmwrite	a0,d0,d1,1
		subq.w	#4,d0
		fmwrite	a0,d0,d6,1
		fmstop	a0
		;rts
; ---------------------------------------------------------------------------
FMNoteOn_exit:
FMNoteOff_exit:
		rts
; ===========================================================================
FMNoteOn:
		moveq	#1<<_resting|1<<_sfxoverride,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	FMNoteOn_exit
		moveq_	$28,d0				; Note on/off register
		moveq_	$F0,d1				; Note on for all operators
		or.b	TrackVoiceControl(a5),d1	; Get channel bits
		bra.w	WriteFMI
; ===========================================================================
FMNoteOff:
		moveq	#1<<_sfxoverride|1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	FMNoteOff_exit
SendFMNoteOff:
		moveq_	$28,d0				; Note on/off register
		move.b	TrackVoiceControl(a5),d1	; Note off to this channel
		bra.w	WriteFMI
; ===========================================================================
FMSilence:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.exit
		bsr.s	SendFMNoteOff
		moveq_	$40,d0				; Set TL on FM channels
		moveq_	$7F,d1				; To total attenuation
		bsr.s	.start
		moveq_	$80,d0				; Set release
		moveq_	$0F,d1				; To max
.start:
		moveq	#4-1,d3				; 4 operators per channel
.loop:		bsr.w	WriteFMIorII
		addq.b	#4,d0				; Next TL operator
		dbf	d3,.loop
.exit:
		rts
; ===========================================================================
FMSilenceAll:
		moveq	#3-1,d3				; 3 FM channels for each YM2612 parts
		moveq_	$28,d0				; FM key on/off register
		moveq	#0,d1
.noteoff:	bsr.w	WriteFMI
		addq.b	#4,d1				; Move to YM2612 part 1
		bsr.w	WriteFMI
		subq.b	#4-1,d1
		dbf	d3,.noteoff

		moveq_	$40,d0				; Set TL on FM channels
		moveq_	$7F,d1				; To total attenuation
		bsr.s	.start
		moveq_	$80,d0				; Set release
		moveq_	$0F,d1				; To max
.start:
		moveq	#3-1,d3				; All 3 channels
.chloop:	swap	d3
		move.w	#4-1,d3				; 4 operators per channel
.loop:		bsr.w	WriteFMI			; ... for part 0...
		bsr.w	WriteFMII			; ... and part 1.
		addq.b	#4,d0				; Next TL operator
		dbf	d3,.loop
		subi.b	#$10-1,d0			; Move to TL operator 1 of next channel
		swap	d3
		dbf	d3,.chloop
WriteFMchannel_exit:
		rts
; ---------------------------------------------------------------------------
SetVoicePan:
SetVoice:
		fmstart	a0
		move.l	TrackFmVoicePtr(a5),a1		; voice pointer
		moveq	#0,d1
		move.b	TrackFmVoiceIndex(a5),d1	; Current voice
		lsl.w	#5,d1		; x32
		adda.w	d1,a1		; x32

		lea	FMInstrumentOperatorTable(pc),a2
		moveq	#(FMInstrumentOperatorTable_End-FMInstrumentOperatorTable)-1,d3
		move.b	TrackVoiceControl(a5),d2	; Get voice control bits
		if __smpsDebug
; 0-2 and 4-6 are valid, everything else isn't
		cmp.b	#3,d2
		beq.s	.ivfm
		cmp.b	#6,d2
		bls.s	.vfm
.ivfm:		SMPS_assert "SetVoice: Invalid FM channel, TODO: print channel"
.vfm:
		endif
		subq.b	#1<<2,d2			; Is this bound for part I or II? (also clear chip toggle)
		bcc.w	.fm2				; Branch if for part II
		addq.b	#1<<2,d2
.fm1:
		moveq_	$C0,d1
		and.b	TrackAMSFMSPan(a5),d1
		or.b	(a1)+,d1
		move.b	d1,TrackAMSFMSPan(a5)
		btst	#v_driverflags.mono,v_driverflags(a6)
		beq.s	.stereo1
		or.b	#$C0,d1
.stereo1:
		moveq_	fmreg.panamspms,d0
		add.b	d2,d0
		fmwrite	a0,d0,d1,0
.loop1:		move.b	(a2)+,d0
		move.b	(a1)+,d1
		add.b	d2,d0				; Add in voice control bits
		fmwrite	a0,d0,d1,0
		dbf	d3,.loop1
		bra.s	.loopend
.fm2:
		moveq_	$C0,d1
		and.b	TrackAMSFMSPan(a5),d1
		or.b	(a1)+,d1
		move.b	d1,TrackAMSFMSPan(a5)
		btst	#v_driverflags.mono,v_driverflags(a6)
		beq.s	.stereo2
		or.b	#$C0,d1
.stereo2:
		moveq_	fmreg.panamspms,d0
		add.b	d2,d0
		fmwrite	a0,d0,d1,1
.loop2:		move.b	(a2)+,d0
		move.b	(a1)+,d1
		add.b	d2,d0
		fmwrite	a0,d0,d1,1
		dbf	d3,.loop2
.loopend:
		fmstop	a0
; volume is handled later by DoVolEnv and UpdateVolume
;		bsr.w	SendVoiceTL
		btst	#v_driverflags.ssgoff,v_driverflags(a6)		; if SSG-EG is disabled, uhh, disable it.
		beq.s	SendVoiceSSG.gotptr
		rts
; ---------------------------------------------------------------------------
SendVoiceSSG:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		move.l	TrackFmVoicePtr(a5),a1
		moveq	#0,d1
		move.b	TrackFmVoiceIndex(a5),d1
		lsl.w	#5,d1		; x32
		adda.w	d1,a1		; x32
		adda.w	#22,a1		; Want SSG
.gotptr:
		move.b	(a1)+,-(sp)
		move.w	(sp)+,d4
		move.b	(a1)+,d4
		btst	#v_driverflags.ssgoff,v_driverflags(a6)		; if SSG-EG is disabled, uhh, disable it.
		beq.s	.firecunt
		moveq	#0,d4
.firecunt:
		moveq	#4-1,d3
		moveq_	$90,d0
.loop:		rol.w	#4,d4
		moveq	#$F,d1
		and.b	d4,d1
		bsr.w	WriteFMIorII
		addq.w	#4,d0
		dbf	d3,.loop
.locret:	;rts
; ---------------------------------------------------------------------------
; INPUT
; d0.w = volume
; TRASHES
; d0-d3/a0-a2
SendVoiceTL_Exit:
		rts
SendVoiceTL:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	SendVoiceTL_Exit
		bsr.w	GetVolume
.gotvol:
		move.l	TrackFmVoicePtr(a5),a1
		moveq	#0,d1
		move.b	TrackFmVoiceIndex(a5),d1
		lsl.w	#5,d1		; x32
		adda.w	d1,a1		; x32
		adda.w	#24,a1		; Wants TL

		tst.b	v_driverflags2(a6)			; is underwater muffle enabled?
		bpl.s	.nomuffle
		btst	#_nouservol,TrackPlaybackControl(a5)	; is song going "nuh uh"?
		bne.s	.nomuffle
		addq.w	#4,a1		; Wants TL muffle
.nomuffle:
		move.w	d0,d3
		swap	d3
		move.w	#4-1,d3
		moveq	#$40,d0

.loop:		move.b	(a1)+,d1
		bpl.s	.send_tl
		move.l	d3,d2
		swap	d2
		add.b	d2,d1
		bcc.s	.send_tl
		moveq	#$7F,d1
.send_tl:	bsr.w	WriteFMIorII	; trashes a0/d2
		addq.w	#4,d0
		dbf	d3,.loop
		rts
; ---------------------------------------------------------------------------
FMInstrumentOperatorTable:
		dc.b  fmreg.algofeed
		dc.b  fmreg.muldt+$0,fmreg.muldt+$8,fmreg.muldt+$4,fmreg.muldt+$C
		dc.b  fmreg.arrs+$0,fmreg.arrs+$8,fmreg.arrs+$4,fmreg.arrs+$C
		dc.b  fmreg.dramen+$0,fmreg.dramen+$8,fmreg.dramen+$4,fmreg.dramen+$C
		dc.b  fmreg.sr+$0,fmreg.sr+$8,fmreg.sr+$4,fmreg.sr+$C
		dc.b  fmreg.rrsl+$0,fmreg.rrsl+$8,fmreg.rrsl+$4,fmreg.rrsl+$C
FMInstrumentOperatorTable_End:
	even
; ---------------------------------------------------------------------------
; Note: look into other SMPS 68000 variants
; INPUT
; d0 = addr
; d1 = data
; a5 = sequence (WriteFMIorIIMain)
; TRASHES
; a0/d2
	if __smpsTarget="fuckFM"
WriteFMI:
WriteFMII:
WriteFMIorII:
WriteFMIorIIMain:
		rts
	else
WriteFMI:
		fmstart	a0
		fmwrite	a0,d0,d1,0
		fmstop	a0
		rts
WriteFMII:
		fmstart	a0
		fmwrite	a0,d0,d1,1
		fmstop	a0
WriteFMIorIIMain_exit:
		rts
WriteFMIorIIMain:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	WriteFMIorIIMain_exit
WriteFMIorII:
		fmstart	a0
		move.b	TrackVoiceControl(a5),d2	; Get voice control bits
		if __smpsDebug
		cmp.b	#3,d2
		beq.s	.ivfm
		cmp.b	#6,d2
		bls.s	.vfm
.ivfm:		SMPS_assert "WriteFMIorII: Invalid FM channel, TODO: print channel"
.vfm:
		endif
		subq.b	#1<<2,d2			; Is this bound for part I or II? (also clear chip toggle)
		bcc.s	.fm2				; Branch if for part II
		addq.b	#1<<2,d2
		add.b	d0,d2				; Add in voice control bits
		fmwrite	a0,d2,d1,0
		fmstop	a0
.exit:		rts
.fm2:
		add.b	d0,d2
		fmwrite	a0,d2,d1,1
		fmstop	a0
		rts
	endif