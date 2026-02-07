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
