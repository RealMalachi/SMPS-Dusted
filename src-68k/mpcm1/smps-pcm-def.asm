; sound define macros - megapcm1
fmstart macro ymstatreg
	SMPS_stopZ80
	lea	ymstat,ymstatreg
	SMPS_waitZ80
	endm
fmstop macro ymstatreg
-	tst.b	(ymstatreg)
	bmi.s	-
	move.b	#$2A,yma0-ymstat(ymstatreg)
	SMPS_startZ80
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
TYPE_PCM_BASE_RATE	= 29000	; Hz
TYPE_DPCM_BASE_RATE	= 32000	; Hz
TYPE_PCM_CYCLES		= 122
TYPE_DPCM_CYCLES	= 111
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

		if "sampleseqid"==""
		elseif (musidbase2+musidtrack)>=$E0
		fatal "ERROR: sampleseqid ($\{musidbase2+musidtrack}) exceeds valid SMPS sequence IDs ($E0)"
		else
sampleseqid	equ musidbase2+musidtrack
		endif
musidtrack	set musidtrack+1

		if "sampletype"=="END"
		dc.w	-1	; end marker
musidtrack	set -1
		elseif "sampletype"=="NONE"
		dc.l	0,0
		dc.b	0,0
		elseif "sampletype"=="PCM"
;			if (samplerate+0)>TYPE_PCM_BASE_RATE
;			fatal "Invalid sample rate: samplerate. TYPE_PCM only supports sample rates <= 29000 Hz"
;			endif
		dc.l	sampleptr-(*+4)
		dc.l	sampleptr_End-1-(*+4)
		dc.b	sampleflags+0, 1+(Z80_Clock/(samplerate)-(TYPE_PCM_CYCLES)+(13/2))/13
		elseif "sampletype"=="DPCM"
;			if samplerate>TYPE_DPCM_BASE_RATE
;			fatal "Invalid sample rate: samplerate. TYPE_DPCM only supports sample rates <= 32000 Hz"
;			endif
		dc.l	sampleptr-(*+4)
		dc.l	sampleptr_End-1-(*+4)
		dc.b	sampleflags+4, 1+(Z80_Clock/(samplerate)-(TYPE_DPCM_CYCLES)+(13/2))/13
		else
		fatal "ERROR: Unknown or unsupported sample type: sampletype"
		endif
	endif
	endm

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