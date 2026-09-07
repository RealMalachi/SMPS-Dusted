; sound define macros - blank
fmstart macro ymstatreg
; hahaha...
	endm
fmstop macro ymstatreg
; haha..
	endm
fmwrite macro ymstatreg,ymareg,ymdreg,ymregnum
; ha..
	endm
updfifo macro
	SMPS_assert "Fuck FM, no FIFO for you!"
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