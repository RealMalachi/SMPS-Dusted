; volume table
DPCM_YMBuffer1	= $A00A00
DPCM_YMBuffer2	= $A00B00
; ---------------------------------------------------------------------------
Sec = 14000 ; Hz per second
Mil = 1000 ; milliseconds per second
dcz80 macro Sample, SampleRev, SampleLoop, SampleLoopRev
	dc.b	(Sample)&$FF,(((Sample)>>8)&$7F)|$80,((Sample)>>15)&$FF
	dc.b	(SampleRev-1)&$FF,(((SampleRev-1)>>8)&$7F)|$80,((SampleRev-1)>>15)&$FF
	dc.b	(SampleLoop)&$FF,(((SampleLoop)>>8)&$7F)|$80,((SampleLoop)>>15)&$FF
	dc.b	(SampleLoopRev-1)&$FF,(((SampleLoopRev-1)>>8)&$7F)|$80,((SampleLoopRev-1)>>15)&$FF
	endm

incdacStart macro
	align $8000
	dcb.b	$18*$10,$00
	endm
incdacEnd macro
	endm

incdac macro Name
Name:		label *
		incbin "name.bin"
Name_End:	label *
		dcb.b	$18*$10,$00
	endm
