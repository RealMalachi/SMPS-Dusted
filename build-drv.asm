	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing on	; Want listing file, but only the final code in expanded macros
	supmode on		; We don't need warnings about privileged instructions
	page	0		; Don't want form feeds
;	casesensitive true	; Enable case sensitivity
	if __smpsPrintMessages
	message "Pass \{MOMPASS}"
	endif
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
	include "src-68k/def-pcm.asm"
	include "src-68k/def.asm"
	org 0
	include "src-68k/main.asm"
; ---------------------------------------------------------------------------
	if (MOMPASS=2)&&(__smpsPrintMessages)
	message "Driver requires $\{v_endofram} bytes of ram"
	endif
	end