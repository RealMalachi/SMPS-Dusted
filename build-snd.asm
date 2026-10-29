	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing purecode	; Want listing file, but only the final code in expanded macros
	supmode on		; We don't need warnings about privileged instructions
	page	0		; Don't want form feeds
;	casesensitive true	; Enable case sensitivity
	if __smpsPrintMessages
	message "Pass \{MOMPASS}"
	endif
even macro
	if (*)&1
	!dc.b 105
	endif
	endm
; sign extend to account for assembler safety
moveq_ macro val,reg
	!moveq	#(-(((val)&(1<<7))<<1))|(val),reg
	endm
; ---------------------------------------------------------------------------
headerdef macro bgmidprefix,sfxidprefix,pcmidprefix,musicindex,soundindex,fminstlist,volenvlist,modenvlist,panenvlist,samplelist,fmdrumlist,psgdrumlist,pcmdrumlist
.s:	!dc.w bgmidprefix_Last-bgmidprefix_First
	!dc.w sfxidprefix_Last-sfxidprefix_First
	!dc.w pcmidprefix_Last-pcmidprefix_First
	!dc.w __smpsDataVer
	!dc.w musicindex-.s
	!dc.w soundindex-.s
	!dc.w fminstlist-.s
	!dc.w volenvlist-.s
	!dc.w modenvlist-.s
	!dc.w panenvlist-.s
	!dc.w samplelist-.s
	!dc.w fmdrumlist-.s
	!dc.w psgdrumlist-.s
	!dc.w pcmdrumlist-.s
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
	!dc.l (flag1up<>0)<<31|(flagpalslow<>0)<<30|(flagnomuffle<>0)<<29|(loc-((*)+4))&$FFFFFF
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
	!dc.w  flagprio<<8|(flagbsfx<>0)<<7|(flagcsfx<>0)<<6|(flagnomuffle<>0)<<5,loc-((*)+4)
cmpid	equ musidtrack
	shared cmpid
musidtrack set musidtrack+1
	endif
	endm
; ---------------------------------------------------------------------------
	include "_settings.asm"
	include "src-68k/def-pcm.asm"
	include "_smps2asm.asm"
	org 0
	include "_sndbank1.asm"
; ---------------------------------------------------------------------------
	end