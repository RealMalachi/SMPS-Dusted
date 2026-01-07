; ---------------------------------------------------------------------------
; INPUT: 
; TRASHES: d0-d1/a0-a1
DACInitDriver:
.z80ram		= $A00000
.z80busreq	= $A11100
.z80busreset	= $A11100
		move.w	#$100,d0
		move.w	d0,(.z80busreq).l
		move.w	d0,(.z80busreset).l
		lea	.z80(pc),a0
		lea	(.z80ram).l,a1
; ---------------------------------------------------------------------------
; KosinskiPlus decompression
	movem.l	d3-d5/a5,-(sp)
; KosPlusDec:
	moveq	#0,d3					; Flag as having no bits left.
	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.FetchCodeLoop:
	; Code 1 (Uncompressed byte).
	move.b	(a0)+,(a1)+

.FetchNewCode:
	bsr.s	.ReadBit
	bcs.s	.FetchCodeLoop				; If code = 1, branch.

	; Codes 00 and 01.
	moveq	#-1,d5
	lea	(a1),a5
	bsr.s	.ReadBit
	bcs.s	.Code_01

	; Code 00 (Dictionary ref. short).
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	; Always copy at least two bytes.
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bsr.s	.ReadBit
	bcc.s	.Copy_01
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+

.Copy_01:
	bsr.s	.ReadBit
	bcc.s	.FetchNewCode
	bra.s	.Copy_01_Cont
;	move.b	(a5)+,(a1)+
;	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.Code_01:
	; Code 01 (Dictionary ref. long / special).
	move.b	(a0)+,d4				; d4 = %xxxxxxxx HHHHHCCC.
	move.b	d4,d5					; d5 = %11111111 HHHHHCCC.
	lsl.w	#5,d5					; d5 = %111HHHHH CCC00000.
	move.b	(a0)+,d5				; d5 = %111HHHHH LLLLLLLL.
	adda.w	d5,a5

	and.w	#7,d4					; d4 = %00000000 00000CCC.
	beq.s	.dolargecopy
; ---------------------------------------------------------------------------
.StreamCopy:
	neg.w	d4					; -10
	addq.w	#8,d4					; 10-2, -1 for dbf, another -1 for .Copy_01_Cont
	bra.s	.largeloop
; ---------------------------------------------------------------------------
.ReadBit:
	dbra	d3,.SkipRead
	moveq	#7,d3					; We have 8 new bits, but will use one up below.
	move.b	(a0)+,d0				; Get desc field low-byte.
.SkipRead:
	add.b	d0,d0					; Get a bit from the bitstream.
	rts
; ---------------------------------------------------------------------------
.dolargecopy:
	; special mode (extended counter)
	move.b	(a0)+,d4				; Read cnt
	beq.s	.Quit					; If cnt=0, quit decompression.
	addq.w	#7,d4					; val+8, -1 for .Copy_01_Cont
.largeloop:
	move.b	(a5)+,(a1)+
	dbra	d4,.largeloop

.Copy_01_Cont:
	move.b	(a5)+,(a1)+
	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.Quit:
	movem.l	(sp)+,d3-d5/a5
; ---------------------------------------------------------------------------
		moveq	#0,d1
		move.w	d1,(.z80busreset).l
		or.l	d0,d0
		or.l	d0,d0
		move.w	d0,(.z80busreset).l
		move.w	d1,(.z80busreq).l
		rts
.z80:		binclude "src/mpcm1/z80.kosp"
.z80e:		even
; ===========================================================================
; INPUT
; a0 = pcm table
; MegaPCM1 want them in this format:
; 00h - Flags
; 01h - Pitch
; 02h - Start Bank
; 03h - End Bank
; 04h - Start Offset LSB
; 05h - Start Offset MSB
; 06h - End Offset LSB
; 07h - End Offset MSB
; dc.w -1 acts as an end marker
DACLoadBank:
		SMPS_stopZ80
		lea	($A00000+Z_MPCM_SampleTable).l,a1
		moveq	#$5F-1,d2
		SMPS_waitZ80
.loop:
		move.l	(a0)+,d0		; start
		add.l	a0,d0
		move.l	(a0)+,d1		; end
		add.l	a0,d1
		move.b	(a0)+,(a1)+		; fag
		move.b	(a0)+,(a1)+		; pitch
; TODO: add WAVE check from MPCM2
						; bBBBBBBB BMMMMMMM LLLLLLLL
		add.l	d0,d0			; BBBBBBBB MMMMMMML LLLLLLL0
		add.l	d1,d1
		addq.b	#1,d0			; BBBBBBBB MMMMMMML LLLLLLL1
		addq.b	#1,d1
		ror.w	#1,d0			; BBBBBBBB 1MMMMMMM LLLLLLLL
		ror.w	#1,d1
		swap	d0
		swap	d1
		move.b	d0,(a1)+		; bank
		move.b	d1,(a1)+
		swap	d0
		move.b	d0,(a1)+		; lsb
		lsr.w	#8,d0
		move.b	d0,(a1)+		; msb
		swap	d1
		move.b	d1,(a1)+
		lsr.w	#8,d1
		move.b	d1,(a1)+

		tst.b	(a0)			; exit if we hit the terminator -1...
		dbne	d2,.loop		; ...or we reach $5F samples
		SMPS_startZ80
		rts
; ===========================================================================
; OUTPUT: d0 = 0 if not playing, non-zero if so ; TODO: use ccr zero bit?
DACCheckIfPlaying:
		moveq	#0,d0
		rts
; ---------------------------------------------------------------------------
; INPUT: a1 = driver ram
DACGuard:
		SMPS_stopZ80
		SMPS_waitZ80
		rts
DACUnguard:
		SMPS_startZ80
		rts
; ---------------------------------------------------------------------------
DACQueueSample:
DACQueueSampleSFX:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	d0,($A00000+Z_MPCM_CommandInput).l
		SMPS_startZ80
		rts
DACPauseSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#$7F,($A00000+Z_MPCM_CommandInput).l		; pause DAC
		SMPS_startZ80
		rts
DACResumeSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#0,($A00000+Z_MPCM_CommandInput).l		; resume DAC
		SMPS_startZ80
		rts
DACStopSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#$80,($A00000+Z_MPCM_CommandInput).l		; stop DAC
		SMPS_startZ80
		rts
; INPUT
; d0 = pan
DACSetPan:
		moveq_	$B6,d1
		bra.w	WriteFMII
DACSetVolume:
		rts