; ---------------------------------------------------------------------------
PSGUpdateTrack:
		subq.b	#1,TrackDurationTimeout(a5)
		bne.s	.notegoing
		bsr.s	PSGDoNext
		btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	PSGPrepareNote
		bsr.w	DoVolEnv				; bsr is necessary for stack reasons, see `VolEnvCommands`
		rts
; ---------------------------------------------------------------------------
.notegoing:	btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	NoteTimeoutUpdate			; bsr is necessary for stack reasons
		bsr.w	UpdateVolume				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	DoModulation
		bra.w	PSGUpdateFreq
; ---------------------------------------------------------------------------
.locret:	rts
; ===========================================================================
PSGDoNext:
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
.gotnote:	bsr.s	PSGSetFreq
		move.b	(a4)+,d5
		bpl.s	.gotnotetime
		subq.w	#1,a4
		bra.w	FinishTrackUpdate
.gotnotetime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.norest:	pea	FinishTrackUpdate(pc)
		bra.w	SetDuration
; ---------------------------------------------------------------------------
.gotonlytime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
	if __smpsDebug
; note-rest-time-time varies on different versions of SMPS, as noted in Clone Drivers asserts
		SMPS_assert "PSG note-rest-time-time"
	else
; note-rest-time-time
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		pea	FinishTrackUpdate(pc)
		bra.w	SetDuration
	endif
; ===========================================================================
PSGSetFreq:
		subi.b	#$81,d5					; Convert to 0-based index
		bcs.s	.rest					; If $80, put track at rest
		add.b	TrackTranspose(a5),d5
		if __smpsDebug
		chk	#12*7,d5
		endif
		add.b	d5,d5					; Also clear sign bit
		move.w	PSGFrequencies(pc,d5.w),TrackFreq(a5)	; Set new frequency
		bra.w	FinishTrackUpdate
; ---------------------------------------------------------------------------
.rest:		or.b	#1<<_resting,TrackPlaybackControl(a5)	; Set 'track at rest' bit
		move.w	#-1,TrackFreq(a5)			; Invalidate note frequency
		pea	PSGNoteOff(pc)
		bra.w	FinishTrackUpdate
; ===========================================================================
; PSG Note Values: c-0 to a-6
; ---------------------------------------------------------------------------
PSGFrequencies:
	dc.w $3FF, $3FF, $3FF, $3FF, $3FF, $3FF, $3FF, $3FF, $3FF, $3F7, $3BE, $388
	dc.w $356, $326, $2F9, $2CE, $2A5, $280, $25C, $23A, $21A, $1FB, $1DF, $1C4
	dc.w $1AB, $193, $17D, $167, $153, $140, $12E, $11D, $10D, $0FE, $0EF, $0E2
	dc.w $0D6, $0C9, $0BE, $0B4, $0A9, $0A0, $097, $08F, $087, $07F, $078, $071
	dc.w $06B, $065, $05F, $05A, $055, $050, $04B, $047, $043, $040, $03C, $039
	dc.w $036, $033, $030, $02D, $02B, $028, $026, $024, $022, $020, $01F, $01D
	dc.w $01B, $01A, $018, $017, $016, $015, $013, $012, $011, $010, $000, $000
PSGFrequenciesEnd:
; ===========================================================================
PSGUpdateFreq:
		tst.b	TrackModulationCtrl(a5)		; is modulation (calculated or envelopes) enabled?
		beq.s	PSGUpdateFreq_exit		; if not, branch

PSGPrepareNote:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	PSGUpdateFreq_exit
		bsr.w	GetFrequency
		bpl.s	.valid
		moveq	#-1,d6
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.valid:
; TODO: check for other noise modes
		moveq_	$E0,d0
		and.b	TrackVoiceControl(a5),d0		; Get channel bits
		btst	#_special,TrackPlaybackControl(a5)
		beq.s	.notpsg34shared
		moveq_	$C0,d0					; Use PSG 3 channel bits
.notpsg34shared:
		moveq	#$F,d1
		and.w	d6,d1					; Low nibble of frequency
		or.b	d1,d0					; Latch tone data to channel
		lsr.w	#4,d6					; Get upper 6 bits of frequency
		andi.b	#$3F,d6					; Send to latched channel
		move.b	d0,(psginput).l
		move.b	d6,(psginput).l
PSGUpdateFreq_exit:
		rts
; ===========================================================================
PSGSilence:
PSGNoteOff:
		btst	#_sfxoverride,TrackPlaybackControl(a5)	; Is SFX overriding?
		bne.s	PSGNoteOff_exit				; Return if so
SendPSGNoteOff:
		moveq	#$1F,d0					; Maximum volume attenuation
		or.b	TrackVoiceControl(a5),d0		; PSG channel to change
		move.b	d0,(psginput).l
		btst	#_special,TrackPlaybackControl(a5)
		beq.s	.notpsg34shared
		move.b	#$FF,(psginput).l			; If so, stop noise channel while we're at it
.notpsg34shared:
PSGNoteOff_exit:
		rts
; ===========================================================================
PSGSilenceAll:
		lea	(psginput).l,a0
		move.b	#$9F,(a0)	; Silence PSG 1
		move.b	#$BF,(a0)	; Silence PSG 2
		move.b	#$DF,(a0)	; Silence PSG 3
		move.b	#$FF,(a0)	; Silence noise channel
		rts