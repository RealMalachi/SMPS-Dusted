; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------
; a1 = driver ram
; d0 = driver parameters
DetectCDDA:
		btst	#0,d0
		bne.s	.nomdp
		bsr.w	DetectMDPlus
.nomdp:
; detect Mega CD
		btst	#1,d0
		bne.w	.nomcd
		btst	#5,$A10001				; check if the MegaCD is attached
		beq.s	.yamcd					; if it is, continue
		cmpi.l	#"SEGA",$400100				; check for 'SEGA' in CD bios
		bne.w	.nomcd					; if not, end routine
.yamcd:
		lea     CdSubCtrl+1,a2
		move.w  #$FF00,CdMemCtrl			; sub-cpu gate array reset sequence
		move.b  #$03,(a2)				; seems random, I know.
		move.b  #$02,(a2)
		move.b  #$00,(a2)
		moveq   #$7F,d1
		dbf     d1,*

		move.b  #$00,(a2)				; Reset the Sub-CPU
.Reset:		move.b  (a2),d1
		and.b   #$01,d1
		cmp.b   #$00,d1
		bne.s   .Reset

		move.b  #$03,(a2)				; Request the Sub-CPU bus
.BusReq:	move.b  (a2),d1
		and.b   #$03,d1
		cmp.b   #$03,d1
		bne.s   .BusReq
; load program into Sub-CPU PRG-RAM
; TODO: look into bank switching for above 128KB, and compression.
		move.w  #$0000,CdMemCtrl			; disable write protection
		lea	MCDProgram(pc),a5
		lea     CdPrgRam,a6
		include "src-68k/cmp-zx0.asm"

		move.b  #$00,(a2)				; Reset the Sub-CPU, again!
.Reset2:	move.b  (a2),d1
		and.b   #$01,d1
		cmp.b   #$00,d1
		bne.s   .Reset2

		move.b  #$01,(a2)				; Let it run now
.StartUp:	move.b  (a2),d1
		and.b   #$01,d1
		cmp.b   #$01,d1
		bne.s   .StartUp

		or.b	#1<<v_driverflags2.mcd,v_driverflags2(a1)
.nomcd:
		rts
; d2 = error codes
DetectMDPlus:
; Continue if the code is outside of the overlay bank
; I assume anything within the overlay isn't safe to read or write from
		lea	.mdpcoderange_start(pc),a2
		cmp.l	#MSD_ParameterEnd,a2
		bhs.s	.chkmsd
		lea	mdpcoderange_end(pc),a2
		cmp.l	#MSD_OverlaySignature,a2
		blo.s	.chkmsd
		moveq	#2,d2					; error code: msd code within overlay bank
		rts
.nomsd:
		moveq	#1,d2					; error code: msd not found
		rts
.chkmsd:
.mdpcoderange_start:
; Detect MegaSD presence
		move.w	#MSD_OverlayValue,MSD_OverlayPort
		move.w	MSD_OverlaySignature,d1
		swap	d1
		move.w	MSD_OverlaySignature+2,d1
		move.w	#0,MSD_OverlayPort
		cmp.l	#"BATE",d1				; $42415445, it wasn't "RATE"
		bne.s	.nomsd
		or.b	#1<<v_driverflags2.mdplus,v_driverflags2(a1)
		moveq	#0,d2					; error code: success
		move.w	#msd_comm_volume<<8|$FF,d1		; full volume
		;bra.s	WriteToMDPlus
WriteToMDPlus:
		move.w	#MSD_OverlayValue,MSD_OverlayPort
		move.w	d1,MSD_CommandPort
		move.w	#0,MSD_OverlayPort
		rts
mdpcoderange_end:

PauseCDDA:
		btst	#v_driverflags2.mdplus,v_driverflags2(a1)
		bne.s	.mdp
		rts
.mdp:		move.w	#msd_comm_pause<<8,d1
		bra.s	WriteToMDPlus

ResumeCDDA:
		btst	#v_driverflags2.mdplus,v_driverflags2(a1)
		bne.s	.mdp
		rts
.mdp:		move.w	#msd_comm_resume<<8,d1
		bra.s	WriteToMDPlus

StopCDDA:
		btst	#v_driverflags2.mdplus,v_driverflags2(a1)
		bne.s	.mdp
		rts
.mdp:		move.w	#msd_comm_pause<<8,d1
		bra.s	WriteToMDPlus
; d0.b = cd id
PlayCDDA:
		tst.b	d0
		beq.s	PauseCDDA
		cmp.b	#1,d0
		beq.s	ResumeCDDA
	if __smpsDebug
		cmp.b	#99<<1,d0
		bhi.s	.invalid
	endif
		btst	#v_driverflags2.mdplus,v_driverflags2(a1)
		bne.s	.mdp
		rts
.mdp:
		move.w	#msd_comm_playonce<<8,d1
		move.b	d0,d1
		lsr.b	#1,d1
		bcc.s	WriteToMDPlus
		add.w	#(msd_comm_playloop-msd_comm_playonce)<<8,d1
		bra.s	WriteToMDPlus
	if __smpsDebug
.invalid:
		SMPS_assert "PlayCDDA: Invalid cdda id, TODO: print id"
	endif
; -------------------------------------------------------------------------
MCDProgram:	binclude "_out/build-mcd.zx0"
		even