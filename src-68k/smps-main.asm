; INPUT: a1 = start of driver ram
; ===========================================================================
; Routine LUT and signature, for binary blob implementations
APILUT:
		bra.w	InitDriver				; 00 ; a0 = driver data, d0.w = driver ram size
		bra.w	RunDriver				; 04 ; 
		bra.w	QueueSound				; 08 ; d0.w = sound id
		bra.w	UpdateFIFO				; 12 ;
		bra.w	ReadComm				; 16 ; d0.b = comm, d1.b = index
		bra.w	WriteComm				; 20 ; d0.b = comm, d1.b = index
		bra.w	GuardDriver				; 24 ;
		bra.w	UnguardDriver				; 28 ;
		bra.w	SetupPianoRoll				; 32 ; a0 = piano ram
		bra.w	RunMiscCommand				; 36 ; d0.w = command, other inputs depend on the command
		bra.w	PlayCDDA				; 40 ; d0.b = track ID
		rept (64-(*))/4
		bra.w	.error
		endr
; ---------------------------------------------------------------------------
.sign:		dc.b "SMPS-DUSTED 68K V0.1 BY MALACHI",0
		dc.b [32-((*)-.sign)]" "
.error:		SMPS_assert "Undefined API command"
; ---------------------------------------------------------------------------
		include "src-68k/smps-init.asm"
		include "src-68k/smps-misc.asm"
		include "src-68k/smps-cdda.asm"
		include "src-68k/smps-seq.asm"
		include "src-68k/smps-seq-queue.asm"
		include "src-68k/smps-seq-shared.asm"
		include "src-68k/smps-seq-pcm.asm"
		include "src-68k/smps-seq-fm.asm"
		include "src-68k/smps-seq-psg.asm"
		include "src-68k/smps-piano.asm"
		if __smpsDebug
		include "src-68k/smps-renassert.asm"
		endif

		if (__smpsPCM=="null") || (__smpsTarget=="fuckFM")
		include "src-68k/null/smps-pcm.asm"
;		elseif __smpsPCM=="DirtyPCM"
;		include "src-68k/dirtypcm/smps-pcm.asm"
		elseif __smpsPCM=="MegaPCM1"
		include "src-68k/mpcm1/smps-pcm.asm"
		elseif __smpsPCM=="MegaPCM2"
		include "src-68k/mpcm2/smps-pcm.asm"
;		elseif __smpsPCM=="DualPCM"
;		include "src-68k/dualpcm/smps-pcm.asm"
;		elseif __smpsPCM=="DualPCM-FlexEd"
;		include "src-68k/dualpcm-flexed/smps-pcm.asm"
;		elseif __smpsPCM=="DualClown"
;		include "src-68k/dualclown/smps-pcm.asm"
		else
		fatal "Unknown PCM type"
		endif
; ===========================================================================
		even