; Dusty-PCM, a fairly basic u8 PCM player and FM buffer
; this is primarily to be used in combination with an SMPS sound driver
; -----------------------------------------------------------------------------
rombank	= $6000
ymstat	= $4000
yma0	= $4000
ymd0	= $4001
yma1	= $4002
ymd1	= $4003
; -----------------------------------------------------------------------------
	org $0000
Start:
	di
	ld	Stack,sp

Main:
	jp	Main
; -----------------------------------------------------------------------------
	block $0F00-$
PcmLut:
	block $1000-$
FmLut:
