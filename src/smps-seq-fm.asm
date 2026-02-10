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
; Unlike PSGSetFreq, this uses a 1-based index. This is a long standing oddity with SMPS-68K
; If note nC0 is played and transpose is -1, it can reach the last frequency
		subi.b	#$80,d5					; Make it a 1-based index
		beq.s	.rest
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
; FM Note Values: b-0 to a#8
;
; Each row is an octave, starting with B and ending with A-sharp/B-flat.
; Notably, this differs from the PSG frequency table, which starts with C and
; ends with B. This is caused by 'FMSetFreq' subtracting $80 from the note
; instead of $81, meaning that the first frequency in the table ironically
; corresponds to the 'rest' note. The only way to use this frequency in a
; real note is to transpose the channel to a lower semitone.
;
; Rather than use a complete lookup table, other SMPS drivers such as
; Sonic 3's compute the octave, and only store a single octave's worth of
; notes in the table.
;
; Invalid transposition values will cause this table to be overflowed,
; resulting in garbage data being used as frequency values. In drivers that
; compute the octave instead, invalid transposition values merely cause the
; notes to wrap-around (the note below the lowest note will be the highest
; note). It's important to keep this in mind when porting buggy songs.
FMFrequencies:
	dc.w $025E,$0284,$02AB,$02D3,$02FE,$032D,$035C,$038F,$03C5,$03FF,$043C,$047C
	dc.w $0A5E,$0A84,$0AAB,$0AD3,$0AFE,$0B2D,$0B5C,$0B8F,$0BC5,$0BFF,$0C3C,$0C7C
	dc.w $125E,$1284,$12AB,$12D3,$12FE,$132D,$135C,$138F,$13C5,$13FF,$143C,$147C
	dc.w $1A5E,$1A84,$1AAB,$1AD3,$1AFE,$1B2D,$1B5C,$1B8F,$1BC5,$1BFF,$1C3C,$1C7C
	dc.w $225E,$2284,$22AB,$22D3,$22FE,$232D,$235C,$238F,$23C5,$23FF,$243C,$247C
	dc.w $2A5E,$2A84,$2AAB,$2AD3,$2AFE,$2B2D,$2B5C,$2B8F,$2BC5,$2BFF,$2C3C,$2C7C
	dc.w $325E,$3284,$32AB,$32D3,$32FE,$332D,$335C,$338F,$33C5,$33FF,$343C,$347C
	dc.w $3A5E,$3A84,$3AAB,$3AD3,$3AFE,$3B2D,$3B5C,$3B8F,$3BC5,$3BFF,$3C3C,$3C7C
FMFrequenciesEnd:
; ===========================================================================
FMUpdateFreq:
		moveq_	%10111111,d0
		and.b	TrackModulationCtrl(a5),d0		; is modulation (calculated or envelopes) enabled?
		beq.s	FMUpdateFreq_exit			; if not, branch

FMPrepareNote:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	FMUpdateFreq_exit
		moveq	#0,d2
		bsr.w	GetFrequency
		bpl.s	.valid
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		rts
.valid:
		move.w	d6,-(sp)				; d1.b = d6>>8
		move.b	(sp)+,d1
		moveq_	$A4,d0					; Register for upper 6 bits of frequency
		bsr.w	WriteFMIorII
		move.b	d6,d1
		moveq_	$A0,d0					; Register for lower 8 bits of frequency
		bra.w	WriteFMIorII
; ---------------------------------------------------------------------------
FMUpdateFreq_exit:
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
; ===========================================================================
; Note: look into other SMPS 68000 variants
; INPUT
; d0 = addr
; d1 = data
; a5 = sequence (WriteFMIorIIMain)
; TRASHES
; a0/d2
	if __smpsTarget="fuckFM"
WriteFMIorIIMain:	; TODO: rename to WriteFMchannel
WriteFMIorII:
WriteFMI:
WriteFMII:
		rts
	elseif __smpsTarget="copera"
	fatal "TODO: Copera FM write code"
	else
WriteFMIorIIMain:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	WriteFMchannel_exit
WriteFMIorII:
		SMPS_stopZ80
		move.b	TrackVoiceControl(a5),d2	; Get voice control bits
		bclr	#2,d2				; Is this bound for part I or II? (also clear chip toggle)
		bne.s	.fm2				; Branch if for part II
	if __smpsDebug
		cmp.b	#2,d2
		bls.s	.ass1
		SMPS_assert "WriteFMIorII: Invalid FM-1 channel, TODO: print channel"
.ass1:
	endif
		add.b	d0,d2				; Add in voice control bits
		bra.s	WriteFMI.chcont
.fm2:
	if __smpsDebug
		cmp.b	#2,d2
		bls.s	.ass2
		SMPS_assert "WriteFMIorII: Invalid FM-2 channel, TODO: print channel"
.ass2:
	endif
		add.b	d0,d2
		bra.s	WriteFMII.chcont
WriteFMI:
		SMPS_stopZ80
		move.b	d0,d2
.chcont:	lea	(ymstat).l,a0
.chk_ready:
		SMPS_waitZ80
;		tst.b	MPCM_Z80_RAM+Z_MPCM_DriverReady-ymstat(a0)
;		bne.s	.ready
;		SMPS_startZ80
;		swap	d2				; 4
;		move.w	#11-1,d2			; 8
;		dbf	d2,*				; 14*11-4
;		nop					; 4
;		swap	d2				; 4
;		SMPS_stopZ80				; ^170 cycles!
;		bra.s	.chk_ready			; 10 (between stop and wait you should wait 12 cycles)
;.ready:
.wait1:		tst.b	(a0)
		bmi.s	.wait1
		if (ymstat==yma0)&&((yma0+1)==ymd0)
		move.b	d2,(a0)+
		nop
		move.b	d1,(a0)
		subq.w	#1,a0				; 8 ; YM needs 12 cycles to catch up
		or.l	d0,d0				; 8 ; 16 for leeway
		else
		move.b	d2,yma0-ymstat(a0)
		nop
		move.b	d1,ymd0-ymstat(a0)
		or.l	d0,d0				; 8 ; YM needs 12 cycles to catch up
		or.l	d0,d0				; 8 ; 16 for leeway
		endif
.wait2:		tst.b	(a0)
		bmi.s	.wait2
		move.b	#$2A,yma0-ymstat(a0)
		SMPS_startZ80
		rts
WriteFMII:
		SMPS_stopZ80
		move.b	d0,d2
.chcont:	lea	(ymstat).l,a0
.chk_ready:
		SMPS_waitZ80
;		tst.b	MPCM_Z80_RAM+Z_MPCM_DriverReady-ymstat(a0)
;		bne.s	.ready
;		SMPS_startZ80
;		swap	d2				; 4
;		move.w	#11-1,d2			; 8
;		dbf	d2,*				; 14*11-4
;		nop					; 4
;		swap	d2				; 4
;		SMPS_stopZ80				; ^170 cycles!
;		bra.s	.chk_ready			; 10 (between stop and wait you should wait 12 cycles)
;.ready:
.wait1:		tst.b	(a0)
		bmi.s	.wait1
		move.b	d2,yma1-ymstat(a0)
		nop
		move.b	d1,ymd1-ymstat(a0)
		or.l	d0,d0				; 8 ; YM needs 12 cycles to catch up
		or.l	d0,d0				; 8 ; 16 for leeway
.wait2:		tst.b	(a0)
		bmi.s	.wait2
		move.b	#$2A,yma0-ymstat(a0)
		SMPS_startZ80
		rts
	endif
; ---------------------------------------------------------------------------
SetVoicePan:
		moveq_	$B4,d0					; Register for AMS/FMS/Panning
		move.b	TrackAMSFMSPan(a5),d1			; Value to send
		btst	#5,v_driverflags(a6)
		beq.s	.stereo
		or.b	#$C0,d1
.stereo:	bsr.w	WriteFMIorII
		;bra.s	SetVoice
SetVoice:
		move.l	TrackFmVoicePtr(a5),a1		; voice pointer
		moveq	#0,d0
		move.b	TrackFmVoiceIndex(a5),d0	; Current voice
		adda.w	d0,a1		; x1
		add.w	d0,d0		; d0x2
		adda.w	d0,a1		; x3
		add.w	d0,d0		; d0x4
		add.w	d0,d0		; d0x8
		adda.w	d0,a1		; x11
		adda.w	d0,a1		; x19
		adda.w	d0,a1		; x27

		lea	FMInstrumentOperatorTable(pc),a2
		moveq	#(FMInstrumentOperatorTable_End-FMInstrumentOperatorTable)-1,d3
.loop:		move.b	(a2)+,d0
		move.b	(a1)+,d1
		bsr.w	WriteFMIorII
		dbf	d3,.loop
		btst	#4,v_driverflags(a6)		; if SSG-EG is disabled, uhh, disable it.
		beq.s	SendVoiceSSG.gotptr
		rts
; volume is handled later by DoVolEnv and UpdateVolume
;.nossg:
;		bra.w	SendVoiceTL
; ---------------------------------------------------------------------------
SendVoiceSSG:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		move.l	TrackFmVoicePtr(a5),a1
		moveq	#0,d1
		move.b	TrackFmVoiceIndex(a5),d1
		adda.w	d1,a1		; x1
		add.w	d1,d1		; d1x2
		adda.w	d1,a1		; x3
		add.w	d1,d1		; d1x4
		add.w	d1,d1		; d1x8
		adda.w	d1,a1		; x11
		adda.w	d1,a1		; x19
		adda.w	d1,a1		; x27
		adda.w	#21,a1		; Want SSG
.gotptr:
		move.b	(a1)+,-(sp)
		move.w	(sp)+,d4
		move.b	(a1)+,d4
		btst	#4,v_driverflags(a6)		; if SSG-EG is disabled, uhh, disable it.
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
		adda.w	d1,a1		; x1
		add.w	d1,d1		; d1x2
		adda.w	d1,a1		; x3
		add.w	d1,d1		; d1x4
		add.w	d1,d1		; d1x8
		adda.w	d1,a1		; x11
		adda.w	d1,a1		; x19
		adda.w	d1,a1		; x27
		move.b	(a1),d1		; get algo
		adda.w	#23,a1		; Want TL

		move.w	d0,d3
		swap	d3
		move.w	#4-1,d3

		moveq	#.nomuzzle-.muzzle,d2
		tst.b	v_driverflags2(a6)			; is underwater muffle enabled?
		bpl.s	.nouservol
		btst	#_nouservol,TrackPlaybackControl(a5)	; song go "nuh uh"
		bne.s	.nouservol
		moveq	#7,d2
		and.w	d1,d2
		add.w	d2,d2
		add.w	d2,d2
.nouservol:
		lea	.muzzle(pc,d2.w),a2

		moveq	#$40,d0
.loop:		move.b	(a1)+,d1
		bpl.s	.muzz
		move.l	d3,d2
		swap	d2
		add.b	d2,d1
		bcs.s	.cap_tl
		and.b	#$7F,d1
.muzz:		add.b	(a2)+,d1
		bpl.s	.send_tl
.cap_tl:	moveq	#$7F,d1
.send_tl:
		bsr.w	WriteFMIorII	; trashes a0/d2
		addq.w	#4,d0
		dbf	d3,.loop
		rts

.muzzle:	dc.l	$0B0B0B0B	; 0 ; table based on observing Sonic 2 Recreation, semi-thanks Valleybell
		dc.l	$08080804	; 1
		dc.l	$0C0A0A0A	; 2
		dc.l	$0A060A06	; 3
		dc.l	$0A060A06	; 4
		dc.l	$0A060A06	; 5
		dc.l	$0E0A080A	; 6
		dc.l	$08080804	; 7
.nomuzzle:	dc.l	$00000000	; std
	even
; ---------------------------------------------------------------------------
FMInstrumentOperatorTable:
		dc.b  $B0		; feedback/algorithm
		dc.b  $30		; Detune/multiple operator 1
		dc.b  $38		; Detune/multiple operator 3
		dc.b  $34		; Detune/multiple operator 2
		dc.b  $3C		; Detune/multiple operator 4
		dc.b  $50		; Rate scalling/attack rate operator 1
		dc.b  $58		; Rate scalling/attack rate operator 3
		dc.b  $54		; Rate scalling/attack rate operator 2
		dc.b  $5C		; Rate scalling/attack rate operator 4
		dc.b  $60		; Amplitude modulation/first decay rate operator 1
		dc.b  $68		; Amplitude modulation/first decay rate operator 3
		dc.b  $64		; Amplitude modulation/first decay rate operator 2
		dc.b  $6C		; Amplitude modulation/first decay rate operator 4
		dc.b  $70		; Secondary decay rate operator 1
		dc.b  $78		; Secondary decay rate operator 3
		dc.b  $74		; Secondary decay rate operator 2
		dc.b  $7C		; Secondary decay rate operator 4
		dc.b  $80		; Secondary amplitude/release rate operator 1
		dc.b  $88		; Secondary amplitude/release rate operator 3
		dc.b  $84		; Secondary amplitude/release rate operator 2
		dc.b  $8C		; Secondary amplitude/release rate operator 4
FMInstrumentOperatorTable_End:
	even