; ---------------------------------------------------------------------------
PCMUpdateTrack:
		subq.b	#1,TrackDurationTimeout(a5)		; Has DAC sample timeout expired?
		bne.s	.sampleongoing				; Return if not
		bsr.s	PCMDoNext
		btst	#_resting,TrackPlaybackControl(a5)
		bne.s	.locret
		bsr.w	DoVolEnv				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bsr.w	DoPanEnv
;PCMPlaySample:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		moveq	#0,d1
		move.b	TrackSavedDAC(a5),d1
		bra.w	DACQueueSample
; ---------------------------------------------------------------------------
.sampleongoing:
		bsr.w	NoteTimeoutUpdate			; bsr is necessary for stack reasons
		bsr.w	UpdateVolume				; bsr is necessary for stack reasons, see `VolEnvCommands`
		bra.w	UpdatePanning
.locret:	rts
; ===========================================================================
PCMDoNext:
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
.gotnote:	bsr.w	PCMSetDAC
		move.b	(a4)+,d5
		bpl.s	.gotnotetime
		subq.w	#1,a4
		bra.w	PCMFinishTrackUpdate
.gotnotetime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
		or.b	#1<<_resting,TrackPlaybackControl(a5)
.norest:	pea	PCMFinishTrackUpdate(pc)
		bra.w	SetDuration
; ---------------------------------------------------------------------------
.gotonlytime:	tst.w	TrackFreq(a5)
		bpl.s	.norest
; note-rest-time-time
	if __smpsRestTimeTime=0
		SMPS_assert "PCM note-rest-time-time"
	else
		or.b	#1<<_resting,TrackPlaybackControl(a5)
		pea	PCMFinishTrackUpdate(pc)
		bra.w	SetDuration
	endif
; ===========================================================================
PCMSetDAC:
		sub.b	#$81,d5
		bcs.s	.rest
		move.b	d5,TrackSavedDAC(a5)
		move.w	#$100,TrackFreq(a5)
		rts
.rest:		or.b	#1<<_resting,TrackPlaybackControl(a5)
		move.w	#-1,TrackFreq(a5)
		if __smpsRestPCM=0
		rts
		else
		moveq	#$3F,d0
		and.b	TrackVoiceControl(a5),d0
		bra.w	DACStopSample
		endif