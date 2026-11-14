__PcmName	equ "Null"
; ---------------------------------------------------------------------------
fmstart macro ymstatreg
	; no starting for you!
	endm
fmwait macro ymstatreg,ymregnum
	SMPS_stopZ80
	move.w	d7,-(sp)
	clr.w	d7
	if ymregnum=0
	lea	(FmBuffer1).l,ymstatreg
	move.b	FmBufferIndex1-FmBuffer1(ymstatreg),d7
	else
	lea	(FmBuffer2).l,ymstatreg
	move.b	FmBufferIndex2-FmBuffer2(ymstatreg),d7
	endif
;	SMPS_waitZ80
	endm
fmstop macro ymstatreg,ymregnum
	if ymregnum=0
	move.b	d7,FmBufferIndex1-FmBuffer1(ymstatreg)
	else
	move.b	d7,FmBufferIndex2-FmBuffer2(ymstatreg)
	endif
	move.w	(sp)+,d7
	SMPS_startZ80
	endm
fmwrite macro ymstatreg,ymareg,ymdreg,ymregnum
	move.b	ymareg,0(ymstatreg,d7.w)
	move.b	ymdreg,1(ymstatreg,d7.w)
	addq.b	#2,d7
	endm
fmdelay macro
	; tch, trying to delay. loser.
	endm
updfifo macro
	SMPS_assert "Z80 FM Buffer has no FIFO"
	endm
; ---------------------------------------------------------------------------
	RELAXED ON	; 0x syntax
	include "_out/fmbuffer.exp"
	RELAXED OFF
; ---------------------------------------------------------------------------
pcmdefext macro
	dc.w 0
	endm
pcmdefend macro
	!dc.w -1
	endm
