; ---------------------------------------------------------------------------
; INPUT: 
; TRASHES: d0-d1/a0-a1
DACInitDriver:
.z80ram		= $A00000
.z80busreq	= $A11100
.z80busreset	= $A11200
		move.w	#$100,d0
		move.w	d0,(.z80busreq).l
		move.w	d0,(.z80busreset).l
		lea	.z80(pc),a5
		lea	(.z80ram).l,a6
		include "src-68k/cmp-zx0.asm"
		moveq	#0,d1
		move.w	d1,(.z80busreset).l
		or.l	d0,d0
		or.l	d0,d0
		move.w	d0,(.z80busreset).l
		move.w	d1,(.z80busreq).l
		rts
; ---------------------------------------------------------------------------
.z80:		binclude "_out/mpcm1.zx0"
		even
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
DACUpdateSFX:
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
		SMPS_stopZ80
		add.w	#$81,d1
		SMPS_waitZ80
		move.b	d1,($A00000+Z_MPCM_CommandInput).l
		SMPS_startZ80
		rts
DACPauseSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#$7F,($A00000+Z_MPCM_CommandInput).l
		SMPS_startZ80
		rts
DACResumeSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#0,($A00000+Z_MPCM_CommandInput).l
		SMPS_startZ80
		rts
DACStopSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#$80,($A00000+Z_MPCM_CommandInput).l
		SMPS_startZ80
		rts
DACSetPan:
		moveq_	$B6,d0
		bra.w	WriteFMII
DACSetVolume:
		rts