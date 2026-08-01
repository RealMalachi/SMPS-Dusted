; ---------------------------------------------------------------------------
;
; ---------------------------------------------------------------------------
; INPUT
; a1 = driver ram
; d0 = driver parameters
; OUTPUT
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
		btst	#v_hardware.mdplus,v_hardware(a1)
		bne.s	.mdp
		rts
.mdp:		move.w	#msd_comm_pause<<8,d1
		bra.s	WriteToMDPlus

ResumeCDDA:
		btst	#v_hardware.mdplus,v_hardware(a1)
		bne.s	.mdp
		rts
.mdp:		move.w	#msd_comm_resume<<8,d1
		bra.s	WriteToMDPlus

StopCDDA:
		btst	#v_hardware.mdplus,v_hardware(a1)
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
		btst	#v_hardware.mdplus,v_hardware(a1)
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