; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------
MSD_CodeRange_Start:
DetectCDDA:
; ensure that all the MSD code isn't within its bank
;	lea	MSD_CodeRange_Start(pc),a0
;	cmp.l	#MSD_ParameterEnd,a0
;	bhs.s	.chkmsd
;	lea	MSD_CodeRange_End(pc),a0
;	cmp.l	#MSD_OverlaySignature,a0
;	bhs.s	.nomsd
;.chkmsd:
; detect MegaSD
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	MSD_OverlaySignature,d0
	swap	d0
	move.w	MSD_OverlaySignature+2,d0
	move.w	#0,MSD_OverlayPort
	cmp.l	#"BATE",d0					; $42415445
	bne.s	.nomsd
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	#msd_comm_volume<<8|$FF,MSD_CommandPort
	move.w	#0,MSD_OverlayPort
	or.b	#1<<v_driverflags2.mdplus,v_driverflags2(a6)
.nomsd:
; detect Mega CD
;	btst	#5,$A10001					; check if the MegaCD is attached
;	beq.s	.ya_cd						; if it is, continue
;	cmpi.l	#"SEGA",CdBootRom+$100				; check for 'SEGA' in CD bios
;	bne.s	.na_cd						; if not, end routine
;.ya_cd:
	rts

PauseCDDA:
	btst	#v_driverflags2.mdplus,v_driverflags2(a6)
	bne.s	.mdp
	rts
.mdp:
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	#msd_comm_pause<<8,MSD_CommandPort
	move.w	#0,MSD_OverlayPort
	rts

ResumeCDDA:
	btst	#v_driverflags2.mdplus,v_driverflags2(a6)
	bne.s	.mdp
	rts
.mdp:
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	#msd_comm_resume<<8,MSD_CommandPort
	move.w	#0,MSD_OverlayPort
	rts

StopCDDA:
	btst	#v_driverflags2.mdplus,v_driverflags2(a6)
	bne.s	.mdp
	rts
.mdp:
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	#msd_comm_pause<<8,MSD_CommandPort
	move.w	#0,MSD_OverlayPort
	rts

PlayCDDA:
	btst	#v_driverflags2.mdplus,v_driverflags2(a6)
	bne.s	.mdp
	rts

.mdp:
	and.w	#$FF,d0
	move.b	.mdplut(pc,d0.w),d1
	lsl.w	#8,d1
	move.b	d0,d1
	lsr.b	#1,d1
	move.w	#MSD_OverlayValue,MSD_OverlayPort
	move.w	d1,MSD_CommandPort
	move.w	#0,MSD_OverlayPort
	rts
.mdplut:
	dc.b	msd_comm_pause
	dc.b	msd_comm_resume
	rept 99
	dc.b	msd_comm_playonce
	dc.b	msd_comm_playloop
	endr
	even

MSD_CodeRange_End: