	include "Sound/smps-ids.asm"
; ===========================================================================
music macro sndid,terminator
	move.w	#sndid,d0
	if ("terminator"=="")||("terminator"=="0")
	jsr	(QueueSound).w
	else
	jmp	(QueueSound).w
	endif
	endm
sfx macro sndid,terminator
	move.w	#sndid,d0
	if ("terminator"=="")||("terminator"=="0")
	jsr	(QueueSound).w
	else
	jmp	(QueueSound).w
	endif
	endm
SMPS_PauseMusic macro
	lea	(Snd_driver_RAM).w,a1
	jsr	(SMPS_PauseDriver).l
	endm
SMPS_UnpauseMusic macro
	lea	(Snd_driver_RAM).w,a1
	jsr	(SMPS_ResumeDriver).l
	endm
SMPS_UpdateSoundDriver macro
	lea	(Snd_driver_RAM).w,a1
	jsr	(SMPS_RunDriver).l
	endm