; Assert screen render handler, renders an error screen and stays there
; ---------------------------------------------------------------------------
; Called via bra/jmp
; STACK:
; +0 | Assert text (modified ASCII, see below)
; ---------------------------------------------------------------------------
RenderAssert:
	move	#$2700,sr
	bsr.w	StopAllSound.skipram
; vdp
	lea	vdpctrl,a5
	lea	vdpdata-vdpctrl(a5),a4
	tst.w	(a5)						; clear vdp write pending
	lea	ErrorVDP(pc),a6
	move.w	#$8000,d1
	moveq	#(ErrorVDP.end-ErrorVDP)-1,d0
.vdploop:
	move.b	(a6)+,d1
	move.w	d1,(a5)
	add.w	#$100,d1
	dbf	d0,.vdploop
; cram
	move.l	#vdpComm(0,CRAM_WRITE),(a5)
	move.l	#$000<<16|$EEE,(a4)				; black and white
; vsram
	moveq	#0,d0
	move.l	#vdpComm(0,VSRAM_WRITE),(a5)
	move.l	d0,(a4)
; vram
; clear what we're using
	moveq	#0,d0
	move.l	#vdpComm(0,VRAM_WRITE),(a5)
	move.w	#(smpsren_vram_length*32)/4-1,d2
.vramclr:
	move.l	d0,(a4)
	dbf	d2,.vramclr
; load font
; modified 1bpp converter by vladikcomper:
; https://github.com/vladikcomper/md-modules/blob/master/modules/core/1bpp_Decompress.asm
; used to use a slower converter which used more registers, but was probably smaller
; just thought I'd give some history
	lea	ErrorFont(pc),a6
	move.l	#vdpComm((" ")*32,VRAM_WRITE),(a5)
	lea	ErrorFontTable(pc),a5
	moveq	#$1E,d2
	swap	d4
	move.w	#(ErrorFont.end-ErrorFont)-1,d4
.bpploop:
	move.b	(a6)+,d0			; d0 = %aaaa bbbb
	move.b	d0,d1
	lsr.b	#3,d1				; d1 = %000a aaab
	and.w	d2,d1				; d1 = %000a aaa0
	move.w	(a5,d1.w),(a4)			; decompress first nibble
	add.b	d0,d0				; d0 = %aaab bbb0
	and.w	d2,d0				; d0 = %000b bbb0
	move.w	(a5,d0.w),(a4)			; decompress second nibble
	dbf	d4,.bpploop
	lea	vdpctrl-vdpdata(a4),a5
; load text plane
	lea	.headertext(pc),a0
	move.l	#vdpComm(smpsren_vram_plane<<5+planeLoc(64,2,1),VRAM_WRITE),d3
	bsr.s	.rendar
	move.l	(sp),a0						; get assert text
	move.l	#vdpComm(smpsren_vram_plane<<5+planeLoc(64,2,2),VRAM_WRITE),d3
	bsr.s	.rendar
; okay we're done
	move.w	#$8100|%01000100,(a5)				; enable screen display
	bra.s	*
.rendar:
.lineloop:
	move.l	d3,(a5)
.loop:
	move.b	(a0)+,d4
	ext.w	d4				; move bit 7 to bit 15 (priority), clear other bits
	and.w	#$807F,d4
	cmp.b	#$20,d4
	blo.s	.commands
	move.w	d4,(a4)
	bra.s	.loop
.commands:
	clr.w	d1
	move.b	d4,d1
	cmp.w	#2,d1
	bhi.s	.cmd_exit
	add.w	d1,d1
	add.w	d1,d1
	jmp	.cmdlut(pc,d1.w)
.cmdlut:
	bra.w	.cmd_exit					; $00 ; ASCII 03, end of file
	bra.w	.cmd_nextline					; $01 ; ASCII 0A, line feed (next line)
	bra.w	.cmd_regprint					; $02 ; Register print and end of file
.cmd_nextline:
	add.l	#vdpCommDelta(64*2),d3
	bra.w	.lineloop
.cmd_regprint:
.cmd_exit:
	rts
.headertext:	dc.b "SMPS Assert Error:",0
	even

ErrorFontTable:
	dc.w $0000, $0001, $0010, $0011
	dc.w $0100, $0101, $0110, $0111
	dc.w $1000, $1001, $1010, $1011
	dc.w $1100, $1101, $1110, $1111
ErrorVDP:
	dc.b %00000100				; $80, 8-colour mode
	dc.b %00000100				; $81, MD mode, screen disabled, DMA disabled, VInt disabled
	dc.b (smpsren_vram_plane)>>5		; $82, foreground nametable address
	dc.b (smpsren_vram_plane)>>5		; $83, window nametable address
	dc.b (smpsren_vram_plane)>>8		; $84, background nametable address
	dc.b (smpsren_vram_null)>>4		; $85, sprite table address
	dc.b 0					; $86
	dc.b 0					; $87, overscan colour
	dc.b 0					; $88
	dc.b 0					; $89
	dc.b 255				; $8A, HBlank register
	dc.b %00000000				; $8B, full screen scroll
	dc.b %10000001				; $8C, Slow H40, progressive scan, s/h disabled, standard colour output
	dc.b (smpsren_vram_null)>>5		; $8D, hscroll table address
	dc.b 0					; $8E
	dc.b 2					; $8F, VDP auto-inc 2
	dc.b 1					; $90, 64x32 plane size
	dc.b 0					; $91, window h position
	dc.b 0					; $92, window v position
.end:
ErrorFont:	binclude "src/smps-renassert-font.1bpp"
.end:
	even