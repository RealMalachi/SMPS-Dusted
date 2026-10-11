; Routine LUT and signature, for binary blob implementations
routlut macro routine
	SMPS_share	SMPS_Offset_routine,(*)
	bra.w	routine
	endm
APILUT:								; all: a1 = start of driver ram
		routlut InitDriver				; a0 = driver data, d0.w = driver ram size
		routlut RunDriver				; 
		routlut QueueSound				; d0.w = sound id
		routlut UpdateFIFO				; 
		routlut ReadComm				; d0.b = comm, d1.b = index
		routlut WriteComm				; d0.b = comm, d1.b = index
		routlut GuardDriver				; 
		routlut UnguardDriver				; 
		routlut SetupPianoRoll				; a0 = piano ram
		routlut PlayCDDA				; d0.b = track ID
		routlut PauseDriver
		routlut ResumeDriver
		routlut SetBgmTempo				; d0.w = new tempo
		routlut SetBgmSpeed				; d0.b = new speed
; ---------------------------------------------------------------------------
		align $10,$FF
		SMPS_share SMPS_Offset_Signature,(*)
.sign:		dc.b "SMPS-DUSTED 68K V0.1 BY MALACHI",0
		dc.b [32-((*)-.sign)]" "
; ---------------------------------------------------------------------------
		include "src-68k/init.asm"
		include "src-68k/misc.asm"
		include "src-68k/cdda.asm"
		include "src-68k/seq.asm"
		include "src-68k/seq-queue.asm"
		include "src-68k/seq-shared.asm"
		include "src-68k/seq-pcm.asm"
		include "src-68k/seq-fm.asm"
		include "src-68k/seq-psg.asm"
		include "src-68k/piano.asm"
		if __smpsDebug
		include "src-68k/renassert.asm"
		endif

		if (__smpsPCM=="null") || (__smpsTarget=="fuckFM")
		include "src-68k/null/pcm.asm"
;		elseif __smpsPCM=="DirtyPCM"
;		include "src-68k/dirtypcm/pcm.asm"
		elseif __smpsPCM=="MegaPCM1"
		include "src-68k/mpcm1/pcm.asm"
		elseif __smpsPCM=="MegaPCM2"
		include "src-68k/mpcm2/pcm.asm"
;		elseif __smpsPCM=="DualPCM"
;		include "src-68k/dualpcm/pcm.asm"
;		elseif __smpsPCM=="DualPCM-FlexEd"
;		include "src-68k/dualpcm-flexed/pcm.asm"
;		elseif __smpsPCM=="DualClown"
;		include "src-68k/dualclown/pcm.asm"
		else
		fatal "Unknown PCM type"
		endif
; ===========================================================================
		even