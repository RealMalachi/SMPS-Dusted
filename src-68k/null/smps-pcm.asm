; ===========================================================================
; a1 = driver ram
DACInitDriver:
;		rts
; ===========================================================================
; a0 = dac bank
; a1 = driver ram
DACLoadBank:
;		rts
; ===========================================================================
; a1 = driver ram
DACGuard:
DACUnguard:
;		rts
; ===========================================================================
; a1 = driver ram
DACPauseSample:
DACResumeSample:
;		rts
; ===========================================================================
; a1 = driver ram
DACUpdateSFX:
;		rts
; ===========================================================================
; a1 = driver ram
; d0.b = pcm channel number, -1 for all channels (stopsample, restorefromsfx)
; d1.w = sample id (queuesample), panning (setpan:00,40,80,C0), volume (setvolume:0-7F)
DACQueueSample:
DACStopSample:
DACSetPan:
DACSetVolume:

DACQueueSampleSFX:
DACStopSampleSFX:
DACSetPanSFX:
DACSetVolumeSFX:

DACRestoreFromSFX:
		rts
