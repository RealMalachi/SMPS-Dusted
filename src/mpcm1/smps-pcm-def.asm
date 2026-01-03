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
TYPE_PCM_BASE_RATE	= 29000	; Hz
TYPE_DPCM_BASE_RATE	= 32000	; Hz
TYPE_PCM_CYCLES		= 122
TYPE_DPCM_CYCLES	= 111
; ---------------------------------------------------------------------------
Z_MPCM_SampleTable	equ $0210
Z_MPCM_CommandInput	equ $1FFF
Z_MPCM_DriverReady	equ $1FFE
; ===========================================================================
; 00h - Flags
; 01h - Pitch
; 02h - Start Bank
; 03h - End Bank
; 04h - Start Offset (in Start bank)
; 06h - End Offset (in End bank)
dcSample macro SAMPLETYPE,SAMPLEPTR,SAMPLERATE,SAMPLEFLAGS
	if (SAMPLETYPE==TYPE_NONE)
	dc.l	0,0
	dc.b	0,0
	elseif (SAMPLETYPE==TYPE_PCM)
	dc.l	SAMPLEPTR-(*+4)
	dc.l	SAMPLEPTR_End-1-(*+4)
	dc.b	SAMPLEFLAGS+0, 1+(Z80_Clock/(SAMPLERATE)-(TYPE_PCM_CYCLES)+(13/2))/13
	elseif (SAMPLETYPE==TYPE_DPCM)
	dc.l	SAMPLEPTR-(*+4)
	dc.l	SAMPLEPTR_End-1-(*+4)
	dc.b	SAMPLEFLAGS+4, 1+(Z80_Clock/(SAMPLERATE)-(TYPE_DPCM_CYCLES)+(13/2))/13
	else
	fatal "Unknown PCM type"
	endif
	endm

incdac:	macro NAME, PATH
	even
NAME:	label *
	binclude	PATH
NAME_End:	label *
	endm
incdacStart macro
	endm
incdacEnd macro
	endm