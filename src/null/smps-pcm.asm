; ---------------------------------------------------------------------------
; OUTPUT: d0 = 0 if not playing, non-zero if so ; TODO: use ccr zero bit?
DACCheckIfPlaying:
		moveq	#0,d0
; ---------------------------------------------------------------------------
DACInitDriver:
DACLoadBank:
; ---------------------------------------------------------------------------
DACGuard:
DACUnguard:
; ---------------------------------------------------------------------------
DACQueueSample:
DACQueueSampleSFX:
DACPauseSample:
DACResumeSample:
DACStopSample:
DACSetPan:
DACSetVolume:
		rts