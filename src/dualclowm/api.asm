	moveq	#(zSampleLookup>>8)|$F,d0	; cap at maximum value (minimum volume)
	bra.s	WriteDACVolume
.do_not_cap:
	lsr.b	#3,d0
	ori.b	#zSampleLookup>>8,d0

WriteDACVolume:
	SMPS_stopZ80_safe
	move.b	d0,(SMPS_z80_ram+zSample1Volume).l
	SMPS_startZ80_safe


GetDACSampleMetadata:
	; Get pointer to requested sample's metadata
	andi.w	#$FF,d0
	subi.w	#$81,d0
	lea	(DACMetadataTable).l,a0
	adda.w	d0,a0
	add.w	d0,d0
	add.w	d0,d0
	adda.w	d0,a0
	rts
; INPUT
; a0 = 
; a1 = channel
SendDACSampleRequest:
	lea	(SMPS_z80_ram+zRequestChannel1).l,a1
	lea	(SMPS_z80_ram+zRequestChannel2).l,a1

	move.b	#$37,(SMPS_z80_ram+zRequestFlag).l	; 'scf' instruction
	move.b	#$01,(a1)+				; 'Play sample' command value
	move.b	(a0)+,(a1)+				; Copy the sample's metadata
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+
	move.b	(a0)+,(a1)+

	rts

	moveq	#$01,d0					; unpause command
	SMPS_stopZ80_safe
	move.b	#$37,(SMPS_z80_ram+zRequestFlag).l	; 'scf' instruction
	move.b  d0,(SMPS_z80_ram+zRequestChannel1).l
	move.b  d0,(SMPS_z80_ram+zRequestChannel2).l
	SMPS_startZ80_safe

	moveq	#$02,d0					; stop command
	SMPS_stopZ80_safe
	move.b	#$37,(SMPS_z80_ram+zRequestFlag).l	; 'scf' instruction
	move.b	d0,(SMPS_z80_ram+zRequestChannel1).l
	move.b	d0,(SMPS_z80_ram+zRequestChannel2).l
	SMPS_startZ80_safe