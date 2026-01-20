; ===========================================================================
; SMPS2ASM created by Flamewing, based on S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; Modified for SMPS-Dusted by Malachi
; ===========================================================================
; Permission to use, copy, modify, and/or distribute this software for any
; purpose with or without fee is hereby granted.
;
; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
; OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
; ===========================================================================
SMPS2ASMVer	equ 1
SMPSCPUVer	equ "68K"	; 68K, Z80
FixMusicAndSFXDataBugs	equ 1
; ---------------------------------------------------------------------------
; Standard Octave Pitch Equates
	enumconf	$C
	enum		smpsPitch10lo=$88,smpsPitch09lo,smpsPitch08lo,smpsPitch07lo,smpsPitch06lo
	nextenum	smpsPitch05lo,smpsPitch04lo,smpsPitch03lo,smpsPitch02lo,smpsPitch01lo
	enum		smpsPitch00=$00
	nextenum	smpsPitch01hi,smpsPitch02hi,smpsPitch03hi,smpsPitch04hi,smpsPitch05hi
	nextenum	smpsPitch06hi,smpsPitch07hi,smpsPitch08hi,smpsPitch09hi,smpsPitch10hi
	enumconf	1
; ---------------------------------------------------------------------------
; Note Equates
	enum		nRst=$80
; note(heh) that only these notes exist internally
;	nextenum	nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
;	nextenum	nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
;	nextenum	nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
;	nextenum	nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
;	nextenum	nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
;	nextenum	nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
;	nextenum	nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
;	nextenum	nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
; full SMPS note table provided by MDTravis
; https://github.com/flamewing/flamedriver/pull/29
	nextenum	nC0,nCs0,nDb0=nCs0,nD0,nDs0,nEb0=nDs0,nE0,nFb0=nE0,nEs0,nF0=nEs0
	nextenum	nFs0,nGb0=nFs0,nG0,nGs0,nAb0=nGs0,nA0,nAs0,nBb0=nAs0,nB0,nCb1=nB0,nBs0
	nextenum	nC1=nBs0,nCs1,nDb1=nCs1,nD1,nDs1,nEb1=nDs1,nE1,nFb1=nE1,nEs1,nF1=nEs1
	nextenum	nFs1,nGb1=nFs1,nG1,nGs1,nAb1=nGs1,nA1,nAs1,nBb1=nAs1,nB1,nCb2=nB1,nBs1
	nextenum	nC2=nBs1,nCs2,nDb2=nCs2,nD2,nDs2,nEb2=nDs2,nE2,nFb2=nE2,nEs2,nF2=nEs2
	nextenum	nFs2,nGb2=nFs2,nG2,nGs2,nAb2=nGs2,nA2,nAs2,nBb2=nAs2,nB2,nCb3=nB2,nBs2
	nextenum	nC3=nBs2,nCs3,nDb3=nCs3,nD3,nDs3,nEb3=nDs3,nE3,nFb3=nE3,nEs3,nF3=nEs3
	nextenum	nFs3,nGb3=nFs3,nG3,nGs3,nAb3=nGs3,nA3,nAs3,nBb3=nAs3,nB3,nCb4=nB3,nBs3
	nextenum	nC4=nBs3,nCs4,nDb4=nCs4,nD4,nDs4,nEb4=nDs4,nE4,nFb4=nE4,nEs4,nF4=nEs4
	nextenum	nFs4,nGb4=nFs4,nG4,nGs4,nAb4=nGs4,nA4,nAs4,nBb4=nAs4,nB4,nCb5=nB4,nBs4
	nextenum	nC5=nBs4,nCs5,nDb5=nCs5,nD5,nDs5,nEb5=nDs5,nE5,nFb5=nE5,nEs5,nF5=nEs5
	nextenum	nFs5,nGb5=nFs5,nG5,nGs5,nAb5=nGs5,nA5,nAs5,nBb5=nAs5,nB5,nCb6=nB5,nBs5
	nextenum	nC6=nBs5,nCs6,nDb6=nCs6,nD6,nDs6,nEb6=nDs6,nE6,nFb6=nE6,nEs6,nF6=nEs6
	nextenum	nFs6,nGb6=nFs6,nG6,nGs6,nAb6=nGs6,nA6,nAs6,nBb6=nAs6,nB6,nCb7=nB6,nBs6
	nextenum	nC7=nBs6,nCs7,nDb7=nCs7,nD7,nDs7,nEb7=nDs7,nE7,nFb7=nE7,nEs7,nF7=nEs7
	nextenum	nFs7,nGb7=nFs7,nG7,nGs7,nAb7=nGs7,nA7,nAs7,nBb7=nAs7

; SMPS2ASM uses nMaxPSG for songs from S1/S2 drivers.
; nMaxPSG1 and nMaxPSG2 are used only for songs from S3/S&K/S3D drivers.
; The use of psgdelta is intended to both apply and undo the effects of pitch conversions
; and ensure that the ending note is indeed the maximum PSG frequency.

; PSG conversion to S3/S&K/S3D drivers require a tone shift of 12 semi-tones.
psgdelta	equ	12
nMaxPSG		equ	nBb6-psgdelta
nMaxPSG1	equ	nBb6
nMaxPSG2	equ	nB6
; ---------------------------------------------------------------------------
; Channel IDs for SFX
;cPCM		equ	$40
;cFM1		equ	$00
;cFM2		equ	$01
cFM3		equ	$02
cFM4		equ	$04
cFM5		equ	$05
cFM6		equ	$06	; overrides PCM
cPSG1		equ	$80
cPSG2		equ	$A0
cPSG3		equ	$C0
cNoise		equ	$E0
; ---------------------------------------------------------------------------
	phase $E0
cPanLeft		ds.b 1		; cfPanLeft
cPanRight		ds.b 1		; cfPanRight
cPanCenter		;ds.b 1		; cfPanCenter
cPanCentre		ds.b 1		; cfPanCentre

cVolAdd			ds.b 1		; cfAddVolume
cVolAddFM		ds.b 1		; cfAddFMVolume
cVolAddPSG		ds.b 1		; cfAddPSGVolume
cVolSet			ds.b 1		; cfSetVolume
cVolSetFM		ds.b 1		; cfSetFMVolume
cVolSetPSG		ds.b 1		; cfSetPSGVolume

cVoiceFM		ds.b 1		; cfSetFMVoice
cVolEnv			ds.b 1		; cfSetVolEnv
cNoisePSG		ds.b 1		; cfSetPSGNoise

cDetune			ds.b 1		; cfDetune
cDontAttack		ds.b 1		; cfHoldNote
cNoteFill		ds.b 1		; cfNoteTimeout
cNoteFillZ80		ds.b 1		; cfNoteTimeoutZ80
cAddTranspose		ds.b 1		; cfAddTransposition
cSetTranspose		ds.b 1		; cfSetTranspose

cModSet68K		ds.b 1		; cfModulation68K
cModSetZ80		ds.b 1		; cfModulationZ80
cModOn			ds.b 1		; cfEnableModulation
cModOff			ds.b 1		; cfDisableModulation

cTempoDiv		ds.b 1		; cfSetTempoDivider

cJump			ds.b 1		; cfJumpTo
cJumpN8			ds.b 1		; cfJumpToN8
cRept			ds.b 1		; cfRepeatAtPos
cSetRept		ds.b 1		; cfSetRept
cCall			ds.b 1		; cfJumpToGosub
cReturn			ds.b 1		; cfJumpReturn
cStop			ds.b 1		; cfStopTrack

cExtCmd			ds.b 1		; cfExtendedCommands
	dephase

	phase 0
cxWriteReg		ds.b 1		; cfxWriteFMIorII
cxWriteFM1		ds.b 1		; cfxWriteFMI
cxWriteFM2		ds.b 1		; cfxWriteFMII
cxPanAuto		ds.b 1		; cfxUnk
cxPanAMSFMS		ds.b 1		; cfxPanningAMSFMS
cxSetLFO		ds.b 1		; cfxSetLFO
cxCommunicate		ds.b 1		; cfSetCommunication
cxSongFadeIn		ds.b 1		; cfxFadeInToPrevious
cxSpecialFM3		ds.b 1		; cfxUnk
cxRevUp			ds.b 1		; cfxRevUp
cxRevAddCur		ds.b 1		; cfxRevAddCur
cxRevReset		ds.b 1		; cfxRevReset
cxPlayID		ds.b 1		; cfxPlayID
cxStopFM		ds.b 1		; cfxStopFM
cxConditionalJump	ds.b 1		; cfxConditionalJump
cxHoldNoteIndefinitely	ds.b 1		; cfxHoldNoteIndefinitely
cxReleaseNote		ds.b 1		; cfxReleaseNote
cxSetPSG3		ds.b 1		; cfxSetPSG3
cxLoopCSFX		ds.b 1		; cfxLoopCSFX
cxModChg		ds.b 1		; cfxModChg
cxModChg2		ds.b 1		; cfxModChg2
cxRandPitch		ds.b 1		; cfxRandPitch
cxSample		ds.b 1		; cfxPlaySampleID
cxTempoMod		ds.b 1		; cfxSetTempoMod
cxTempoDivAll		ds.b 1		; cfxSetTempoDividerAll
;cxSetFreqMode1		ds.b 1		; cfxSetFreqMode1
;cxSetFreqMode2		ds.b 1		; cfxSetFreqMode2
	dephase
; ---------------------------------------------------------------------------
; Conversion macros and functions
;
; Sonic 1 requires a timer-to-overflow converter and clearing the overflow in software
; $100/mod rounding up and treating 0 as 256 results in this:
; 1 = $00,     2 = $80,     3 = $56|clr, 4 = $40
; 5 = $34|clr, 6 = $2B|clr, 7 = $25|clr, 8 = $20
; ...
; 256(0) = $01
; old conversion functions, known issues are as follows:
; - poor portability
; - it isn't even remotely readable
; - $1D (29) results in an overflow timer of 27
;conv0To256  function n,((n==0)<<8)|n
;s2TempotoS3 function n,($100-((n==0)|n))&$FF
;s1TempotoS2 function n,((((conv0To256(n)-1)<<8)+(conv0To256(n)>>1))/conv0To256(n))&$FF
;s1TempotoS3 function n,s2TempotoS3(s1TempotoS2(n))
;	dc.w	(s1TempotoS3(mod)+((mod&1)-(mod==1)))<<8|mod&1
;
; Sonic 2 is just a non-overflow timer and can be easily inverted
convertMainTempoMod macro mod
	if SourceDriver=="DUSTED"
	dc.w	mod
	elseif SourceDriver==1
		if mod==1
		fatal "Invalid main tempo of 1 in song from Sonic 1/SMPS 68K"
		endif
	dc.w	(($100/(((mod==0)*256)|mod))+($100#(((mod==0)*256)|mod)<>0))<<8|1
	elseif SourceDriver==2
		if mod==0
		fatal "Invalid main tempo of 0 in song from Sonic 2"
		endif
	dc.w	(($100-mod)&$FF)<<8
	elseif SourceDriver>=3
	dc.w	mod<<8
	else
		fatal "Unknown source driver, can't generate tempo"
	endif
	endm
CheckedChannelPointer macro loc
	if (MOMPASS=1)&&(DEFINED(loc))
	fatal "$\{loc-(*)-2} Tracks must come after the header"
	endif
	dc.w	loc-((*)+2)
	endm
CheckedChannelJump macro loc
	dc.w	loc-((*)+1)
	endm
; ---------------------------------------------------------------------------
; Header Macros
smpsHeaderStartSong macro ver, sourcesmps2asmver
SourceDriver set ver
songStart set *
volenvHeader set 0
modenvHeader set 0
fmCount   set 0
psgCount  set 0
dacCount  set 0

	if ("sourcesmps2asmver"<>"")
	set SourceSMPS2ASM,sourcesmps2asmver
	else
	set SourceSMPS2ASM,0
	endif

	if (MOMPASS=1)&&(SMPS2ASMVer<SourceSMPS2ASM)
	warning "Song at 0x\{songStart} was made for a newer version of SMPS2ASM (this is version \{SMPS2ASMVer}, but song wants at least version \{SourceSMPS2ASM})."
	endif
	endm
; Header - Set up Voice Location
; Common to music and SFX
smpsHeaderVoice macro loc
	if songStart<>*
	fatal "Missing smpsHeaderStartSong"
	endif
	CheckedChannelPointer loc
	endm

smpsHeaderVoiceNull macro
	if songStart<>*
	fatal "Missing smpsHeaderStartSong"
	endif
	dc.w	0
	endm

; Header - Set up Voice Location as S3's Universal Voice Bank
; Common to music and SFX
smpsHeaderVoiceUVB macro
	if songStart<>*
	fatal "Missing smpsHeaderStartSong"
	endif
	dc.w	0
	endm

smpsHeaderVolEnv macro loc
volenvHeader set loc
	endm

smpsHeaderModEnv macro loc
modenvHeader set loc
	endm

; Header macros for music (not for SFX)
; Header - Set up Channel Usage
smpsHeaderChan macro fm,psg,dac
	if ARGCOUNT>2
fmCount  set fm
psgCount set psg
dacCount set dac
	elseif SourceDriver=="DUSTED"
	fatal "Please specify all sound channels (including DACs)"
	else
fmCount  set fm-(fm>0)
psgCount set psg
dacCount set (fm>0)
	endif
	endm

; Header - Set up Tempo
smpsHeaderTempo macro div,mod
	if volenvHeader=0
	dc.w	0
	else
	CheckedChannelPointer volenvHeader
	endif
	if modenvHeader=0
	dc.w	0
	else
	CheckedChannelPointer modenvHeader
	endif
	convertMainTempoMod mod
	dc.b	div,dacCount,fmCount,psgCount
	endm

; Header - Set up DAC Channel
smpsHeaderDAC macro loc,pitch,vol
	CheckedChannelPointer loc
	if ("pitch"<>"")
		if ("vol"<>"")
		dc.b	pitch,vol
		else
		dc.b	pitch,$00
		endif
	else
	dc.w	$00
	endif
	endm

; Header - Set up FM Channel
smpsHeaderFM macro loc,pitch,vol
	CheckedChannelPointer loc
	dc.b	pitch,vol
	endm

; Header - Set up PSG Channel
; In standard SMPS 68k Type 1, frequency/modulation envelopes are skipped and can contain garbage.
smpsHeaderPSG macro loc,pitch,vol,mod,voice
	CheckedChannelPointer loc
	if SourceDriver=="DUSTED"
	dc.b	pitch,vol,mod,voice
	elseif SourceDriver>=3
	dc.b	pitch,((vol&$F)<<3)|((vol)&$80),mod,voice
	else
	dc.b	(pitch+psgdelta)&$FF,((vol&$F)<<3)|((vol)&$80),0,voice
	endif
	endm
;		if (mod<>0) && (MOMPASS=1)
;		warning "This track header specifies a frequency envelope, but this driver does not support them."
;		endif

; Header macros for SFX (not for music)
; Header - Set up Tempo
smpsHeaderTempoSFX macro div
	if volenvHeader=0
	dc.w	0
	else
	CheckedChannelPointer volenvHeader
	endif
	if modenvHeader=0
	dc.w	0
	else
	CheckedChannelPointer modenvHeader
	endif
	dc.b	div
	endm

; Header - Set up Channel Usage
smpsHeaderChanSFX macro chan
	dc.b	chan
	endm

; Header - Set up SFX Channel
smpsHeaderSFXChannel macro chanid,loc,pitch,vol
	if (MOMPASS=1)&&(DEFINED(loc))
	fatal "$\{loc-(*)-1} Tracks must come after the header"
;	elseif (MOMPASS>1)	; doesn't work, thanks AS
;		if (loc-((*)+1))>$FF
;		warning "SFX channel offset too large for u8: 0x\{loc-((*)+1)}"
;		endif
	elseif (chanid<$80) || (SourceDriver=="DUSTED")
	dc.b	chanid,pitch,vol,loc-((*)+1+3)
	elseif SourceDriver>=3
	dc.b	chanid,pitch,((vol&$F)<<3)|((vol)&$80),loc-((*)+1+3)
	else
	dc.b	chanid,(pitch+psgdelta)&$FF,((vol&$F)<<3)|((vol)&$80),loc-((*)+1+3)
	endif
	endm
; ---------------------------------------------------------------------------
; Co-ord Flag Macros and Equates
panNone		equ $00
panRight	equ $40
panLeft		equ $80
panCentre	equ $C0
panCenter	equ $C0
; Set Panning/AMS/FMS
smpsPan macro direction,amsfms
	if (direction+amsfms)=panLeft
	smpsPanLeft
	elseif (direction+amsfms)=panRight
	smpsPanRight
	elseif (direction+amsfms)=panCentre
	smpsPanCenter
	else
	dc.b cExtCmd,cxPanAMSFMS,direction+amsfms
	endif
	endm
smpsPanCenter macro
	dc.b cPanCentre
	endm
smpsPanCentre macro
	dc.b cPanCenter
	endm
smpsPanLeft macro
	dc.b cPanLeft
	endm
smpsPanRight macro
	dc.b cPanRight
	endm
;smpsPanAuto macro val1,val2,val3,val4,val5
;	dc.b cExtCmd,cxPanAuto,val1,val2,val3,val4,val5
;	endm
;smpsPanAutoOff macro
;	dc.b cExtCmd,cxPanAuto,$00
;	endm
smpsSetLFO macro enable,amsfms
	dc.b	cExtCmd,cxSetLFO,enable,amsfms&$3F
	endm

; Set channel detune to val
smpsDetune macro val
	dc.b	cDetune,val
	endm

; Set communication byte
smpsCommunicate macro val
	dc.b	cExtCmd,cxCommunicate,val
	endm

; Set channel tempo divider
smpsChanTempoDiv macro val
	dc.b	cTempoDiv,val
	endm
; Set music tempo divider
smpsSetTempoDiv macro val
	dc.b	cExtCmd,cxTempoDivAll,val
	endm
; Set music tempo modifier
smpsSetTempoMod macro mod
	dc.b	cExtCmd,cxTempoMod
	convertMainTempoMod mod
	endm

; Set Volume to xx
; DUSTED bases this in attenuation like AlterVol, S3K bases it on volume-ish
smpsSetVol macro vol
	if (SourceDriver=="DUSTED")
	dc.b	cVolSet,vol
	else
	dc.b	cVolSet,(vol&$7F)!$7F
	endif
	endm
smpsFMSetVol macro vol
	if (SourceDriver=="DUSTED")
	dc.b	cVolSet,vol
	else
	dc.b	cVolSet,(vol&$7F)!$7F
	endif
	endm
smpsPSGSetVol macro vol
	if (SourceDriver=="DUSTED")
	dc.b	cVolSetPSG,vol
	else
	dc.b	cVolSetPSG,((vol&$F)!&$F)<<3
	endif
	endm
; Add to Volume by xx
smpsAlterVol macro vol
	if (vol=0) && (MOMPASS=1)
	warning "eh?"
	endif
	dc.b	cVolAdd,vol
	endm
smpsFMAlterVol macro vol
	if (vol=0) && (MOMPASS=1)
	warning "eh?"
	endif
	dc.b	cVolAddFM,vol
	endm
smpsPSGAlterVol macro vol
	if (vol=0) && (MOMPASS=1)
	warning "eh?"
	endif
	if (SourceDriver=="DUSTED")
	dc.b	cVolAddPSG,vol
	else
	dc.b	cVolAddPSG,((vol&$F)<<3)|((vol)&$80)
	endif
	endm

; Prevent attack of next note
smpsHoldNote	equ cDontAttack
smpsHoldNotes macro
	dc.b	cExtCmd,cxHoldNoteIndefinitely
	endm
smpsReleaseNotes macro
	dc.b	cExtCmd,cxReleaseNote
	endm

; Set note fill to xx
; type 0 is 68K, type 1 is Z80, if type isn't specified then base it on the source driver
smpsNoteFill macro val,type
	if ("type"=="") && (SourceDriver=="DUSTED")
	fatal "Please specify the note file version"
	elseif ("type"=="") && (SourceDriver<3)
	dc.b	cNoteFill,val
	elseif ("type"==""); && (SourceDriver>=3)
	dc.b	cNoteFillZ80,val
	elseif type=0
	dc.b	cNoteFill,val
	elseif type=1
	dc.b	cNoteFillZ80,val
	else
	fatal "Invalid smpsNoteFill type"
	endif
	endm
; change pitch
smpsAddTranspose macro val
	if (val=0) && (MOMPASS=1)
	warning "eh?"
	endif
	dc.b	cAddTranspose,val
	endm
smpsSetTranspose macro val
	dc.b	cSetTranspose,val
	endm
smpsRandPitch macro valto,valfrom
	dc.b	cExtCmd,cxRandPitch,(valfrom-(valto))+1,valto
	endm

; initialize modulation algorithm
; the algorithm type can be specified, DUSTED sources expect
; you to define the type but it'll be auto-detected for others
smpsModSet macro wait,speed,change,step,type
	if ("type"=="") && (SourceDriver=="DUSTED")
	fatal "Please specify the modulation algorithm version"
	elseif ("type"=="") && (SourceDriver<3)
	dc.b	cModSet68K,wait,speed,change,step
	elseif ("type"==""); && (SourceDriver>=3)
	dc.b	cModSetZ80,wait,speed,change,step
	elseif type=0
	dc.b	cModSet68K,wait,speed,change,step
	elseif type=1
	dc.b	cModSetZ80,wait,speed,change,step
	else
	fatal "Invalid smpsModSet type"
	endif
	endm
smpsModOn macro mod
	if ("mod"="")||("mod"<>$80)
	dc.b	cModOn
	else
	dc.b	cExtCmd,cxModChg,mod
	endif
	endm
smpsModOff macro
	dc.b	cModOff
	endm
smpsModChange macro mod
	dc.b	cExtCmd,cxModChg,mod
	endm
smpsModChange2 macro fmmod,psgmod
	dc.b	cExtCmd,cxModChg2,fmmod,psgmod
	endm

; Play sample ID (for samples outside of 81-DF range)
smpsPlayDACSample macro smpID
	dc.b	cExtCmd,cxSample,(smpID)>>8,(smpID)&$FF
	endm
; Set FM voice
smpsFMvoice macro voice,soundID
	if "soundID"<>""
	fatal "This driver does not support smpsFMvoice checking for voices in different sound IDs."
	endif
	dc.b	cVoiceFM,voice
	endm
; Set FM volume envelope
; smps-z80 includes the ability to mask the effects of the envelope per-operator.
; smps-dusted handles it per-channel
smpsFMVolEnv macro voice,mask
	if (mask<>$F)&&(MOMPASS==1)
	warning "this driver doesn't support smpsFMVolEnv per-operator enveloping, it'll act as if the mask was set to $F"
	endif
	dc.b	cVolEnv,voice
	endm
; Set PSG voice... which is just the volume envelope
smpsPSGvoice macro voice
	dc.b	cVolEnv,voice
	endm
; Set PSG3/PSG4 waveform
; 0 makes it return to PSG3, 0xE0-0xE7 are PSG noise settings, anything else is invalid
smpsPSGform macro form
	if form=0
	dc.b	cExtCmd,cxSetPSG3
	elseif (form>=$E0)&&(form<=$E7)
	dc.b	cNoisePSG,form
	else
	fatal "smpsPSGform only accepts parameter values of 0 or between $E0-$E7"
	endif
	endm

; Jump to loc. This is primarily used for indefinite loops
smpsJump macro loc
	if (DEFINED(loc))					; ensure that the label is already defined
		if ((loc-(*)) < 0) && ((loc-(*)) >= -$FF)	; check if offset is within n8 (TODO: stress test)
		dc.b	cJumpN8,(loc-(*))&$FF
		else
		dc.b	cJump
		CheckedChannelJump loc
		endif
	else
		dc.b	cJump
		CheckedChannelJump loc
	endif
	endm
; Loop `loc` `loop` times, with `loop` being kept track with in `index` relative to channel stack
smpsLoop macro index,loops,loc
	if index>12
	fatal "can't have more then 12 indexes"
	elseif (index>3) && (MOMPASS=1)
	warning "it's not advised to have more then 4 loop indexes"
	endif
	dc.b	cRept,index,loops
	CheckedChannelJump loc
	endm
; set 'index' to 'loop'
smpsSetLoop macro index,loops
	if index>12
	fatal "can't have more then 12 indexes"
	elseif (index>3) && (MOMPASS=1)
	warning "it's not advised to have more then 4 loop indexes"
	endif
	dc.b	cSetRept,index,loops
	endm
; If loop index is on its last loop (loop counter equals 1), perform a jump
smpsConditionalJump macro index,loc
	if index>12
	fatal "can't have more then 12 indexes"
	elseif (index>3) && (MOMPASS=1)
	warning "it's not advised to have more then 4 loop indexes"
	endif
	dc.b	cxConditionalJump,index
	CheckedChannelJump loc
	endm
; If the same sound ID gets queued multiple times, perform a jump
smpsContinuousLoop macro loc
	dc.b	cExtCmd,cxLoopCSFX
	CheckedChannelJump loc
	endm

; Jump to loc, save location after the call into channel stack
smpsCall macro loc
	dc.b	cCall
	CheckedChannelJump loc
	endm
; Return to saved location from smpsCall
smpsReturn macro val
	dc.b	cReturn
	endm

; End of channel
smpsStop macro
	dc.b	cStop
	endm
; Stops background SFX channel
smpsStopSpecial macro
	dc.b	cStop
	endm
; Silences FM channel then stops
smpsStopFM macro
	dc.b	cExtCmd,cxStopFM
	endm
; ---------------------------------------------------------------------------
; Sonic game specific features, don't expect these to be commonplace elsewhere

; For FM1, set D1L to maximum volume (minimum attenuation) and RR to maximum for operators 3 and 4
smpsMaxRelRate macro
	smpsFMICommand $88,$0F
	smpsFMICommand $8C,$0F
	endm
; Fade in previous song from a jingle (1up)
; in smps-dusted, val defines the fadein counter, if not defined then it uses the default
; in smps-68000, val doesn't exist, simple
; in smps-z80... nobody has even the slightest clue what they were on, but it was evidently some good shit
; - val $FF is the fade-in
; - val $29 (the hardcoded 1up ID -1) acts as the 1up signifier flag, prevent sfx playback and such
; - anything aside for that, uhh, nothing?
; smps-z80s cxSongFadeIn uses the same byte as smps-68000s cxCommunicate
; essentially, all of S3Ks useless fades were erroneously unchanged communication leftovers from Sonic 1 and 2
; TODO: further validation to control the type of fade-in further if need be
smpsFade macro val,valid
	if ("val"=="")
	dc.b	cExtCmd,cxSongFadeIn,$50
	elseif ("valid"<>"")
	dc.b	cExtCmd,cxSongFadeIn,val
	elseif (MOMPASS=1)
	warning "smpsFade with defined value (val) and undefined id detected. This is an erroneous call, likely from Sonic 3."
	endif
	endm
; increase pitch and add to channel
smpsRevUp macro
	dc.b	cExtCmd,cxRevUp
	endm
; add current revving pitch to channel, don't increase pitch
smpsRevAddCurr macro
	dc.b	cExtCmd,cxRevAddCur
	endm
; reset revving pitch
smpsRevStop macro
	dc.b	cExtCmd,cxRevReset
	endm
; ---------------------------------------------------------------------------
; unsupported with interest to support
smpsModVoice macro voice,type
	fatal "smpsModVoice is unsupported"
	endm
; ---------------------------------------------------------------------------
; using these is not advised

; queue new sounds
smpsPlayMusic macro index
	dc.b	cExtCmd,cxPlayID,index>>8,index&$FF
	endm
smpsPlaySound macro index
	dc.b	cExtCmd,cxPlayID,index>>8,index&$FF
	endm
; write unprotected command to YmA0, does not care about SFXs
smpsFMICommand macro reg,val
	dc.b	cExtCmd,cxWriteFM1,reg,val
	endm
; write unprotected command to YmA1, does not care about SFXs
smpsFMIICommand macro reg,val
	dc.b	cExtCmd,cxWriteFM2,reg,val
	endm
; write command to the current FM channel, if not overridden by SFX
smpsChanFMCommand macro reg,val
	dc.b	cExtCmd,cxWriteReg,reg,val
	endm
; ---------------------------------------------------------------------------
; Backwards compatibility
smpsNoAttack	equ smpsHoldNote
smpsNoAttacks macro
	smpsHoldNotes ALLARGS
	endm
smpsAllowAttacks macro
	smpsReleaseNotes ALLARGS
	endm
smpsNop macro
	smpsCommunicate ALLARGS
	endm
smpsAlterNote macro
	smpsDetune ALLARGS
	endm
smpsAlterPitch macro
	smpsAddTranspose ALLARGS
	endm
smpsChangeTransposition macro val
	smpsAddTranspose ALLARGS
	endm
smpsFMFlutter macro
	smpsFMVolEnv ALLARGS
	endm
smpsWeirdD1LRR macro
	smpsMaxRelRate ALLARGS
	endm
smpsSetvoice macro
	smpsFMvoice ALLARGS
	endm
smpsPSGAlterVolS2 macro vol
	smpsPSGAlterVol vol
	endm
smpsSpindashRev macro
	smpsRevUp
	endm
smpsResetSpindashRev macro
	smpsRevStop
	endm
smpsSetNote macro val
	dc.b	cSetTranspose,(val-$40)&$FF
	endm
smpsPSGpulse macro
	if MOMPASS==1
	warning "smpsPSGpulse is deprecated, we're using smpsPSGform with a parameter of 0 now"
	endif
	smpsPSGform 0
	endm
; ---------------------------------------------------------------------------
; unsupported with no interest to support
smpsClearPush macro
	if MOMPASS==1
	warning "smpsClearPush is unsupported"
	endif
	endm
;	dc.b cExtCmd,cxPushFlag
smpsCopyData macro data,len
	fatal "smpsCopyData is unsupported"
	endm
;	dc.b	cExtCmd,$03
;	dc.w	little_endian(data)
;	dc.b	len
smpsHaltMusic macro flag
	fatal "smpsHaltMusic is unsupported"
	endm
;	dc.b	cExtCmd,$02,flag
smpsSSGEG macro op1,op2,op3,op4
	fatal "smpsSSGEG is unsupported. In this variant of SMPS, SSG-EG is usually expected to be set via the FM instruments."
	endm
;	smpsChanFMCommand $90,op1
;	smpsChanFMCommand $94,op3
;	smpsChanFMCommand $98,op2
;	smpsChanFMCommand $9C,op4
smpsAlternateSMPS macro flag
	fatal "smpsAlternateSMPS is unsupported"
	endm
;	if flag=0
;	dc.b	cExtCmd,cxSetFreqMode1
;	else
;	dc.b	cExtCmd,cxSetFreqMode2
;	endif
;	endm
smpsFM3SpecialMode macro ind1,ind2,ind3,ind4
	fatal "smpsFM3SpecialMode is unsupported"
	endm
;	dc.b	cExtCmd,0,ind1,ind2,ind3,ind4
smpsPitchSlide macro enable
	fatal "smpsPitchSlide is unsupported"
	endm
;	dc.b	cExtCmd,0,enable
; ---------------------------------------------------------------------------
envtableoff := -1
envtableid  := 0
smpsEnvTable macro off,idcmp
	if "off"=="START"
		if envtableid<>0
		fatal "Volume envelope table was being started while already being started"
		endif
envtableoff := (*)
envtableid  := 1
	elseif "off"=="END"
		if envtableid=0
		fatal "Volume envelope table was being ended while already being ended"
		endif
envtableoff := -1
envtableid  := 0
	else
		if envtableid=0
		fatal "Volume envelope table was compromised or ended prior to this command"
		endif
		if "idcmp"<>""
idcmp		equ envtableid
		endif
	dc.w off-envtableoff
envtableid := envtableid+1
	endif
	endm

smpsVolEnv macro data,data2
	if "data"==""
	elseif "data"=="RESET"
	dc.b	$80
	elseif "data"=="HOLD"
	dc.b	$81
	elseif "data"=="INDEX"
		if "data2"==""
		fatal "Where's the index?"
		endif
	dc.b	$82,data2
	elseif "data"=="REST"
	dc.b	$83
	else
		if data>$7F
		dc.b	$7F
		elseif data<0
		fatal "negative volume envelopes aren't supported"
		else
		dc.b	data
		endif
	shift
	smpsVolEnv ALLARGS
	endif
	endm
smpsVolEnvPsg macro data,data2
	if "data"==""
	elseif "data"=="RESET"
	dc.b	$80
	elseif "data"=="HOLD"
	dc.b	$81
	elseif "data"=="INDEX"
		if "data2"==""
		fatal "Where's the index?"
		endif
	dc.b	$82,data2
	elseif "data"=="REST"
	dc.b	$83
	else
		if data>$F
		dc.b	$7F
		elseif data<0
		fatal "negative volume envelopes aren't supported"
		else
		dc.b	data<<3
		endif
	shift
	smpsVolEnvPsg ALLARGS
	endif
	endm

smpsModEnv macro data,data2
	if "data"==""
	elseif "data"=="RESET"
	dc.b	$80,$10
	elseif "data"=="HOLD"
	dc.b	$80,$11
	elseif "data"=="INDEX"
		if "data2"==""
		fatal "Where's the index?"
		endif
	dc.b	$80,$12,data2
	elseif "data"=="REST"
	dc.b	$80,$13
	else
		if (data>$7FFF)||(data<~$7FFF)
		warning "bruh zone"
		elseif (data>$7FF)||(data<~$7FF)
		dc.b	$80,$14,(data>>8)&$FF,(data)&$FF
		elseif (data>$7F)||(data<-$7F)
		dc.b	$80,$00|(data>>8)&$F,(data)&$FF
		else
		dc.b	data
		endif
	shift
	smpsModEnv ALLARGS
	endif
	endm
; ---------------------------------------------------------------------------
; Macros for FM instruments
; Voices - Feedback
smpsVcFeedback macro val
vcFeedback set val
	endm

; Voices - Algorithm
; This is also being used to set values we can't be certain will be defined beforehand
smpsVcAlgorithm macro val
vcAlgorithm set val
	set vcSSG1,0
	set vcSSG2,0
	set vcSSG3,0
	set vcSSG4,0
	endm

smpsVcUnusedBits macro val,d1r1,d1r2,d1r3,d1r4
vcUnusedBits set val
	if ("d1r1"<>"")&&("d1r2"<>"")&&("d1r3"<>"")&&("d1r4"<>"")
		set vcD1R1Unk,d1r1<<5
		set vcD1R2Unk,d1r2<<5
		set vcD1R3Unk,d1r3<<5
		set vcD1R4Unk,d1r4<<5
	else
		set vcD1R1Unk,0
		set vcD1R2Unk,0
		set vcD1R3Unk,0
		set vcD1R4Unk,0
	endif
	endm

; Voices - Detune
smpsVcDetune macro op1,op2,op3,op4
	set vcDT1,op1
	set vcDT2,op2
	set vcDT3,op3
	set vcDT4,op4
	endm

; Voices - Coarse-Frequency
smpsVcCoarseFreq macro op1,op2,op3,op4
	set vcCF1,op1
	set vcCF2,op2
	set vcCF3,op3
	set vcCF4,op4
	endm

; Voices - Rate Scale
smpsVcRateScale macro op1,op2,op3,op4
	set vcRS1,op1
	set vcRS2,op2
	set vcRS3,op3
	set vcRS4,op4
	endm

; Voices - Attack Rate
smpsVcAttackRate macro op1,op2,op3,op4
	set vcAR1,op1
	set vcAR2,op2
	set vcAR3,op3
	set vcAR4,op4
	endm

; Voices - Amplitude Modulation
; The original SMPS2ASM erroneously assumed the 6th and 7th bits
; were the Amplitude Modulation.
; According to several docs, however, it's actually the high bit.
smpsVcAmpMod macro op1,op2,op3,op4
	if SourceSMPS2ASM==0
	set vcAM1,op1<<5
	set vcAM2,op2<<5
	set vcAM3,op3<<5
	set vcAM4,op4<<5
	else
	set vcAM1,op1<<7
	set vcAM2,op2<<7
	set vcAM3,op3<<7
	set vcAM4,op4<<7
	endif
	endm

; Voices - First Decay Rate
smpsVcDecayRate1 macro op1,op2,op3,op4
	set vcD1R1,op1
	set vcD1R2,op2
	set vcD1R3,op3
	set vcD1R4,op4
	endm

; Voices - Second Decay Rate
smpsVcDecayRate2 macro op1,op2,op3,op4
	set vcD2R1,op1
	set vcD2R2,op2
	set vcD2R3,op3
	set vcD2R4,op4
	endm

; Voices - Decay Level
smpsVcDecayLevel macro op1,op2,op3,op4
	set vcDL1,op1
	set vcDL2,op2
	set vcDL3,op3
	set vcDL4,op4
	endm

; Voices - Release Rate
smpsVcReleaseRate macro op1,op2,op3,op4
	set vcRR1,op1
	set vcRR2,op2
	set vcRR3,op3
	set vcRR4,op4
	endm

; Voices - SSG-EG
; Somehow, this is a new feature of SMPS-Dusted
smpsVcSsgEg macro op1,op2,op3,op4
	set vcSSG1,op1
	set vcSSG2,op2
	set vcSSG3,op3
	set vcSSG4,op4
	endm

; Voices - Total Level
; On SMPS Z80 and Dusted, bit 7 of TL is used to tell the driver to not
; effect the operator with volume effects
; SMPS 68000 applies the following mask based on algo:
;    0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
; Similarly, the original SMPS2ASM decides TL high bits automatically,
; but later versions leave it up to the user.
smpsVcTotalLevel macro op1,op2,op3,op4
	if (SourceDriver=="DUSTED")
		set vcTL1,op1
		set vcTL2,op2
		set vcTL3,op3
		set vcTL4,op4
	elseif (SourceDriver<3)
		set vcTL1,op1&$7F|(1<<7)
		set vcTL2,op2&$7F|((vcAlgorithm>=5)<<7)
		set vcTL3,op3&$7F|((vcAlgorithm>=4)<<7)
		set vcTL4,op4&$7F|((vcAlgorithm==7)<<7)
	elseif SourceSMPS2ASM==0
		set vcTL1,op1|(1<<7)
		set vcTL2,op2|((vcAlgorithm>=5)<<7)
		set vcTL3,op3|((vcAlgorithm>=4)<<7)
		set vcTL4,op4|((vcAlgorithm==7)<<7)
	else
		set vcTL1,op1
		set vcTL2,op2
		set vcTL3,op3
		set vcTL4,op4
	endif
		dc.b	(vcUnusedBits<<6)+(vcFeedback<<3)+vcAlgorithm
		dc.b	(vcDT4<<4)+vcCF4       ,(vcDT3<<4)+vcCF3       ,(vcDT2<<4)+vcCF2       ,(vcDT1<<4)+vcCF1
		dc.b	(vcRS4<<6)+vcAR4       ,(vcRS3<<6)+vcAR3       ,(vcRS2<<6)+vcAR2       ,(vcRS1<<6)+vcAR1
		dc.b	vcAM4|vcD1R4|vcD1R4Unk ,vcAM3|vcD1R3|vcD1R3Unk ,vcAM2|vcD1R2|vcD1R2Unk ,vcAM1|vcD1R1|vcD1R1Unk
		dc.b	vcD2R4                 ,vcD2R3                 ,vcD2R2                 ,vcD2R1
		dc.b	(vcDL4<<4)+vcRR4       ,(vcDL3<<4)+vcRR3       ,(vcDL2<<4)+vcRR2       ,(vcDL1<<4)+vcRR1
		dc.b	(vcSSG4<<4)|vcSSG2     ,(vcSSG3<<4)|vcSSG1
		dc.b	vcTL4                  ,vcTL2                  ,vcTL3                  ,vcTL1
	endm
