; sound define macros - megapcm2
; ------------------------------------------------------------------------------
; Definitions for sample table
; ------------------------------------------------------------------------------

FLAGS_SFX:		equ	$01		; sample is SFX, normal drums cannot interrupt it
FLAGS_LOOP:		equ	$02		; loop sample indefinitely

TYPE_NONE:		equ	$00
TYPE_PCM:		equ	'P'
TYPE_PCM_TURBO:		equ	'T'
TYPE_DPCM:		equ	'D'

; ------------------------------------------------------------------------------
; Maximum playback rates:
TYPE_PCM_TURBO_MAX_RATE:	equ	32000 ; Hz
TYPE_PCM_MAX_RATE:		equ	25100 ; Hz
TYPE_DPCM_MAX_RATE:		equ	20600 ; Hz

; Internal driver's base rates for pitched playback.
; NOTICE: Actual max rates are slightly lower,
; because the highest pitch is 255/256, not 256/256.
TYPE_PCM_BASE_RATE:		equ	25208 ; Hz
TYPE_DPCM_BASE_RATE:		equ	20691 ; Hz


; ------------------------------------------------------------------------------
; Return error codes for `MegaPCM_LoadSampleTable`
; ------------------------------------------------------------------------------

MPCM_ST_TOO_MANY_SAMPLES:		equ	$01
MPCM_ST_UNKNOWN_SAMPLE_TYPE:		equ	$02

MPCM_ST_PITCH_NOT_SET:			equ	$10

MPCM_ST_WAVE_INVALID_HEADER:		equ	$20
MPCM_ST_WAVE_BAD_AUDIO_FORMAT:		equ	$21
MPCM_ST_WAVE_NOT_MONO:			equ	$22
MPCM_ST_WAVE_NOT_8BIT:			equ	$23
MPCM_ST_WAVE_BAD_SAMPLE_RATE:		equ	$24
MPCM_ST_WAVE_MISSING_DATA_CHUNK:	equ	$25


; ------------------------------------------------------------------------------
; System Ports used by Mega PCM
; ------------------------------------------------------------------------------

MPCM_Z80_RAM:		equ	$A00000
MPCM_Z80_BUSREQ:	equ	$A11100
MPCM_Z80_RESET:		equ	$A11200

MPCM_YM2612_A0:		equ	$A04000
MPCM_YM2612_D0:		equ	$A04001
MPCM_YM2612_A1:		equ	$A04002
MPCM_YM2612_D1:		equ	$A04003

; ------------------------------------------------------------------------------
; Z80 equates
; ------------------------------------------------------------------------------

Z_MPCM_DriverReady:		equ $1fc3
Z_MPCM_CommandInput:		equ $1fc2
Z_MPCM_VolumeInput:		equ $1fc4
Z_MPCM_SFXVolumeInput:		equ $1fc5
Z_MPCM_PanInput:		equ $1fc6
Z_MPCM_SFXPanInput:		equ $1fc7
Z_MPCM_LoopId:			equ $1fdd
Z_MPCM_ActiveSamplePitch:	equ $1fdc
Z_MPCM_VBlankActive:		equ $1fe2
Z_MPCM_CalibrationApplied:	equ $1fe3
Z_MPCM_CalibrationScore_ROM:	equ $1fe4
Z_MPCM_CalibrationScore_RAM:	equ $1fe6
Z_MPCM_LastErrorCode:		equ $1fe8
Z_MPCM_SampleTable:		equ $1976
Z_MPCM_COMMAND_STOP:		equ $1
Z_MPCM_COMMAND_PAUSE:		equ $2
Z_MPCM_LOOP_IDLE:		equ $1
Z_MPCM_LOOP_PAUSE:		equ $2
Z_MPCM_LOOP_PCM:		equ $10
Z_MPCM_LOOP_PCM_TURBO:		equ $18
Z_MPCM_LOOP_DPCM:		equ $20
Z_MPCM_LOOP_CALIBRATION:	equ $80
Z_MPCM_ERROR__BAD_INTERRUPT:	equ $2
Z_MPCM_ERROR__BAD_SAMPLE_TYPE:	equ $1
Z_MPCM_ERROR__UNKNOWN_COMMAND:	equ $80

; ==============================================================================
; ------------------------------------------------------------------------------
; Macros
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; Macro to generate sample record in a sample table
; ------------------------------------------------------------------------------
pcmdef macro sampletype,sampleptr,sampleseqid,samplequeueid,samplerate,sampleflags
	if "sampletype"=="START"
		if "sampleptr"<>__smpsPCM
		fatal "ERROR: The sample table is for sampleptr, whereas the driver expects \{__smpsPCM}"
		endif
musidtrack	set 0
musidbase1	set samplequeueid
musidbase2	set sampleseqid
		if "samplerate"<>""
samplerate	equ samplequeueid
		shared samplerate
		endif
	else
		if "samplequeueid"<>""
samplequeueid	equ musidbase1+musidtrack
		shared samplequeueid
		endif
		if "sampleseqid"<>""
sampleseqid	equ musidbase2+musidtrack
		endif
musidtrack	set musidtrack+1

		if "sampletype"=="END"
		dc.w	-1	; end marker
musidtrack	set -1
		elseif "sampletype"=="NONE"
		dc.l	0,0,0
		elseif "sampletype"=="PCM"
			if (samplerate+0)>TYPE_PCM_MAX_RATE
			fatal "Invalid sample rate: samplerate. TYPE_PCM only supports sample rates <= 25100 Hz"
			endif
		dc.b	TYPE_PCM				; $00	- type
		dc.b	sampleflags+0				; $01	- flags (optional)
		dc.b	(samplerate+0)*256/TYPE_PCM_BASE_RATE	; $02	- pitch (optional for .WAV files)
		dc.b	0					; $03	- <RESERVED>
		dc.l	sampleptr-(*+4)				; $04	- start offset
		dc.l	sampleptr_End-(*+4)			; $08	- end offset
		elseif "sampletype"=="DPCM"
			if samplerate>TYPE_DPCM_MAX_RATE
			fatal "Invalid sample rate: samplerate. TYPE_DPCM only supports sample rates <= 20600 Hz"
			endif
		dc.b	TYPE_DPCM				; $00	- type
		dc.b	sampleflags+0				; $01	- flags (optional)
		dc.b	(samplerate)*256/TYPE_DPCM_BASE_RATE	; $02	- pitch
		dc.b	0					; $03	- <RESERVED>
		dc.l	sampleptr-(*+4)				; $04	- start offset
		dc.l	sampleptr_End-(*+4)			; $08	- end offset
		elseif "sampletype"=="PCM-TURBO"
			if ((samplerate+0)<>TYPE_PCM_TURBO_MAX_RATE)&((samplerate+0)<>0)
			fatal "Invalid sample rate: samplerate. TYPE_PCM_TURBO only supports sample rate of 32000 Hz"
			endif
		dc.b	TYPE_PCM_TURBO				; $00	- type
		dc.b	sampleflags+0				; $01	- flags (optional)
		dc.b	$FF					; $02	- pitch (optional for .WAV files)
		dc.b	0					; $03	- <RESERVED>
		dc.l	sampleptr-(*+4)				; $04	- start offset
		dc.l	sampleptr_End-(*+4)			; $08	- end offset
		elseif "sampletype"=="DPCM-HQ"
		fatal "TEMPORAL ERROR: MPCM2.1 doesn't exist at this point in time"
		else
		fatal "ERROR: Unknown or unsupported sample type: sampletype"
		endif
	endif
	endm

; ------------------------------------------------------------------------------
; Macro to include a sample file
; ------------------------------------------------------------------------------

pcminc macro NAME,PATH
	if "NAME"=="START"
	elseif "NAME"=="END"
	else
	even
NAME:	label *
	binclude	PATH
NAME_End:	label *
	endif
	endm

; ------------------------------------------------------------------------------
; Macro to stop Z80 and take over its bus
; ------------------------------------------------------------------------------

MPCM_stopZ80:	macro OPBUSREQ
	if ARGCOUNT==1
		move.w	#$100, OPBUSREQ
	else
		move.w	#$100, MPCM_Z80_BUSREQ
	endif
	endm

; ------------------------------------------------------------------------------
; Macro to wait for Z80 bus control
; ------------------------------------------------------------------------------
MPCM_waitZ80:	macro OPBUSREQ
	if ARGCOUNT==1
	.wait:
		bset	#0, OPBUSREQ
		bne.s	.wait
	else
	.wait:
		bset	#0, MPCM_Z80_BUSREQ
		bne.s	.wait
	endif
	endm

; ------------------------------------------------------------------------------
; Macro to start Z80 and release its bus
; ------------------------------------------------------------------------------

MPCM_startZ80:	macro OPBUSREQ
	if ARGCOUNT==1
		move.w	#0, OPBUSREQ
	else
		move.w	#0, MPCM_Z80_BUSREQ
	endif
	endm

; ------------------------------------------------------------------------------
; Ensures Mega PCM 2 isn't busy writing to YM (other than DAC output obviously)
; ------------------------------------------------------------------------------

MPCM_ensureYMWriteReady:	macro OPBUSREQ
	.chk_ready:
		tst.b	(MPCM_Z80_RAM+Z_MPCM_DriverReady).l
		bne.s	.ready
		MPCM_startZ80	OPBUSREQ
		move.w	d0, -(sp)
		moveq	#10,d0
		dbf	d0,*			; waste 100+ cycles
		move.w	(sp)+, d0
		MPCM_stopZ80	OPBUSREQ
		MPCM_waitZ80	OPBUSREQ
		bra.s	.chk_ready
	.ready:
	endm