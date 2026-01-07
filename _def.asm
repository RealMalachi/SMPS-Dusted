	include "sound/smps-68k/smps-ids.asm"
; ---------------------------------------------------------------------------
_drvname	= "SMPS-DUSTED 68K"
_drvbgm_start 	= bgm__First
_drvbgm_end	= bgm__Last
_drvsfx_start 	= sfx__First
_drvsfx_end 	= sfx__Last
_drvpcm_start	= pcm__First
_drvpcm_end	= pcm__Last
_drvcmd_start	= cmd__First
_drvcmd_end	= cmd__Last
_drvramsize	= smpsramsize

drvinit macro
	lea	(SMPS_DriverData).l,a0
	lea	(v_soundram).w,a1
	move.w	#smpsramsize,d0
	jsr	(SMPS_InitDriver).l
	endm
drvguard macro
	lea	(v_soundram).w,a1
	jsr	(SMPS_DACGuard).l
	endm
drvunguard macro
	lea	(v_soundram).w,a1
	jsr	(SMPS_DACUnguard).l
	endm
drvupdvint macro exitflag
	lea	(v_soundram).w,a1
	if "exitflag"==""
	jsr	(SMPS_RunDriver).l
	else
	jmp	(SMPS_RunDriver).l
	endif
	endm
drvupdframe macro exitflag
	lea	(r_misc).l,a0
	lea	(v_soundram).w,a1
	if "exitflag"==""
	jsr	(SMPS_SetupPianoRoll).l
	else
	jmp	(SMPS_SetupPianoRoll).l
	endif
	endm
drvupdfifo macro exitflag
	lea	(v_soundram).w,a1
	if "exitflag"==""
	jsr	(SMPS_UpdateFIFO).l
	else
	jmp	(SMPS_UpdateFIFO).l
	endif
	endm
drvbgm macro sndid,exitflag
	lea	(v_soundram).w,a1
	if "sndid"<>"d0"
	move.w	#sndid,d0
	endif
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvsfx macro sndid,exitflag
	lea	(v_soundram).w,a1
	if "sndid"<>"d0"
	move.w	#sndid,d0
	endif
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvpcm macro sndid,exitflag
	lea	(v_soundram).w,a1
	if "sndid"<>"d0"
	move.w	#sndid,d0
	endif
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvcmd macro sndid,exitflag
	lea	(v_soundram).w,a1
	if "sndid"<>"d0"
	move.w	#sndid,d0
	endif
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvbgmvol macro vol,exitflag
	if "vol"<>"d0"
	endif
	if "exitflag"<>""
	rts
	endif
	endm
drvsfxvol macro vol,exitflag
	if "vol"<>"d0"
	endif
	if "exitflag"<>""
	rts
	endif
	endm
drvpcmvol macro vol,exitflag
	if "vol"<>"d0"
	endif
	if "exitflag"<>""
	rts
	endif
	endm
drvbgmstop macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_StopAll,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvsfxstop macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_StopSFX,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvpcmstop macro exitflag
	if "exitflag"<>""
	rts
	endif
	endm
drvfadein macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_Fadein|$50,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvfadeout macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_Fadeout|160,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvpause macro exitflag
	lea	(v_soundram).w,a1
	if "exitflag"==""
	jsr	(SMPS_PauseDriver).l
	else
	jmp	(SMPS_PauseDriver).l
	endif
	endm
drvresume macro exitflag
	lea	(v_soundram).w,a1
	if "exitflag"==""
	jsr	(SMPS_ResumeDriver).l
	else
	jmp	(SMPS_ResumeDriver).l
	endif
	endm
drvstereo macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_PanStereo,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvmono macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_PanMono,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvssgon macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_SsgOn,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvssgoff macro exitflag
	lea	(v_soundram).w,a1
	move.w	#cmd_SsgOff,d0
	if "exitflag"==""
	jsr	(SMPS_QueueSound).l
	else
	jmp	(SMPS_QueueSound).l
	endif
	endm
drvstat macro
	endm
drvcomm macro
	endm