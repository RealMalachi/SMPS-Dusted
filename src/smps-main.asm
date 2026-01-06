; INPUT: a1 = start of driver ram
; ===========================================================================
; Routine LUT and signature, for binary blob implementations
APILUT:
		bra.w	InitDriver				; 00 ; a0 = driver data, d0.w = driver ram size
		bra.w	RunDriver				; 04 ; 
		bra.w	QueueSound				; 08 ; d0.w = sound id
		bra.w	UpdateFIFO				; 12 ;
		bra.w	ReadComm				; 16 ; d0.b = 
		bra.w	WriteComm				; 20 ; d0.b = 
		bra.w	PauseDriver				; 24 ;
		bra.w	ResumeDriver				; 28 ;
		bra.w	SetupPianoRoll				; 32 ; a0 = piano ram
		bra.w	SetDriverDataPointer			; 36 ; a0 = driver data
		bra.w	DACGuard				; 40 ;
		bra.w	DACUnguard				; 44 ;
; ---------------------------------------------------------------------------
		rept (64-(*))/4
		bra.w	.error
		endr
.sign:		dc.b "SMPS-DUSTED 68K V0.1 BY MALACHI",0
		dc.b [32-((*)-.sign)]" "
.error:
		SMPS_assert "Undefined API command"
; ---------------------------------------------------------------------------
QueueSound:
	set .loc,v_soundqueue_start
	rept (v_soundqueue_end-v_soundqueue_start)/2-1
		tst.w	.loc(a1)
		bne.s	.n
		move.w	d0,.loc(a1)
		rts
.n:
	set .loc,.loc+2
	endr
		tst.w	.loc(a1)
		bne.s	.n2
		move.w	d0,.loc(a1)
.n2:		rts
; ---------------------------------------------------------------------------
PauseDriver:
		moveq_	%11110011,d0
		and.b	v_driverflags(a1),d0
		or.b	#1<<2,d0
		move.b	d0,v_driverflags(a1)
		rts
ResumeDriver:
		or.b	#3<<2,v_driverflags(a1)
		rts
; ---------------------------------------------------------------------------
ReadComm:
		move.b	d0,v_communication_byte(a1)
		rts
WriteComm:
		move.b	v_communication_byte(a1),d0
		rts
; ---------------------------------------------------------------------------
SetDriverDataPointer:
		move.l	a0,d0
		move.w	d0,v_dataptr+2(a1)
		swap	d0
		move.b	d0,v_dataptr+1(a1)
		rts
; ---------------------------------------------------------------------------
		include "src/smps-init.asm"
		include "src/smps-fifo.asm"
		include "src/smps-seq.asm"
		include "src/smps-seq-queue.asm"
		include "src/smps-seq-fade.asm"
		include "src/smps-seq-shared.asm"
		include "src/smps-seq-pcm.asm"
		include "src/smps-seq-fm.asm"
		include "src/smps-seq-psg.asm"
		include "src/smps-piano.asm"
		if __smpsDebug
		include "src/smps-renassert.asm"
		endif

		if (__smpsPCM=="null") || (__smpsTarget=="fuckFM")
		include "src/null/smps-pcm.asm"
;		elseif __smpsPCM=="DirtyPCM"
;		include "src/dirtypcm/smps-pcm.asm"
		elseif __smpsPCM=="MegaPCM1"
		include "src/mpcm1/smps-pcm.asm"
		elseif __smpsPCM=="MegaPCM2"
		include "src/mpcm2/smps-pcm.asm"
;		elseif __smpsPCM=="DualPCM"
;		include "src/dualpcm/smps-pcm.asm"
;		elseif __smpsPCM=="DualPCM-FlexEd"
;		include "src/dualpcm-flexed/smps-pcm.asm"
;		elseif __smpsPCM=="DualClown"
;		include "src/dualclown/smps-pcm.asm"
		else
		fatal "Unknown PCM type"
		endif
; ===========================================================================
		even