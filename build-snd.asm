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
	include "src/smps-def.asm"
	include "def-smps2asm.asm"
	include "smps-ids.asm"
	org 0
	include "inc-bgmsfx.asm"
; ---------------------------------------------------------------------------
	end