	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing on	; Want listing file, but only the final code in expanded macros
	supmode on		; We don't need warnings about privileged instructions
	page	0		; Don't want form feeds
;	casesensitive true	; Enable case sensitivity
	message "Pass \{MOMPASS}"
even macro
	if (*)&1
	dc.b 105
	endif
	endm
; sign extend to account for assembler safety
moveq_ macro val,reg
	!moveq	#(-(((val)&(1<<7))<<1))|(val),reg
	endm
; ---------------------------------------------------------------------------
	include "_settings.asm"
	include "src-68k/smps-def.asm"
	if (__smpsPCM=="null") || (__smpsTarget=="fuckFM")
	include "src-68k/null/smps-pcm-def.asm"
;	elseif __smpsPCM=="DirtyPCM"
;	include "src-68k/dirtypcm/smps-pcm-def.asm"
	elseif __smpsPCM=="MegaPCM1"
	include "src-68k/mpcm1/smps-pcm-def.asm"
	elseif __smpsPCM=="MegaPCM2"
	include "src-68k/mpcm2/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualPCM"
;	include "src-68k/dualpcm/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualPCM-FlexEd"
;	include "src-68k/dualpcm-flexed/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualClown"
;	include "src-68k/dualclown/smps-pcm-def.asm"
	else
	fatal "Unknown PCM type"
	endif
	org 0
	include "src-68k/smps-main.asm"
; ---------------------------------------------------------------------------
cmddef macro command,cmpid
	if cmpid<>""
command equ cmpid
	endif
	shared command
	endm
	cmddef smpsramsize,		v_endofram
	cmddef smpspianoramsize,	$400
	cmddef cmd__First,		$F000
	cmddef cmd_FadeoutBGM,		$F000
	cmddef cmd_Fadeout,		$F100
	cmddef cmd_Fadein,		$F200
	cmddef cmd_StopAll,		$F300
	cmddef cmd_StopBGM,		$F301
	cmddef cmd_StopSFX,		$F302
	cmddef cmd_StopBSFX,		$F304
	cmddef cmd_StopPSFX,		$F308
	cmddef cmd_SpeedOff,		$F400
	cmddef cmd_SpeedOn,		$F401
	cmddef cmd_PanStereo,		$F402
	cmddef cmd_PanMono,		$F403
	cmddef cmd_SsgOn,		$F404
	cmddef cmd_SsgOff,		$F405
	cmddef cmd_MuffleOn,		$F406
	cmddef cmd_MuffleOff,		$F407
	cmddef cmd__Last,		$F500
; ---------------------------------------------------------------------------
	if MOMPASS=1
	message "Driver requires $\{v_endofram} bytes of ram"
	endif
	end