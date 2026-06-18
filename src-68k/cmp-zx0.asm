; ===========================================================================
; unzx0_68000.s - ZX0 decompressor for 68000
; Original version by Emmanuel Marty.
; Rewritten and modified by ctr 2022
; Adjusted to fit AS(s) and Dusteds ABI by Malachi
; https://github.com/superctr/MDSDRV/blob/master/src/mdssub.inc#L178
; ---------------------------------------------------------------------------
; INPUT:
; a5 = source
; a6 = destination
; ---------------------------------------------------------------------------
	movem.l	d0-d2/a0,-(sp)
	moveq	#-128,d0
	moveq	#-1,d2
.literal:
	moveq	#1,d1
	bsr.s	.gamma
	subq.w	#1,d1
.lit_copy:
	move.b	(a5)+,(a6)+
	dbra	d1,.lit_copy

	add.b	d0,d0
	bcs.s	.new_offset

.last_offset:					;copy from last offset
	moveq	#1,d1
	bsr.s	.gamma
	subq.w	#1,d1

.match:
	move.l	a6,a0
	adda.w	d2,a0
.match_copy:
	move.b	(a0)+,(a6)+
	dbra	d1,.match_copy

	add.b	d0,d0
	bcc.s	.literal

.new_offset:					;copy from new offset
	moveq	#-2,d1
	bsr.s	.gamma
	addq.b	#1,d1
	beq.s	.done				;finished if msb is 256

	move.b	d1,-(sp)			;shift left 8
	move.w	(sp)+,d2
	move.b	(a5)+,d2

	moveq	#1,d1
	asr.l	#1,d2
	bcs.s	.match
	pea	.match(pc)

.gamma_bit:
	add.b	d0,d0
	addx.w	d1,d1
.gamma:
	add.b	d0,d0
	bne.s	.new_byte
	move.b	(a5)+,d0
	addx.b	d0,d0
.new_byte:
	bcc.s	.gamma_bit
	rts
.done:
	movem.l	(sp)+,d0-d2/a0