; ---------------------------------------------------------------------------
DACUpdateTrack:
		subq.b	#1,TrackDurationTimeout(a5)		; Has DAC sample timeout expired?
		bne.s	.sampleongoing				; Return if not
		bsr.s	DACDoNext
		btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	DoVolEnv				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	DoPanEnv				; bsr is necessary for stack reasons
;DACPlaySample:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		move.w	TrackSavedDAC(a5),d1
		bpl.w	DACQueueSample
		btst	#_noattack,TrackPlaybackControl(a5)
		bne.s	.locret
		bra.w	DACStopSample
; ---------------------------------------------------------------------------
.sampleongoing:
		bsr.w	NoteTimeoutUpdate			; bsr is necessary for stack reasons
		bsr.w	UpdateVolume				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	UpdatePanning				; bsr is necessary for stack reasons
.locret:	rts
; ===========================================================================
DACDoNext:
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
.gotnote:
		move.w	d5,d1
		sub.w	#$81,d1
		bcc.s	.gotnoteitisntarest
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bsr.w	DACStopSample
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		moveq	#-1,d1
.gotnoteitisntarest:
		move.w	d1,TrackFreq(a5)

		move.b	(a4)+,d5
		bpl.s	.gotnotetime
		subq.w	#1,a4
		bra.w	DACFinishTrackUpdate
.gotnotetime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.norest:	pea	DACFinishTrackUpdate(pc)
		bra.w	SetDuration
; ---------------------------------------------------------------------------
.gotonlytime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
	if __smpsDebug
; note-rest-time-time varies on different versions of SMPS, as noted in Clone Drivers asserts
		SMPS_assert "DAC note-rest-time-time"
	else
; note-rest-time-time
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		pea	DACFinishTrackUpdate(pc)
		bra.w	SetDuration
	endif
; ===========================================================================