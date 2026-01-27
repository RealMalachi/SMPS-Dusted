; Assert screen render handler, renders an error screen and stays there
; ---------------------------------------------------------------------------
; Called via bra/jmp
; STACK:
; +0 | Assert text (modified ASCII, see below)
; ---------------------------------------------------------------------------
RenderAssert:
.ass	= 2+((8+7)*4)	; start of assert data
	move.w	sr,-(sp)
	move	#$2700,sr
	movem.l	d0-a6,-(sp)
	lea	.ass(sp),a1
	bsr.w	StopAllSound.skipram
; vdp
	lea	(vdpctrl).l,a5
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
.rendar:
	moveq	#0,d0
.lineloop:
	move.l	d3,(a5)
.loop:	move.b	(a0)+,d4
	ext.w	d4				; move bit 7 to bit 15 (priority), clear other bits
	and.w	#$807F,d4
	cmp.b	#$20,d4
	blo.s	.commands
	move.w	d4,(a4)
	addq.w	#1,d0
	cmp.w	#36,d0
	blo.s	.loop
	bra.w	.cmd_nextline
.commands:
	clr.w	d1
	move.b	d4,d1
	cmp.w	#(.cmdlute-.cmdlut)/4,d1
	bhs.s	.cmd_exit
	add.w	d1,d1
	add.w	d1,d1
	jmp	.cmdlut(pc,d1.w)
.cmdlut:
	bra.w	.cmd_exit					; $00 ; ASCII 03, end of file
	bra.w	.cmd_nextline					; $01 ; ASCII 0A, line feed (next line)
	bra.w	.cmd_nextprint					; $02 ; new assert
	bra.w	.cmd_nextprintline				; $03 ; new assert and line
	bra.w	.cmd_regprint					; $04 ; Print register
	bra.w	.cmd_regdataprint				; $04 ; Print data relative to address from register
.cmdlute:
; okay we're done here, show's over
.cmd_exit:
	move.w	#$8100|%01000100,(a5)				; enable screen display
	bra.s	*
; TODO: safety, a lot of it
.cmd_nextprint:
	move.l	(a1)+,a0					; get assert text
	bra.w	.loop
.cmd_nextprintline:
	move.l	(a1)+,a0					; get assert text
;	bra.s	.cmd_nextline
.cmd_nextline:
	moveq	#0,d0
	add.l	#vdpCommDelta(64*2),d3
	bra.w	.lineloop
.cmd_regdataprint:	; register, offset, size
	clr.w	d1
	move.b	(a0)+,d1
	lsl.w	#2,d1
	move.l	(sp,d1.w),a1
	clr.w	d1
	move.b	(a0)+,d1
	move.l	(a1,d1.w),d1
	moveq	#8,d2
	move.b	(a0)+,d2
	bra.s	.cmd_regdataprint_cont
.cmd_regprint:
	clr.w	d1
	move.b	(a0)+,d1
	lsl.w	#2,d1
	move.l	(sp,d1.w),d1
	moveq	#8,d2
.cmd_regdataprint_cont:
	add.w	d2,d0
	cmp.w	#36,d0
	blo.s	.cmd_regprint_goon
	move.w	d2,d0
	add.l	#vdpCommDelta(64*2),d3
	move.l	d3,(a5)
.cmd_regprint_goon:
; TODO: size based on size
	rept 8
	rol.l	#4,d1
	moveq	#$F,d2						; copy d1 to d2
	and.b	d1,d2						; remove high nybble
	cmp.b	#$A,d2						; convert hex nybble to ascii
	ble.s	.num
	addq.b	#7,d2						; letters ; ('A'-'0')-$A = 7
.num:	add.b	#'0',d2						; numbers ; val+'0'
	move.w	d2,(a4)
	endr
	bra.w	.loop
.headertext:	dc.b "SMPS Assert Error:",1,"====================================",2
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