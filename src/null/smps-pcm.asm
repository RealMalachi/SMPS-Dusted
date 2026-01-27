; ---------------------------------------------------------------------------
DACInitDriver:
DACLoadBank:
		rts
; ---------------------------------------------------------------------------
; a1 = driver ram
DACGuard:
DACUnguard:
		rts
; ---------------------------------------------------------------------------
; INPUT:
; a6 = driver ram
DACUpdateSFX:
		tst.b	v_pcmsfx(a6)
		beq.s	.exit
		moveq	#7,d0
.loop:		btst	d0,v_pcmsfx(a6)
		dbeq	d0,.loop
		bne.s	.exit
		; finders code
		bclr	d0,v_pcmsfx(a6)
		dbf	d0,.loop
.exit:		rts
DACPauseSample:
DACResumeSample:
		rts
; ---------------------------------------------------------------------------
; INPUT:
; a6 = driver ram
; d0.b = pcm number (bit 7 set for SFX)
; d1.w = sample id (queuesample), panning (setpan:00,40,80,C0), volume (setvolume:0-7F)
DACQueueSample:
DACStopSample:
DACSetPan:
DACSetVolume:
		rts