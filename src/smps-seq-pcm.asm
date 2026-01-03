; ---------------------------------------------------------------------------
DACUpdateTrack:
		subq.b	#1,TrackDurationTimeout(a5)		; Has DAC sample timeout expired?
		bne.s	.sampleongoing				; Return if not
		bsr.s	DACDoNext
		bsr.w	DoVolEnv				; bsr is necessary for stack reasons, see `VolEnvCommands`
;DACPlaySample:
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		bne.s	.locret
		move.w	TrackSavedDAC(a5),d0
		cmpi.w	#$80,d0
		bne.w	DACQueueSample
		bra.w	DACStopSample
; ---------------------------------------------------------------------------
.sampleongoing:
		;bsr.w	NoteTimeoutUpdate			; bsr is necessary for stack reasons
		bsr.w	UpdateVolume				; bsr is necessary for stack reasons, see `VolEnvCommands`
.locret:	rts
; ---------------------------------------------------------------------------
DACDoNext:
		and.b	#$FF!(1<<_resting|1<<_noattack),TrackPlaybackControl(a5)
		btst	#_holdnotes,TrackPlaybackControl(a5)
		beq.s	.notheld
		or.b	#1<<_noattack,TrackPlaybackControl(a5)
.notheld:
		move.l	TrackDataPointer(a5),a4
.sampleloop:	moveq	#0,d5
		move.b	(a4)+,d5
		bpl.s	.gotduration
		cmpi.b	#$E0,d5
		bhs.s	.coord
.gotnote:
		move.w	d5,TrackSavedDAC(a5)
		moveq	#0,d5
		move.b	(a4)+,d5
		bpl.s	.gotduration
		subq.w	#1,a4
		bra.s	.finish
.coord:		pea	.sampleloop(pc)
		bra.w	CoordFlag				; manipulates stack
; ---------------------------------------------------------------------------
.gotduration:	bsr.w	SetDuration

.finish:
; FinishTrackUpdate
		move.l	a4,d0
		move.w	d0,TrackDataPointer+2(a5)
		swap	d0
		move.b	d0,TrackDataPointer+1(a5)
		move.b	TrackSavedDuration(a5),TrackDurationTimeout(a5)
		moveq	#1<<_noattack,d0
		and.b	TrackPlaybackControl(a5),d0
		bne.s	.locret
		move.b	TrackNoteTimeoutMaster(a5),TrackNoteTimeout(a5)
.locret:
		rts
; ===========================================================================