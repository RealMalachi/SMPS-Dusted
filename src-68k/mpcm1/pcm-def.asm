__PcmName	equ "MegaPCM1"
; ---------------------------------------------------------------------------
fmstart macro ymstatreg
	SMPS_stopZ80
	lea	ymstat,ymstatreg
	SMPS_waitZ80
	endm
fmwait macro ymstatreg,ymregnum
	; no waiting
	endm
fmstop macro ymstatreg
	fmdelay 0
-	tst.b	(ymstatreg)
	bmi.s	-
	move.b	#$2A,yma0-ymstat(ymstatreg)
	SMPS_startZ80
	endm
fmdelay macro value
.fmd	set 12-value
	if .fmd>0
		rept .fmd/8
		or.l	d0,d0				; 8
		endr
	endif
	endm
fmwrite macro ymstatreg,ymareg,ymdreg,ymregnum
-	tst.b	(ymstatreg)
	bmi.s	-
	if ymregnum==0
	move.b	ymareg,yma0-ymstat(ymstatreg)
	nop
	move.b	ymdreg,ymd0-ymstat(ymstatreg)
	else
	move.b	ymareg,yma1-ymstat(ymstatreg)
	nop
	move.b	ymdreg,ymd1-ymstat(ymstatreg)
	endif
	; NOTE: have a 12 cycle delay before the next fm write attempt
	endm
updfifo macro
	SMPS_assert "MegaPCM1 has no FIFO"
	endm
; ---------------------------------------------------------------------------
; PP.. .TLS
FLAGS_SFX:		equ 1<<0
FLAGS_LOOP:		equ 1<<1

FLAGS_PANL:		equ $40
FLAGS_PANR:		equ $80
FLAGS_PANC:		equ $C0

TYPE_NONE:		equ $00
TYPE_PCM:		equ 'P'
TYPE_PCM_TURBO:		equ TYPE_PCM
TYPE_DPCM:		equ 'D'
TYPE_PCM_BASE_RATE	equ 29000	; Hz
TYPE_DPCM_BASE_RATE	equ 32000	; Hz
TYPE_PCM_CYCLES		equ 122
TYPE_DPCM_CYCLES	equ 111
; ---------------------------------------------------------------------------
Z_MPCM_SampleTable	equ $0210
Z_MPCM_CommandInput	equ $1FFF
Z_MPCM_DriverReady	equ $1FFE
; ===========================================================================
; converted into the following format for Z80
; 00h - Flags
; 01h - Pitch
; 02h - Start Bank
; 03h - End Bank
; 04h - Start Offset (in Start bank)
; 06h - End Offset (in End bank)
pcmdefext macro sampletype,sampleptr,sampleseqid,samplequeueid,samplerate,sampleflags
	if "sampletype"=="NONE"
	!dc.l	0,0
	!dc.b	0,0
	elseif "sampletype"=="PCM"
;		if (samplerate+0)>TYPE_PCM_BASE_RATE
;		fatal "Invalid sample rate: samplerate. TYPE_PCM only supports sample rates <= 29000 Hz"
;		endif
	!dc.l	sampleptr-(*+4)
	!dc.l	sampleptr_End-1-(*+4)
	!dc.b	sampleflags+0, 1+(3579478/(samplerate)-(TYPE_PCM_CYCLES)+(13/2))/13
	elseif "sampletype"=="DPCM"
;		if samplerate>TYPE_DPCM_BASE_RATE
;		fatal "Invalid sample rate: samplerate. TYPE_DPCM only supports sample rates <= 32000 Hz"
;		endif
	!dc.l	sampleptr-(*+4)
	!dc.l	sampleptr_End-1-(*+4)
	!dc.b	sampleflags+4, 1+(3579478/(samplerate)-(TYPE_DPCM_CYCLES)+(13/2))/13
	else
	fatal "ERROR: Unknown or unsupported sample type: sampletype"
	endif
	endm
pcmdefend macro
	!dc.w -1
	endm
