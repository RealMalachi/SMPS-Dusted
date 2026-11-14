; ---------------------------------------------------------------------------
DACInitDriver:
		move.w	#$100,d0
		move.w	d0,z80busreq
		move.w	d0,z80busreset
		lea	.z80(pc),a5
		lea	z80ram,a6
		include "src-68k/cmp-zx0.asm"
		moveq	#0,d1
		move.w	d1,z80busreset
		or.l	d0,d0
		or.l	d0,d0
		move.w	d0,z80busreset
		move.w	d1,z80busreq
		rts
; ---------------------------------------------------------------------------
.z80:		binclude "_out/fmbuffer.zx0"
		even
; ===========================================================================
DACLoadBank:
DACUpdateSFX:
DACGuard:
DACUnguard:
DACQueueSample:
DACQueueSampleSFX:
DACPauseSample:
DACResumeSample:
DACStopSample:
DACStopSampleSFX:
DACSetPan:
DACSetVolume:
		rts