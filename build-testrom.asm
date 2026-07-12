	cpu 68000
	padding off		; We don't want AS padding out dc.b instructions
	listing on		; Want listing file, but only the final code in expanded macros
	supmode on		; We don't need warnings about privileged instructions
	page	0		; Don't want form feeds
;	casesensitive true	; Enable case sensitivity
	if __smpsPrintMessages
	message "Pass \{MOMPASS}"
	endif
even macro
	if (*)&1
	dc.b 105
	endif
	endm
; sign extend to account for assembler safety
moveq_ macro val,reg
	!moveq	#(-(((val)&(1<<7))<<1))|(val),reg
	endm
; tells the Z80 to start again
startZ80 macro
	move.w	#$000,io_z80bus
	endm
; tells the Z80 to stop, and waits for it to finish stopping (acquire bus)
stopZ80 macro
	move.w	#$100,io_z80bus
	endm
; tells the Z80 to wait for it to finish stopping (acquire bus)
waitZ80 macro
$$w:	btst	#0,io_z80bus
	bne.s	$$w
	endm
dcpad macro padto,padval,byteval
$$p:	dc.ATTRIBUTE	byteval
	dc.b	[padto-((*)-$$p)]padval
	endm

; function to calculate the location of a tile in plane mappings
planeLoc function width,col,line,(((width*line)+col)*2)

; makes a VDP command
vdpComm function addr,type,(((type)&3)<<30)|((addr&$3FFF)<<16)|(((type)&$FC)<<2)|((addr&$C000)>>14)

; makes a VDP address difference
vdpCommDelta function addr,((addr&$3FFF)<<16)|((addr&$C000)>>14)

; simplication of the VDP memory access flags
VRAM_READ	equ %000000
VRAM_WRITE	equ %000001
VRAM_DMA	equ %100001
VRAM_COPYDMA	equ %110001
VRAM_READ8	equ %001100	; 8bit half reads, useful for reading with 128kb vram

CRAM_READ	equ %001000
CRAM_WRITE	equ %000011
CRAM_DMA	equ %100011
CRAM_COPYDMA	equ %110011

VSRAM_READ	equ %000100
VSRAM_WRITE	equ %000101
VSRAM_DMA	equ %100101
VSRAM_COPYDMA	equ %110101

vram_null	equ $000
vram_plane	equ $100
vram_length	equ $200
; ---------------------------------------------------------------------------
	if __smpsDebug==0
	include "smps-def.asm"
	else
	include "smps-def-debug.asm"
	endif
	include "smps-ids.asm"
; ram def
	phase $FF0000
v_start:		ds.b 0
v_soundram:		ds.b smpsramsize
			ds.b $FF0800-(*)
v_pianoram:		ds.b smpspianoramsize
			ds.b $FF1000-(*)

			ds.b (*)&1
v_stackend:		ds.b $100
v_stack:		ds.b 0

			ds.b (*)&1
v_select:		ds.w 1
v_prevselect:		ds.w 1
v_apiindex:		ds.w 1
v_soundid:		ds.w 1
v_shortcut:		ds.w 1
v_misccmd:		ds.w 1
v_miscparam:		ds.w 1
v_cddaid:		ds.b 1
v_commindex:		ds.b 1
v_commval:		ds.b 1
v_runinvint:		ds.b 1
v_dmalen:		ds.w 1
v_hint:			ds.b 1

			ds.b (*)&1
v_jpad:			ds.b 0
v_jpad1held:		ds.b 1
v_jpad1press:		ds.b 1
v_jpad2held:		ds.b 1
v_jpad2press:		ds.b 1

v_vsync:		ds.b 1

			align 4	; this works
v_hardresetend:		ds.b 0
v_softresetend:		ds.b 0
v_end:			ds.b 0
	dephase
; hardware def
vdpdata		equ $C00000
vdpctrl		equ $C00004
io_z80ram	equ $A00000
io_z80ramend	equ $A02000
io_z80bus	equ $A11100
io_z80reset	equ $A11200
io_hardware	equ $A10001
io_jpad1data	equ $A10003
io_jpad2data	equ $A10005
io_jpad3data	equ $A10007
io_jpad1ctrl	equ $A10009
io_jpad2ctrl	equ $A1000B
io_jpad3ctrl	equ $A1000D
io_vdplock	equ $A14000

btnSTART	equ 7
btnA		equ 6
btnC		equ 5
btnB		equ 4
btnRIGHT	equ 3
btnLEFT		equ 2
btnDOWN		equ 1
btnUP		equ 0
; ---------------------------------------------------------------------------
	org 0
RomStart:
		dc.l	v_stack,	EntryPoint,	BusError,	AddressError
		dc.l	IllegalInstr,	ZeroDivide,	ChkInstr,	TrapvInstr
		dc.l	PrivilegeViol,	Trace,		Line1010Emu,	Line1111Emu
		dc.l	0,		CoProtocolViol,	FormatError,	InitIntError
		dcpad.b	32," ","I dunno man"
; md: 1 = unused, 2 = exint/sint, 3 = unused, 4 = hint,     5 = unused, 6 = vint, 7 = unused
; pc: 1 = unused, 2 = copera fm,  3 = adpcm,  4 = exint(?), 5 = hint,   6 = vint, 7 = unused
		dc.l	SpuriousError,	ErrorTrap,	Fm_int,		Ad_int
		dc.l	H_int,		H_int,		V_int,		ErrorTrap
		dcpad.b	128," ","Heh empty space something something 32X BIOS 68040 FPU"
		dcpad.b	16," ","SEGA MEGA DRIVE"
		dcpad.b	16," ","(C)UHHHHHHHHHHHH"
		dcpad.b	48," ","MAIDEN SOUND SOURCE TEST ROM"
		dcpad.b	48," ","SMPS DUSTED TEST ROM"
		dc.b	$43,$F9,$00,$20,$01,$80,$72,$0A,$10,$11,$04,$00,$00,"x"	; full blue spheres
		dc.w	0
		dcpad.b	16," ","JC"
		dc.l	RomStart,RomEnd-1,$FF0000,$FFFFFF
		dc.b	[$1F0-(*)]" "
		dcpad.b	16," ","JUE"
; ---------------------------------------------------------------------------
BusError:	bra.s	*
AddressError:	bra.s	*
IllegalInstr:	bra.s	*
ZeroDivide:	bra.s	*
ChkInstr:	bra.s	*
TrapvInstr:	bra.s	*
PrivilegeViol:	bra.s	*
Trace:		bra.s	*
Line1010Emu:	bra.s	*
Line1111Emu:	bra.s	*
CoProtocolViol:	bra.s	*
FormatError:	bra.s	*
InitIntError:	bra.s	*
SpuriousError:	bra.s	*
ErrorTrap:	bra.s	*
; ---------------------------------------------------------------------------
H_int:
; type 1 - waste time
		movem.l	d0-d7,-(sp)
		movem.l	(sp)+,d0-d7
		rte
V_int:
		movem.l	d0-a6,-(sp)

		lea	vdpctrl,a5
;.invblank:	move.w	(a5),d0
;		and.w	#1<<3,d0
;		beq.s	.invblank
		move.w	#$8A00,d0
		move.b	v_hint,d0
		move.w	d0,(a5)

		move.l	#$C0000000,(a5)				; cram visualiser
		move.w	#$0E0,vdpdata-vdpctrl(a5)
		jsr	JoypadRead

;		lea	vdpctrl,a5
.dmasrc = *
		moveq	#0,d0
		move.w	v_dmalen,d0		; ..12
		beq.s	.nodma
		lsl.l	#8,d0			; .12.
		lsr.w	#8,d0			; .1.2
		or.l	#$94009300,d0
		move.l	#$C0000000,(a5)				; cram visualiser
		move.w	#$666,vdpdata-vdpctrl(a5)		; the devel, ououououououohhhhh
		move.l	d0,(a5)
		move.l	#($9600|(((.dmasrc)>>09)&$FF)<<16)|($9500|(((.dmasrc)>>1)&$FF)),(a5)
		move.l	#($8F00<<16)|($9700|(((.dmasrc)>>17)&$7F)),(a5)		; auto-inc = 0
		move.w	#(vdpComm(vram_length<<5,VRAM_DMA)>>16)&$FFFF,(a5)
		move.w	#vdpComm(vram_length<<5,VRAM_DMA)&$FFFF,-(sp)
		move.w	(sp)+,(a5)
		move.w	#$8F02,(a5)	; auto-inc = 2
.nodma:
		tst.b	v_runinvint
		beq.s	.norun
		move.w	#$2000,sr
		move.l	#$C0000000,(a5)				; cram visualiser
		move.w	#$00C,vdpdata-vdpctrl(a5)
		jsr	CallAPI.rundriver
		cmp.b	#2,v_runinvint
		blo.s	.norun
		move.l	#$C0000000,vdpctrl			; cram visualiser
		move.w	#$A00,vdpdata
		bsr.w	CallAPI.setuppianoroll
.norun:
		move.l	#$C0000000,vdpctrl			; cram visualiser
		move.w	#$E0E,vdpdata
		move.b	#1,v_vsync
		movem.l	(sp)+,d0-a6
		;rte
Ad_int:		;rte
Fm_int:		rte
; ---------------------------------------------------------------------------
EntryPoint:
.ramstallclear	equ $400
		move.w	#$2700,sr
		lea	.initval(pc),a6
		movem.w	(a6)+,d5-d7
		movem.l	(a6)+,a0-a5
; stop the Z80 as early as possible
		move.w	d7,(a1)					; stop the Z80 (requires a 192+ cycle delay)
		move.w	d7,(a2)					; reset the Z80
; init VDP
		moveq	#$F,d0
		and.b	io_hardware-io_z80bus(a1),d0		; get hardware version
		beq.s	.vdplock
		move.l	#"SEGA",io_vdplock-io_z80bus(a1)	; satisfy the TMSS
		moveq	#0,d0
.vdplock:

.wdma1:		move.w	(a4),d1					; also clears vdp write pending
		btst	#1,d1					; wait until potential DMA is over
		bne.s	.wdma1

		moveq	#(.initvdpend-.initvdp)-1,d1	; run the following loop $18 times
		move.w	#$8000,d2
.ivdp:		move.b	(a6)+,d2
		move.w	d2,(a4)
		add.w	d7,d2
		dbf	d1,.ivdp
; init CRAM
		move.l	#$C0000000,(a4)				; vdpComm(0,CRAM,WRITE)
		moveq	#$80/4-1,d1
.icram:		move.l	d0,(a3)
		dbf	d1,.icram
; init Z80
		moveq	#.initz80end-.initz80-1,d1
.wz80:		btst	d0,(a1)					; has the Z80 stopped?
		bne.s	.wz80
.iz80:		move.b	(a6)+,(a0)+
		dbf	d1,.iz80
; reset Z80, clear a part of RAM to pass the time
		move.w	d0,(a2)					; reset the Z80 (requires a 192+ cycle delay)
		move.w	#.ramstallclear/4-1,d1			; clear the first $800 bytes of RAM while we wait
.iram1:		move.l	d0,(a5)+
		dbf	d1,.iram1
		move.w	d0,(a1)					; start the Z80
		move.w	d7,(a2)					; reset the Z80
; we now have to wait for the Z80 to access the 68000s bus for VRAM init
; init VSRAM
		move.l	#$40000010,(a4)				; vdpComm(0,VSRAM,WRITE)
		moveq	#$50/4-1,d1
.ivsram:	move.l	d0,(a3)
		dbf	d1,.ivsram
; clear another part of RAM
		move.w	#.ramstallclear/4-1,d1			; clear the first $800 bytes of RAM while we wait
.iram2:		move.l	d0,(a5)+
		dbf	d1,.iram2
; the Z80 should have accessed the 68000s bus by now
; init VRAM via VRAM fill
		move.w	#$8F01,(a4)				; set VDP increment
		move.l	#$40000080,(a4)				; vdpComm(0,VRAM,DMA)
		move.w	d0,(a3)					; clear the screen
; clear the rest of RAM
		move.b	io_jpad1ctrl-io_z80bus(a1),d7		; the amount cleared depends on if this is a soft or hard reset
		or.b	io_jpad2ctrl-io_z80bus(a1),d7		; outside of very specific controller code, these are non-zero
		or.b	io_jpad3ctrl-io_z80bus(a1),d7		; soft resets retain the value, hard resets clear it
		bne.s	.dosoftreset
		move.w	d5,d6
.dosoftreset:
.iram3:		move.l	d0,(a5)+
		dbf	d6,.iram3
; wait for VRAM fill
.wdma2:		move.w	(a4),d1					; clear vdp write pending
		btst	#1,d1
		bne.s	.wdma2
		move.w	#$8F02,(a4)				; set VDP increment
		bra.w	GameProgram
; ---------------------------------------------------------------------------
.initval:
		dc.w ((v_hardresetend-v_start)-(.ramstallclear*2))/4-1
		dc.w ((v_softresetend-v_start)-(.ramstallclear*2))/4-1
		dc.w $100
		dc.l io_z80ram
		dc.l io_z80bus
		dc.l io_z80reset
		dc.l vdpdata
		dc.l vdpctrl
		dc.l v_start
.initvdp:
		dc.b $04	; $8004 - H-INT disabled
		dc.b $14	; $8134 - Genesis mode, DMA enabled, VBLANK-INT disabled, display disabled
		dc.b $38	; $8230 - PNT A base: $E000
		dc.b $3C	; $833C - PNT W base: $F000
		dc.b $07	; $8407 - PNT B base: $E000
		dc.b $00	; $856C - Sprite attribute table base: $0000
		dc.b $00	; $8600 - Null
		dc.b $00	; $8700 - Background palette/color: 0/0
		dc.b $00	; $8800 - Null
		dc.b $00	; $8900 - Null
		dc.b $FF	; $8AFF - H-INT never
		dc.b $00	; $8B00 - EXT-INT off, V scroll by screen, H scroll by screen
		dc.b $81	; $8C81 - H res 40 cells, single res progressive, S/H disabled
		dc.b $00	; $8D37 - H scroll table base: $0000
		dc.b $00	; $8E00 - Null
		dc.b $02	; $8F01 - VRAM pointer increment: $0002
		dc.b $11	; $9001 - Scroll table size: 64
		dc.b $00	; $9100 - Window H side, Base Point 0 left
		dc.b $00	; $9200 - Window V side, Base Point 0 up
		dc.b $FF	; $93FF - DMA Length Counter $FFFF
		dc.b $FF	; $94FF - See above
		dc.b $00	; $9500 - DMA Source Address $0
		dc.b $00	; $9600 - See above
		dc.b $80	; $9780	- See above + VRAM fill mode
.initvdpend:
.initz80:	binclude "_out/entry-z80.bin"
.initz80end:
	even
; ---------------------------------------------------------------------------
GameProgram:
		bsr.w	CallAPI.initdriver
		bsr.w	JoypadInit
		move.w	#$E00,v_dmalen
		move.b	#-1,v_hint
		move.b	#1,v_runinvint	; run
		move.w	#2,v_select	; Sound ID
		move.w	v_select,v_prevselect
		move.w	#2,v_apiindex	; QueueSound
		bsr.w	InitRender
		bsr.w	HandleRender
		move.w	#$8174,vdpctrl
		move.w	#$2000,sr
.mainloop:
		stop	#$2000
		tst.b	v_vsync
		beq.s	.mainloop
		clr.b	v_vsync
		move.l	#$C0000000,vdpctrl			; cram visualiser
		move.w	#$EE0,vdpdata
		bsr.s	HandleControl
		move.l	#$C0000000,vdpctrl			; cram visualiser
		move.w	#$E80,vdpdata
		bsr.w	HandleRender
		move.l	#$C0000000,vdpctrl			; cram visualiser
		move.w	#$000,vdpdata
		bra.s	.mainloop

HandleControl:
		lea	ControlList(pc),a0
		move.w	v_select,d0
		move.w	(a0)+,d1
		btst	#btnUP,v_jpad1press
		beq.s	.unah
		subq.w	#1,d0
		bcc.s	.unah
		move.w	d1,d0
		subq.w	#1,d0
.unah:
		btst	#btnDOWN,v_jpad1press
		beq.s	.dnah
		addq.w	#1,d0
		cmp.w	d1,d0
		blo.s	.dnah
		clr.w	d0
.dnah:
		move.w	d0,v_select
		mulu.w	#8,d0
		add.l	d0,a0
		move.l	(a0),a1
		move.l	4(a0),d1

		moveq	#$01,d6
		move.b	v_jpad1press,d7
		btst	#btnC,v_jpad1held
		beq.s	.cnah
		move.b	v_jpad1held,d7
		moveq	#$20,d6
.cnah:
		btst	#btnLEFT,d7
		beq.s	.lnah
		moveq	#0,d0
		move.b	(a0),d0
		jmp	.llt(pc,d0.w)
.llt:
		bra.s	.lb
		bra.s	.lw

.lb:		sub.b	d6,(a1)
		bcc.s	.lc
		move.b	d1,(a1)
		bra.s	.lc
.lw:
		sub.w	d6,(a1)
		bcc.s	.lc
		move.w	d1,(a1)
;		bra.s	.lc
.lc:
.lnah:
		btst	#btnRIGHT,d7
		beq.s	.rnah
		moveq	#0,d0
		move.b	(a0),d0
		jmp	.rlt(pc,d0.w)
.rlt:
		bra.s	.rb
		bra.s	.rw
.rb:
		add.b	d6,(a1)
		cmp.b	(a1),d1
		bhs.s	.rc
		clr.b	(a1)
		bra.s	.rc
.rw:
		add.w	d6,(a1)
		cmp.w	(a1),d1
		bhs.s	.rc
		clr.w	(a1)
;		bra.s	.rc
.rc:
.rnah:
		btst	#btnA,v_jpad1press
		bne.s	CallAPI
		btst	#btnB,v_jpad1press
		bne.w	CallShortcut
		rts

; Also serves as a reference for how to use the API calls
CallAPI:
		move.w	v_apiindex,d0
		lsl.w	#2,d0
		jmp	.lut(pc,d0.w)
.lut:
		bra.w	.initdriver
		bra.w	.rundriver
		bra.w	.queuesound
		bra.w	.updatefifo
		bra.w	.readcomm
		bra.w	.writecomm
		bra.w	.guarddriver
		bra.w	.unguarddriver
		bra.w	.runmisccmd
		bra.w	.setuppianoroll
		bra.w	.playcdda
.lute:

.initdriver:
		lea	(SMPS_DriverData).l,a0
		lea	v_soundram,a1
		moveq	#0,d0
		jmp	(SMPS_InitDriver).l
.rundriver:
		lea	v_soundram,a1
		jmp	(SMPS_RunDriver).l
.queuesound:
		move.w	v_soundid,d0
		lea	v_soundram,a1
		jmp	(SMPS_QueueSound).l
.updatefifo:
		lea	v_soundram,a1
		jmp	(SMPS_UpdateFIFO).l
.readcomm:
		move.b	v_commindex,d1
		lea	v_soundram,a1
		jsr	(SMPS_ReadComm).l
		move.b	d0,v_commval
		rts
.writecomm:
		move.b	v_commindex,d1
		move.b	v_commval,d0
		lea	v_soundram,a1
		jmp	(SMPS_WriteComm).l
.guarddriver:
		lea	v_soundram,a1
		jmp	(SMPS_GuardDriver).l
.unguarddriver:
		lea	v_soundram,a1
		jmp	(SMPS_UnguardDriver).l
.runmisccmd:
		move.w	v_misccmd,d0
		move.w	v_miscparam,d1
		lea	v_soundram,a1
		jmp	(SMPS_RunMiscCommand).l
.setuppianoroll:
		lea	v_pianoram,a0
		lea	v_soundram,a1
		jmp	(SMPS_SetupPianoRoll).l
.playcdda:
		move.b	v_cddaid,d0
		lea	v_soundram,a1
		jmp	(SMPS_PlayCDDA).l

CallShortcut:
		move.w	v_shortcut,d0
		lsl.w	#2,d0
		jmp	.lut(pc,d0.w)
.lut:
		bra.w	.stopall
		bra.w	.stopbgm
		bra.w	.stopsfx
		bra.w	.stopbsfm
		bra.w	.stoppcmsfx
		bra.w	.stereo
		bra.w	.mono
		bra.w	.ssgon
		bra.w	.ssgoff
		bra.w	.muffleoff
		bra.w	.muffleon
		bra.w	.fadeout
		bra.w	.fadeoutbgm
		bra.w	.fadein
		bra.w	.pause
		bra.w	.resume
.lute:
.stopall:
		move.w	#cmd_StopAll,d0
		bra.w	.queuesound
.stopbgm:
		move.w	#cmd_StopBGM,d0
		bra.w	.queuesound
.stopsfx:
		move.w	#cmd_StopSFX,d0
		bra.w	.queuesound
.stopbsfm:
		move.w	#cmd_StopBSFX,d0
		bra.w	.queuesound
.stoppcmsfx:
		move.w	#cmd_StopPSFX,d0
		bra.w	.queuesound
.stereo:
		move.w	#cmd_PanStereo,d0
		bra.w	.queuesound
.mono:
		move.w	#cmd_PanMono,d0
		bra.w	.queuesound
.ssgon:
		move.w	#cmd_SsgOn,d0
		bra.w	.queuesound
.ssgoff:
		move.w	#cmd_SsgOff,d0
		bra.w	.queuesound
.muffleoff:
		move.w	#cmd_MuffleOff,d0
		bra.w	.queuesound
.muffleon:
		move.w	#cmd_MuffleOn,d0
		bra.w	.queuesound
.fadeout:
		move.w	#cmd_Fadeout|80,d0
		bra.w	.queuesound
.fadeoutbgm:
		move.w	#cmd_FadeoutBGM|80,d0
		bra.w	.queuesound
.fadein:
		move.w	#cmd_Fadein|80,d0
		;bra.w	.queuesound
.queuesound:
		lea	v_soundram,a1
		jmp	(SMPS_QueueSound).l
.pause:
		move.w	#smpsmisc_Pause,d0
		bra.w	.runmisccmd
.resume:
		move.w	#smpsmisc_Resume,d0
		;bra.w	.runmisccmd
.runmisccmd:
		lea	v_soundram,a1
		jmp	(SMPS_RunMiscCommand).l


InitRender:
		lea	vdpctrl,a5
		lea	vdpdata-vdpctrl(a5),a4
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
		;moveq	#0,d0
		move.l	#vdpComm(0,VRAM_WRITE),(a5)
		move.w	#(vram_length*32)/4-1,d2
.vramclr:	move.l	d0,(a4)
		dbf	d2,.vramclr
; load font
; modified 1bpp converter by vladikcomper:
; https://github.com/vladikcomper/md-modules/blob/master/modules/core/1bpp_Decompress.asm
		lea	ErrorFont(pc),a6
		move.l	#vdpComm((" ")*32,VRAM_WRITE),(a5)
		lea	ErrorFontTable(pc),a5
		moveq	#$1E,d2
		swap	d4
		move.w	#(ErrorFont.end-ErrorFont)-1,d4
.bpploop:	move.b	(a6)+,d0				; d0 = %aaaa bbbb
		move.b	d0,d1
		lsr.b	#3,d1					; d1 = %000a aaab
		and.w	d2,d1					; d1 = %000a aaa0
		move.w	(a5,d1.w),(a4)				; decompress first nibble
		add.b	d0,d0					; d0 = %aaab bbb0
		and.w	d2,d0					; d0 = %000b bbb0
		move.w	(a5,d0.w),(a4)				; decompress second nibble
		dbf	d4,.bpploop
		lea	vdpctrl-vdpdata(a4),a5
; load text plane
		lea	ScreenText.main(pc),a0
		move.l	#vdpComm(vram_plane<<5+planeLoc(64,2,1),VRAM_WRITE),d0
		bra.w	PrintText

rentext macro list,index
		moveq	#0,d0
		move.ATTRIBUTE	index,d0
		lsl.l	#2,d0
		lea	list(pc),a0
		move.l	(a0,d0.l),a0
		move.l	#vdpComm(vram_plane<<5+planeLoc(64,15,.l),VRAM_WRITE),d0
		bsr.w	PrintText
	set .l,.l+1
	endm
renhex macro hexval
		move.l	#vdpComm(vram_plane<<5+planeLoc(64,15,.l),VRAM_WRITE),d0
	if "ATTRIBUTE"=="b"
		moveq	#2-1,d3
		move.b	hexval,d1
		ror.l	#8,d1
		bsr.w	PrintHex
	elseif "ATTRIBUTE"=="w"
		moveq	#4-1,d3
		move.w	hexval,d1
		swap	d1
		bsr.w	PrintHex
	elseif "ATTRIBUTE"=="l"
		moveq	#8-1,d3
		move.l	hexval,d1
		bsr.w	PrintHex
	else
		fatal "renhex: Unknown hexval type"
	endif
	set .l,.l+1
	endm
HandleRender:
		lea	vdpctrl,a5
		lea	vdpdata-vdpctrl(a5),a4

		move.w	#" ",d1
		move.w	v_prevselect,d0
		bsr.w	PrintCursor
		move.w	#">",d1
		btst	#btnC,v_jpad1held
		beq.s	.cnah
		move.w	#"!",d1
.cnah
		move.w	v_select,d0
		bsr.w	PrintCursor
		move.w	v_select,v_prevselect
	set .l,3
		rentext.w ScreenText.apicall,v_apiindex
		rentext.w ScreenText.shortcut,v_shortcut
		renhex.w v_soundid
		renhex.w v_misccmd
		renhex.w v_miscparam
		renhex.b v_cddaid
		renhex.b v_commval
		renhex.b v_commindex
		renhex.w v_dmalen
		renhex.b v_hint
		rentext.b ScreenText.vintrun,v_runinvint
		rts
PrintCursor:
		and.l	#$FF,d0
		lsl.w	#7,d0
		add.w	#(vram_plane<<5)|planeLoc(64,2,3),d0
		lsl.l	#2,d0
		lsr.w	#2,d0
		ori.w	#$4000,d0				; VRAM_WRITE
		swap	d0
		move.l	d0,(a5)
		move.w	d1,(a4)
		rts
PrintHex:
		move.l	d0,(a5)
.loop:		rol.l	#4,d1
		moveq	#$F,d2					; copy d1 to d2
		and.b	d1,d2					; remove high nybble
		cmp.b	#$A,d2					; convert hex nybble to ascii
		blo.s	.num
		addq.b	#7,d2					; letters ; ('A'-'0')-$A = 7
.num:		add.b	#'0',d2					; numbers ; val+'0'
		move.w	d2,(a4)
		dbf	d3,.loop
		rts
PrintText:
.lineloop:	move.l	d0,(a5)
.loop:		move.b	(a0)+,d4
		and.w	#$7F,d4
		cmp.b	#$20,d4
		blo.s	.commands
		move.w	d4,(a4)
		bra.w	.loop
.commands:
		clr.w	d1
		move.b	d4,d1
		cmp.w	#(.cmdlute-.cmdlut)/2,d1
		bhs.s	.cmd_exit
		add.w	d1,d1
		jmp	.cmdlut(pc,d1.w)
.cmdlut:
		bra.s	.cmd_exit				; $00 ; ASCII 03, end of "file"
		bra.s	.cmd_nextline				; $01 ; ASCII 0A, line feed/newline/next line
.cmdlute:
.cmd_exit:
		rts
.cmd_nextline:
		add.l	#vdpCommDelta(64*2),d0
		bra.w	.lineloop
ErrorFontTable:
		dc.w $0000, $0001, $0010, $0011
		dc.w $0100, $0101, $0110, $0111
		dc.w $1000, $1001, $1010, $1011
		dc.w $1100, $1101, $1110, $1111
ErrorVDP:
		dc.b %00010100					; $80, 8-colour mode, enable H-Int
		dc.b %00000100					; $81, MD mode, screen disabled, DMA disabled, VInt disabled
		dc.b (vram_plane)>>5				; $82, foreground nametable address
		dc.b (vram_plane)>>5				; $83, window nametable address
		dc.b (vram_plane)>>8				; $84, background nametable address
		dc.b (vram_null)>>4				; $85, sprite table address
		dc.b 0						; $86
		dc.b 0						; $87, overscan colour
		dc.b 0						; $88
		dc.b 0						; $89
		dc.b 255					; $8A, H-Int scanline register, fire every line
		dc.b %00000000					; $8B, full screen scroll
		dc.b %10000001					; $8C, Slow H40, progressive scan, s/h disabled
		dc.b (vram_null)>>5				; $8D, hscroll table address
		dc.b 0						; $8E
		dc.b 2						; $8F, VDP auto-inc 2
		dc.b 1						; $90, 64x32 plane size
		dc.b 0						; $91, window h position
		dc.b 0						; $92, window v position
.end:
ErrorFont:	binclude "src-68k/smps-renassert-font.1bpp"
.end:
	even


ctrllist macro ramloc,endval
	switch "ATTRIBUTE"
	case "b"
		set .t,0
	case "w"
		set .t,2
	elsecase
		fatal "bruh"
	endcase
		dc.l (.t)<<24|ramloc&$FFFFFF
		dc.l endval
		endm
ControlList:
		dc.w (.e-.s)/8
.s:		ctrllist.w	v_apiindex,	(CallAPI.lute-CallAPI.lut)/4-1
		ctrllist.w	v_shortcut,	(CallShortcut.lute-CallShortcut.lut)/4-1
		ctrllist.w	v_soundid,	$FFFF
		ctrllist.w	v_misccmd,	2
		ctrllist.w	v_miscparam,	$FFFF
		ctrllist.b	v_cddaid,	(99*2)
		ctrllist.b	v_commval,	$FF
		ctrllist.b	v_commindex,	1
		ctrllist.w	v_dmalen,	$1000
		ctrllist.b	v_hint,		$FF
		ctrllist.b	v_runinvint,	2
.e:

dctxt macro padto,byteval
$$p:	dc.b	byteval
	dc.b	[padto-((*)-$$p)]" "
	dc.b	0
	endm
ScreenText:
.apicall:
		dc.l .a_init
		dc.l .a_run
		dc.l .a_sound
		dc.l .a_fifo
		dc.l .a_readcomm
		dc.l .a_writecomm
		dc.l .a_guard
		dc.l .a_unguard
		dc.l .a_misc
		dc.l .a_piano
		dc.l .a_cdda
.shortcut:
		dc.l .s_stopall
		dc.l .s_stopbgm
		dc.l .s_stopsfx
		dc.l .s_stopbsfm
		dc.l .s_stoppcmsfx
		dc.l .s_stereo
		dc.l .s_mono
		dc.l .s_ssgon
		dc.l .s_ssgoff
		dc.l .s_muffleoff
		dc.l .s_muffleon
		dc.l .s_fadeout
		dc.l .s_fadeoutbgm
		dc.l .s_fadein
		dc.l .s_pause
		dc.l .s_resume
.vintrun:
		dc.l .v_off
		dc.l .v_on
		dc.l .v_piano

.main:		dc.b "SMPS-Dusted Debug ROM v1",1
		dc.b "====================================",1
		dc.b " (A)API Call:",1
		dc.b " (B)Shortcut:",1
		dc.b " Sound ID:",1
		dc.b " Misc CMD:",1
		dc.b " Misc Param:",1
		dc.b " CDDA ID:",1
		dc.b " Comm Value:",1
		dc.b " Comm Index:",1
		dc.b " DMA Size:",1
		dc.b " H-Int Line:",1
		dc.b " Vint Run:",1
		dc.b "====================================",1
		dc.b 0

.amax		equ 14
.a_init:	dctxt .amax,"InitDriver"
.a_run:		dctxt .amax,"RunDriver"
.a_sound:	dctxt .amax,"QueueSound"
.a_fifo:	dctxt .amax,"UpdateFIFO"
.a_readcomm:	dctxt .amax,"ReadComm"
.a_writecomm:	dctxt .amax,"WriteComm"
.a_guard:	dctxt .amax,"GuardDriver"
.a_unguard:	dctxt .amax,"UnguardDriver"
.a_piano:	dctxt .amax,"SetupPianoRoll"
.a_misc:	dctxt .amax,"RunMiscCommand"
.a_cdda:	dctxt .amax,"PlayCDDA"

.smax		equ 13
.s_stopall:	dctxt .smax,"Stop All"
.s_stopbgm:	dctxt .smax,"Stop BGM"
.s_stopsfx:	dctxt .smax,"Stop SFX"
.s_stopbsfm:	dctxt .smax,"Stop BSFX"
.s_stoppcmsfx:	dctxt .smax,"Stop PCM SFX"
.s_stereo:	dctxt .smax,"Stereo pan"
.s_mono:	dctxt .smax,"Mono pan"
.s_ssgon:	dctxt .smax,"SSG on"
.s_ssgoff:	dctxt .smax,"SSG off"
.s_muffleoff:	dctxt .smax,"Muffle off"
.s_muffleon:	dctxt .smax,"Muffle on"
.s_fadeout:	dctxt .smax,"Fadeout"
.s_fadeoutbgm:	dctxt .smax,"Fadeout BGM"
.s_fadein:	dctxt .smax,"Fadein"
.s_pause:	dctxt .smax,"Pause Driver"
.s_resume:	dctxt .smax,"Resume Driver"

.vmax		equ 5
.v_off:		dctxt .vmax,"Off"
.v_on:		dctxt .vmax,"On"
.v_piano:	dctxt .vmax,"Piano"
		even
; ---------------------------------------------------------------------------
JoypadInit:
		stopZ80
		lea	io_jpad1ctrl,a1
		moveq	#1<<6,d0
		move.b	d0,io_jpad1ctrl-io_jpad1ctrl(a1)
		move.b	d0,io_jpad2ctrl-io_jpad1ctrl(a1)
		move.b	d0,io_jpad3ctrl-io_jpad1ctrl(a1)
		startZ80
		rts
JoypadRead:
		stopZ80
		lea	v_jpad,a0			; address where joypad states are written
		lea	io_jpad1data,a1			; first joypad port
; from every input request, delay by 8 cycles.
; US docs say 16, JP say 8, a safe bet is 12, Sonic does 8.
	rept 2
		move.b	#0<<6,(a1)			; AS request
		moveq	#%00110000,d0			; 4 ; Start, A
		moveq	#%00111111,d1			; 4 ; B, C, Directionals
		and.b	(a1),d0				; retrieve only the input bits we need

		move.b	#1<<6,(a1)			; BCD request
		add.b	d0,d0				; 4 ; move A and start to the higher 2 bits
		add.b	d0,d0				; 4 ; ditto
		and.b	(a1),d1				; retrive useful bits, inc to second joypad port

		or.b	d1,d0				; combine them together
		not.b	d0
		move.b	(a0),d1
		eor.b	d0,d1
		and.b	d0,d1
		move.b	d0,(a0)+			; held
		move.b	d1,(a0)+			; pressed

		addq.w	#io_jpad2data-io_jpad1data,a1
	endr
		startZ80
		rts
; ---------------------------------------------------------------------------
	org $8000
;	org $3F800	; MSD bank test 1
;	org $40000	; MSD bank test 2
SMPS_InitDriver		equ *+00
SMPS_RunDriver		equ *+04
SMPS_QueueSound		equ *+08
SMPS_UpdateFIFO		equ *+12
SMPS_ReadComm		equ *+16
SMPS_WriteComm		equ *+20
SMPS_GuardDriver	equ *+24
SMPS_UnguardDriver	equ *+28
SMPS_SetupPianoRoll	equ *+32
SMPS_RunMiscCommand	equ *+36
SMPS_PlayCDDA		equ *+40
SMPS_Signature		equ *+64	; ASCII with zero-terminator
	if __smpsDebug==0
	binclude "smps-drv.bin"
	else
	binclude "smps-drv-debug.bin"
	endif
	org $10000
SMPS_DriverData:
	binclude "smps-snd.bin"
; ---------------------------------------------------------------------------
	even
RomEnd: