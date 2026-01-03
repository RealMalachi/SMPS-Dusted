DACInitDriver:
	move.w	#$A0,$10(a6)
	rts

YM_Access_TestRead:
.retry:	lea	($A00000+YM_Access).l,a0	; 12(3,0) 6	; EXT: load access address in Z80
	StopZ80
	tst.b	(a0)+						; EXT: is the Z80 accessing the 68k pointer?
	bne.s	.wait						; EXT: if so, branch and wait for it to finish...
	move.b	(a0)+,d1					; EXT: load lower byte of pointer
	move.b	(a0)+,d0					; EXT: load upper byte of pointer
	StartZ80
	lsl.w	#8,d0						; EXT: shift upper byte up
	move.b	d1,d0						; EXT: put lower byte with it
	move.w	d0,$10+2(a6)					; EXT: store the cue address
	rts
; delay for a long enough time to allow the 68k pointer to be saved correctly.
.wait:	StartZ80
	rept 3
	move.l	(0).w,d0			; 16(4,0) 4
	endr
	btst	d0,d0				;  6(1,0) 2
	bra.s	.retry				; 10(?,?) 2

YM_Access_TestWrite:
	lea	$10+3(a6),a1					; EXT: load the 68k's pointer finish location
.retry:	lea	($A00000+YM_Access).l,a0	; 12(3,0) 6	; EXT: load access address in Z80
	StopZ80
	tst.b	(a0)+						; EXT: is the Z80 accessing the 68k pointer?
	bne.s	.wait						; EXT: if so, branch and wait for it to finish...
	move.b	(a1),(a0)+					; EXT: save lower byte of pointer
	move.b	-(a1),(a0)+					; EXT: save upper byte of pointer
	StartZ80
	rts
; delay for a long enough time to let the Z80 clash with 68k's pointer writing
.wait:	StartZ80
	rept 3
	move.l	(0).w,d0			; 16(4,0) 4
	endr
	btst	d0,d0				;  6(1,0) 2
	bra.s	.retry				; 10(?,?) 2
; ===========================================================================

WriteFM1:
	move.l	$10(a6),a0					; EXT: load Cue pointer
	addq.w	#1,a0						; EXT: skip $40
	StopZ80
	move.b	#0,(a0)+					; EXT: write YM2612 port address
	move.b	d1,(a0)+					; EXT: write YM2612 data
	move.b	d2,(a0)+					; EXT: write YM2612 address
	StartZ80
	move.w	a0,d2						; EXT: load Cue pointer
	andi.w	#$0FFF,d2					; EXT: wrap it
	ori.w	#$1000,d2					; EXT: ''
	move.w	d2,$10+2(a6)					; EXT: update it
	rts

WriteFM2:
	move.l	$10(a6),a0					; EXT: load Cue pointer
	addq.w	#1,a0						; EXT: skip $40
	StopZ80
	move.b	#2,(a0)+					; EXT: write YM2612 port address
	move.b	d1,(a0)+					; EXT: write YM2612 data
	move.b	d2,(a0)+					; EXT: write YM2612 address
	StartZ80
	move.w	a0,d2						; EXT: load Cue pointer
	andi.w	#$0FFF,d2					; EXT: wrap it
	ori.w	#$1000,d2					; EXT: ''
	move.w	d2,$10+2(a6)					; EXT: update it
	rts

WritePCM1:
	StopZ80
	lea	($A00000+PCM1_Sample).l,a1			; MJ: load PCM 1 slot address
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#(CUPCM1_NewSample&$FF),($A00000+CU_Stack).l	; MJ: set routine to run
	move.b	#(CUPCM1_NewSample>>8),($A00000+CU_Stack+1).l
	move.b	#%11001001,($A00000+CUPCM1_RET).l		; MJ: change "NOP" to "RET"
	StartZ80
	rts

WritePCM2:
	StopZ80
	lea	($A00000+PCM2_Sample).l,a1			; MJ: load PCM 2 slot address
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	#%00101000,($A00000+CUPCM2_RET).l		; change "JR NZ" to "JR Z"
	StartZ80
	rts
; ===========================================================================
; ---------------------------------------------------------------------------
; Sample 68k PCM list
; ---------------------------------------------------------------------------
SampleList:
		dc.l	StopSample		; 80 (THIS IS A REST NOTE, DO NOT EDIT...)
		dc.l	Sonic1Kick		; 81
		dc.l	Sonic1Snare		; 82
		dc.l	Sonic1TimpaniLow	; 83
		dc.l	StopSample		; 84
		dc.l	StopSample		; 85
		dc.l	StopSample		; 86
		dc.l	StopSample		; 87
		dc.l	Sonic1TimpaniHigh	; 88
		dc.l	Sonic1TimpaniMid	; 89
		dc.l	Sonic1TimpaniLow	; 8A
		dc.l	Sonic1TimpaniLower	; 8B
; ---------------------------------------------------------------------------
; Sample z80 pointers
; ---------------------------------------------------------------------------
StopSample:		dcz80	SWF_StopSample
Sonic1Kick:		dcz80	SWF_S1Kick
Sonic1Snare:		dcz80	SWF_S1Snare
Sonic1TimpaniHigh:	dcz80	SWF_S1TimpaniHigh
Sonic1TimpaniMid:	dcz80	SWF_S1TimpaniMid
Sonic1TimpaniLow:	dcz80	SWF_S1TimpaniLow
Sonic1TimpaniLower:	dcz80	SWF_S1TimpaniLower
; ---------------------------------------------------------------------------
; Sample file includes
; ---------------------------------------------------------------------------
		align	$20,$FF
SWF_StopSample:	dcb.b	$7FFF,$00
		dc.b	$80
SWF_S1Kick:		incbin	"Dual PCM\Samples\incswf\Sonic 1 Kick.swf"
SWF_S1Snare:		incbin	"Dual PCM\Samples\incswf\Sonic 1 Snare.swf"
SWF_S1TimpaniHigh:	incbin	"Dual PCM\Samples\incswf\Sonic 1 Timpani High.swf"
SWF_S1TimpaniMid:	incbin	"Dual PCM\Samples\incswf\Sonic 1 Timpani Mid.swf"
SWF_S1TimpaniLow:	incbin	"Dual PCM\Samples\incswf\Sonic 1 Timpani Low.swf"
SWF_S1TimpaniLower:	incbin	"Dual PCM\Samples\incswf\Sonic 1 Timpani Lower.swf"
; ===========================================================================