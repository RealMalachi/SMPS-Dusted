	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing on		; Want listing file, but only the final code in expanded macros
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
CdSubCtrl:	equ $FF8000
LED_NONE:       equ %00
LED_GREEN:      equ %10  ; READY
LED_RED:        equ %01  ; ACCESS
LED_BOTH:       equ %11  ; READY+ACCESS

CdMemCtrl:	equ $FF8002
; ---------------------------------------------------------------------------
	dc.l	$80000, EntryPoint, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt
	dc.l	ErrorInt, ErrorInt, MainInt,  ErrorInt
	dc.l	ErrorInt, ErrorInt, ErrorInt, ErrorInt

EntryPoint:
	move.w	#$2700,sr
.l:	bra.s	.l

MainInt:
	rte

ErrorInt:
	move.w	#$2700,sr
.l:	move.b	#LED_BOTH,(CdSubCtrl)
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	bra.w	.c
.c:	move.b	#LED_NONE,(CdSubCtrl)
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	dbf	d0,*
	bra.s	.l