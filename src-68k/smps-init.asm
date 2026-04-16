; Subroutine to initialize the sound driver
; INPUT
; a0 = driver data
; a1 = driver ram
; d0.l = desired add-ons bitfield
; ........ ........ ........ .....MCD
; M = 32X PWM
; C = Mega-CD Ricoh PCM
; D = CDDA (Mega-CD or MD+)
; TRASHES: d0-a6
; ---------------------------------------------------------------------------
InitDriver:
.startaddr	= v_startofram
.endaddr	= v_endofram
.clrLen		= .endaddr-.startaddr
		lea	.startaddr(a1),a2
		moveq	#0,d1
	if (.clrLen)/4<>0
		move.w	#(.clrLen)/4-1,d2
.clrLoop:	move.l	d1,(a2)+
		dbf	d2,.clrLoop
	endif
	if (.clrLen)&2
		move.w	d1,(a2)+
	endif
	if (.clrLen)&1
		move.b	d1,(a2)+
	endif
		move.w	#$7AD4,v_random(a1)
		move.l	a0,d1
		move.w	d1,v_dataptr+2(a1)
		swap	d1
		move.b	d1,v_dataptr+1(a1)
		cmp.w	#__smpsDataVer,drvdata.version(a0)
		beq.s	.okayitsfine
		SMPS_assert "Driver data version type doesn't match the drivers expected version type, TODO: print both"
.okayitsfine:

		bsr.s	Detect_Firecore
		seq	d1
		and.w	#1<<v_driverflags.firecore|1<<v_driverflags.ssgoff,d1
		moveq	#1,d2			; 0 = NTSC, 1 = PAL
		and.w	(vdpctrl).l,d2
		ror.b	#8-v_driverflags.pal,d2		; move to appropriate bit (should be 7)
		or.b	d2,d1
		move.b	d1,v_driverflags(a1)

		move.l	a1,a6
		bsr.w	DACInitDriver
		move.l	v_dataptr(a6),a0
		moveq	#0,d1
		move.w	drvdata.uvbdac(a0),d1
		add.l	d1,a0
		bsr.w	DACLoadBank

		bra.w	StopAllSound
; -------------------------------------------------------------------------
; Detects Firecore and actually enhances game if detected. I know, shocking.
; Credit is due to Devon, BigEvilCorporation and Neto
; https://www.neto-games.com.br/hacking_guides/redkid2500.php
; https://blog.bigevilcorporation.co.uk/2018/04/18/taming-the-atgames-firecore/
; https://github.com/BigEvilCorporation/TANGLEWOOD/blob/master/bigevilframework/FRAMEWK/MDMODEL.ASM
;
; The best values are:
; $06 07 - $B00012 - Z80 Clock divider (27 MHz / 6 ) = 4 MHz, with something about 7 setting it to 3.5
; $00 03 - $B0001A - 68K Clock divider (27 MHz / 3 ) = 9 MHz
; $00 77 - $B00018 - PSG Frequency
; $26 20 - $B01054 - FM Frequency and Clock. Some games run better with other values (eg. OutRun $2616, Comix Zone $261B )
; -------------------------------------------------------------------------
; OUTPUT
; ccr = zero bit set (beq) for firecore detected
; TRASHES
; a0/d1-d7
Detect_Firecore:
.DevMode	= $000000
.k68Clock	= $B0001A	; speed divider by 27MHz for 68k
.Z80Clock 	= $B00012	; speed divider by ??MHz for Z80
.FMFreq		= $B01054
.FMClock	= $B01055
.PSGFreq	= $B00018
.psg_freq	= $77
.fm_freq	= $26
.fm_clk		= $20
; Detect improper ABCD emulation (where the results are not as they should be)
; This is a known issue in the AtGames Firecore system.
; if it succeeds, also init some firecore registers
	lea	.FirecoreABCDTbl(pc),a0		; Get test table ready for AtGames Firecore
	moveq	#(.FirecoreABCDTblEnd-.FirecoreABCDTbl)/5-1,d7
.TestLp:
	move.b	(a0)+,d1			; Source operand
	move.b	(a0)+,d2			; Destination operand
	move.b	(a0)+,d3			; CCR

	move	d3,ccr				; Set CCR
	abcd	d1,d2				; Do ABCD
	move	sr,d6				; Get CCR via SR (NOTE: priviledged opcode on 68010+)

	move.b	(a0)+,d4			; Get expected result
	move.b	(a0)+,d5			; Get expected SR

	cmp.b	d2,d4				; Are the results the same?
	bne.s	.ABCDFail			; If not, branch
	cmp.b	d6,d5
	dbne	d7,.TestLp
	bne.s	.ABCDFail
; firecore found, set some registers before ending routine
	move.w	#$0017,(.DevMode).w				; programmer mode
	lea	(.PSGFreq).l,a0
	move.w	#.psg_freq,.PSGFreq-.PSGFreq(a0)		; set PSG to proper frequency
	move.w	#.fm_freq<<8|.fm_clk,.FMFreq-.PSGFreq(a0)	; set FM and sound clock to proper frequency
	move.w	#3,.k68Clock-.PSGFreq(a0)			; 3 for 68K clock divider (9MHz)
	move.w	#$0607,.Z80Clock-.PSGFreq(a0)			; I don't fully understand this, but it clocks the Z80 ~3.5MHz
	move.w	#$0004,(.DevMode).w				; normal mode
	moveq	#0,d1				; set ccr zero bit...
.ABCDFail:					; ...or leave with ccr zero bit cleared
	rts
; -------------------------------------------------------------------------
; ABCD test table and expected results from AtGames Firecore system
.FirecoreABCDTbl:
	;	D0,  D1,  CCR     Result, SR/CCR
	dc.b	$4A, $4A, %00000, $94,    %01000
	dc.b	$4A, $4A, %11111, $95,    %01010
	dc.b	$4E, $4E, %00000, $9C,    %01000
	dc.b	$4E, $4E, %11111, $9D,    %01010
	dc.b	$FF, $FF, %00000, $FE,    %01000
	dc.b	$FF, $FF, %11111, $FF,    %01010
.FirecoreABCDTblEnd:
	even