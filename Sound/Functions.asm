QueueRingSound:
	move.w	#sfx_RingRight,d0
	bchg	#7,(Snd_driver_misc_bitfield).w
	beq.s	.right
	move.w	#sfx_RingLeft,d0
.right:
;	bra.w	QueueSound

; d0.w = sound id
Play_Music:
Play_SFX:
Play_Sample:
QueueSound:
	move.l	a1,-(sp)
	lea	(Snd_driver_RAM).w,a1
	jsr	(SMPS_QueueSound).l
	move.l	(sp)+,a1
	rts

SoundDriverLoad:
	lea	(SMPS_DriverData).l,a0
	lea	(Snd_driver_RAM).w,a1
	jmp	(SMPS_InitDriver).l
