ymstat	equ $4000
yma0	equ $4000
ymd0	equ $4001
yma1	equ $4002
ymd1	equ $4003

valfor68k macro label,value
label	equ value
	export label
	endm

Start:
	di
	ld	sp,Stack
	ld	hl,ymstat
	ld	d,Buffer1>>8

Loop:

Buffer1Curr	equ $+1
	ld	a,0
Buffer1Index	equ $+1
	cp	0
	jr	Z,.n1
;.w1:	bit	7,(hl)
;	jr	NZ,.w1
	ld	e,a
	ld	a,(de)
	ld	(yma0),a
	inc	e
	ld	a,(de)
	inc	e
	ld	(ymd0),a
	ld	a,e
	ld	(Buffer1Curr),a
.n1:
	inc	d
;	jp	.c1	; cycle consistency
;.c1:

Buffer2Curr	equ $+1
	ld	a,0
Buffer2Index	equ $+1
	cp	0
	jr	Z,.n2
;.w2:	bit	7,(hl)
;	jr	NZ,.w2
	ld	e,a
	ld	a,(de)
	ld	(yma1),a
	inc	e
	ld	a,(de)
	inc	e
	ld	(ymd1),a
	ld	a,e
	ld	(Buffer2Curr),a
.n2:
	dec	d
	jp	Loop

StackEnd:	block 8
Stack:
		align 100h
Buffer1:	block 100h
Buffer2:	block 100h
; ---------------------------------------------------------------------------
ma	equ $A00000
	valfor68k FmBuffer1,ma+Buffer1
	valfor68k FmBuffer2,ma+Buffer2
	valfor68k FmBufferIndex1,ma+Buffer1Index
	valfor68k FmBufferIndex2,ma+Buffer2Index
