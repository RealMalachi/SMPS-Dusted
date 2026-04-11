	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing purecode	; Want listing file, but only the final code in expanded macros
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
cmddef macro command,cmpid
command equ cmpid
	shared command
	endm

musidtrack set -1
musidoff set 0
musdef macro flag1up,flagpalslow,flagnomuffle,loc,cmpid
	if "flag1up"=="START"
musidtrack set 1
musidoff set (*)
flagpalslow	equ musidtrack
	shared flagpalslow
	elseif "flag1up"=="END"
flagpalslow	equ musidtrack
	shared flagpalslow
musidtrack set -1
musidoff set 0
	else
	dc.l (flag1up<>0)<<31|(flagpalslow<>0)<<30|(flagnomuffle<>0)<<29|(loc-((*)+4))&$FFFFFF
cmpid	equ musidtrack
	shared cmpid
musidtrack set musidtrack+1
	endif
	endm

sfxdef macro flagprio,flagbsfx,flagcsfx,flagnomuffle,loc,cmpid
	if "flagprio"=="START"
musidtrack set flagcsfx
flagbsfx	equ musidtrack
	shared flagbsfx
	elseif "flagprio"=="END"
flagbsfx	equ musidtrack
	shared flagbsfx
musidtrack set -1
musidoff set 0
	else
	dc.w  flagprio<<8|(flagbsfx<>0)<<7|(flagcsfx<>0)<<6|(flagnomuffle<>0)<<5,loc-((*)+4)
cmpid	equ musidtrack
	shared cmpid
musidtrack set musidtrack+1
	endif
	endm
; ---------------------------------------------------------------------------
	cmddef smpsramsize,	v_endofram
	cmddef cmd__First,	$F000
	cmddef cmd_FadeoutBGM,	$F000
	cmddef cmd_Fadeout,	$F100
	cmddef cmd_Fadein,	$F200
	cmddef cmd_StopAll,	$F300
	cmddef cmd_StopBGM,	$F301
	cmddef cmd_StopSFX,	$F302
	cmddef cmd_StopBSFX,	$F304
	cmddef cmd_StopPSFX,	$F308
	cmddef cmd_SpeedOff,	$F400
	cmddef cmd_SpeedOn,	$F401
	cmddef cmd_PanStereo,	$F402
	cmddef cmd_PanMono,	$F403
	cmddef cmd_SsgOn,	$F404
	cmddef cmd_SsgOff,	$F405
	cmddef cmd_MuffleOn,	$F406
	cmddef cmd_MuffleOff,	$F407
	cmddef cmd__Last,	$F500
; ---------------------------------------------------------------------------
	include "src-68k/smps-def.asm"
	include "_smps2asm.asm"
	org 0
	include "_sndbank1.asm"
; ---------------------------------------------------------------------------
	end