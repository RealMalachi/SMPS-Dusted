; sound define macros - blank
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

		if "sampleseqid"==""
		elseif (musidbase2+musidtrack)>=$E0
		fatal "ERROR: sampleseqid ($\{musidbase2+musidtrack}) exceeds valid SMPS sequence IDs ($E0)"
		else
sampleseqid	equ musidbase2+musidtrack
		endif
musidtrack	set musidtrack+1

		if "sampletype"=="END"
musidtrack	set -1
		else
		;fatal "ERROR: Unknown or unsupported sample type: sampletype"
		endif
	endif
	endm

pcminc macro NAME,PATH
	if "NAME"=="START"
	elseif "NAME"=="END"
	else
NAME:	label *
	binclude	PATH
NAME_End:	label *
	endif
	endm