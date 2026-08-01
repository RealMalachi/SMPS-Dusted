Master_Clock		= 53693175		; NTSC=53693175,PAL=53203424
M68000_Clock		= Master_Clock/7	; 7670453
Z80_Clock		= Master_Clock/15	; 3579478
FM_Sample_Rate		= M68000_Clock/(6*6*4)	; 53267
PSG_Sample_Rate		= Z80_Clock/16		; 223721
; ---------------------------------------------------------------------------
; https://www.plutiedev.com/ym2612-registers
; TODO: utilize
fmreg:
.lfofreq	equ $22		; global
.tmrAfreqmsb	equ $24		; global
.tmrAfreqlsb	equ $25		; global
.tmrBfreq	equ $26		; global
.ch3mdtmr	equ $27		; global
.key		equ $28		; global
.dacout		equ $2A		; global
.dacen		equ $2B		; global
.test		equ $2C		; global 
.muldt		equ $30		; per-operator
.tl		equ $40		; per-operator
.arrs		equ $50		; per-operator
.dramen		equ $60		; per-operator
.sr		equ $70		; per-operator
.rrsl		equ $80		; per-operator
.ssgeg		equ $90		; per-operator
.freqlsb	equ $A0		; per-channel
.freqmsb	equ $A4		; per-channel
.algofeed	equ $B0		; per-channel
.panamspms	equ $B4		; per-channel
.freqch3lsb1	equ $A8		; per-operator
.freqch3lsb2	equ $A9		; per-operator
.freqch3lsb3	equ $AA		; per-operator
.freqch3lsb4	equ $A2		; per-operator
.freqch3msb1	equ $AD		; per-operator
.freqch3msb2	equ $AE		; per-operator
.freqch3msb3	equ $AF		; per-operator
.freqch3msb4	equ $A6		; per-operator
; ---------------------------------------------------------------------------
vdpdata		equ $C00000
vdpctrl		equ $C00004
	if (__smpsTarget=="md68k")||(__smpsTarget=="mdz80")||(__smpsTarget=="fuckFM")
psginput	equ $C00011
	if __smpsTarget<>"fuckFM"
ymstat		equ $A04000
yma0		equ $A04000
ymd0		equ $A04001
yma1		equ $A04002
ymd1		equ $A04003
z80ram		equ $A00000
z80busreq	equ $A11100
	endif
; MegaSD/MDPlus
MSD_OverlaySignature	equ $3F7F6	; reads 'BATE' if overlay port was successful
MSD_OverlayPort		equ $3F7FA	; write $CD54 to enable MegaSD control
MSD_ResultPort		equ $3F7FC
MSD_CommandPort		equ $3F7FE
MSD_ParameterData	equ $3F800	; data from the ARM cpu
MSD_ParameterEnd	equ $40000
MSD_OverlayValue	equ $CD54

msd_comm_playonce	equ $11		; play a song
msd_comm_playloop	equ $12		; play a song and loop it when it's done
msd_comm_pause		equ $13		; 1.04 uses parameter for a fadeout
msd_comm_resume		equ $14		;
msd_comm_volume		equ $15		; 0 is mute, 0xFF is max
msd_comm_status		equ $16		; 1.04 ; 0 = no song playing, 1 = song playing

; MegaCD
CdBootRom:      equ $400000   ; Main-CPU boot ROM
CdPrgRam:       equ $420000   ; PRG-RAM window
CdWordRam:      equ $600000   ; WORD-RAM window

CdSubCtrl:	equ $A12000  ; Sub-CPU reset/busreq, etc.
CdMemCtrl:	equ $A12002  ; Mega CD memory mode, bank, etc.

CdCommMain1:	equ $A12010  ; Main-CPU to Sub-CPU port #1
CdCommMain2:	equ $A12012  ; Main-CPU to Sub-CPU port #2
CdCommMain3:	equ $A12014  ; Main-CPU to Sub-CPU port #3
CdCommMain4:	equ $A12016  ; Main-CPU to Sub-CPU port #4
CdCommMain5:	equ $A12018  ; Main-CPU to Sub-CPU port #5
CdCommMain6:	equ $A1201A  ; Main-CPU to Sub-CPU port #6
CdCommMain7:	equ $A1201C  ; Main-CPU to Sub-CPU port #7
CdCommMain8:	equ $A1201E  ; Main-CPU to Sub-CPU port #8

CdCommSub1:	equ $A12020  ; Sub-CPU to Main-CPU port #1
CdCommSub2:	equ $A12022  ; Sub-CPU to Main-CPU port #2
CdCommSub3:	equ $A12024  ; Sub-CPU to Main-CPU port #3
CdCommSub4:	equ $A12026  ; Sub-CPU to Main-CPU port #4
CdCommSub5:	equ $A12028  ; Sub-CPU to Main-CPU port #5
CdCommSub6:	equ $A1202A  ; Sub-CPU to Main-CPU port #6
CdCommSub7:	equ $A1202C  ; Sub-CPU to Main-CPU port #7
CdCommSub8:	equ $A1202E  ; Sub-CPU to Main-CPU port #8
	elseif __smpsTarget=="sys14"
ymstat		equ $840101
yma0		equ $840101
ymd0		equ $840103
yma1		equ $840105
ymd1		equ $840107
	elseif __smpsTarget=="pico"
psginput	equ $C00011
adpcmdata	equ $800010		; reads return how many free bytes their are in the FIFO, writes add to the FIFO
adpcmctrl	equ $800012		; 
	elseif __smpsTarget=="copera"
psginput	equ $C00011
adpcmdata	equ $800010		; reads return how many free bytes their are in the FIFO, writes add to the FIFO
adpcmctrl	equ $800012		; 
; (no Copera games write to stat, but it should work based on the YMZ263B datasheet)
ymz263B_stat	equ $BFF801		; u8 ; YMZ263B Status read/address write
ymz263B_ch1data	equ $BFF803		; u8 ; YMZ263B Channel #1 data
ymz263B_addr	equ $BFF805		; u8 ; YMZ263B Address write
ymz263B_ch2data	equ $BFF807		; u8 ; YMZ263B Channel #2 data

ymf262_stat	equ $BFF824
ymf262_addr1	equ $BFF824		; u  ; YMF262 Address Part #1 write/Status read
ymf262_data	equ $BFF828		; u  ; YMF262 Data write
ymf262_addr2	equ $BFF834		; u  ; YMF262 Address Part #2 write

ym712B		equ $BFF840		; u8 ; YM712B write
	else
		fatal "Unknown hardware target"
	endif

SMPS_stopZ80 macro
	move.w	#$100,(z80busreq).l
	endm
SMPS_waitZ80 macro
$$w:	btst	#0,(z80busreq).l
	bne.s	$$w
	endm
SMPS_startZ80 macro
	move.w	#0,(z80busreq).l
	endm
SMPS_kdebugtext macro
	if __smpsDebug
	nop
	endif
	endm

SMPS_assert macro
	if __smpsDebug
		if ARGCOUNT==0
		bra.w	RenderAssert
		else
		bsr.w	RenderAssert		; 0(sp) = *+4
		SMPS_assertascii ALLARGS
		even
		endif
	else
		illegal
	endif
	endm
SMPS_assertascii macro thing1,thing2
	if __smpsDebug
		dc.b thing1
		if ARGCOUNT<>1
		shift
		SMPS_assertascii ALLARGS
		else
		dc.b 0		; terminator
		endif
	endif
	endm
; ---------------------------------------------------------------------------
	phase 0
drvdata:
.bgmcnt:	ds.w 1
.sfxcnt:	ds.w 1
.pcmcnt:	ds.w 1
.version:	ds.w 1
.bgm:		ds.w 1
.sfx:		ds.w 1
.uvbfm:		ds.w 1
.uvbvol:	ds.w 1
.uvbmod:	ds.w 1
.uvbpan:	ds.w 1
.uvbdac:	ds.w 1
.fmdrum:	ds.w 1
.psgdrum:	ds.w 1
.pcmdrum:	ds.w 1
	dephase
; ---------------------------------------------------------------------------
	phase 0
TrackPlaybackControl:		ds.b 1			; All	; word writes include TrackVoiceControl
_resting	= 0
_sfxoverride	= 1
_special	= 2	; FM3 multi/PSG3 Noise
_holdnotes	= 3
_noattack	= 4
_drummode	= 5
_nomuffle	= 6
_playing	= 7	; bpl/bmi

TrackVoiceControl:		ds.b 1			; All	; expected to be 1
; YM1 = $00-$02
; YM2 = $04-$06
; PCM = $40-$5F
; PSGsquare = $80/$A0/$C0
; PSGnoise  = $E0-$E7

TrackTempoDivider:		ds.b 1			; All
TrackStackPointer:		ds.b 1			; All
	if __smpsSeqTimeSize
TrackDurationTimeout:		ds.w 1			; All
TrackSavedDuration:		ds.w 1			; All
	else
TrackDurationTimeout:		ds.b 1			; All
TrackSavedDuration:		ds.b 1			; All
	endif

TrackFreq:			ds.w 1			; FM/PSG	; sign bit indicates rest ; TODO: change to 0 for MCD PCM support
TrackTranspose:			ds.b 1			; All		; pitch ; word writes include TrackVolume
TrackVolume:			ds.b 1			; All
TrackDetune:			ds.b 1			; FM/PSG
TrackAMSFMSPan:			ds.b 1			; FM/DAC

TrackVolEnvIndex:		;ds.b 1			; All
TrackVolEnvPtr:			ds.l 1			; All
TrackVolEnvCtrl:		;ds.b 1			; All
TrackDataPointer:		ds.l 1			; All

TrackNoteTimeout:		ds.b 1			; All
TrackNoteTimeoutMaster:		ds.b 1			; All

	if __smpsPanEnv
TrackPanSavedDelay:		;ds.b 1			; FM/PCM
TrackPanEnvPtr:			ds.l 1			; FM/PCM
TrackPanCtrl:			ds.b 1			; FM/PCM ; IIII ITTT ; T is the panning type, I is the animation ID
TrackPanIndex:			ds.b 1			; FM/PCM
TrackPanEndIndex:		ds.b 1			; FM/PCM
TrackPanDelay:			ds.b 1			; FM/PCM
	endif

; loop indexes start upward, subroutine calls extend downward
TrackGoSubStackEnd:		ds.b 0			; All
TrackLoopCounters:		ds.b __smpsSeqStack 	; All
TrackGoSubStack:		ds.b 0
TrackUniSz:			ds.b 0
	dephase

	phase TrackUniSz
TrackSavedDAC:			ds.b 1			; DAC
			ds.b (*)&1
TrackDacSz:			ds.b 0
	dephase

	phase TrackUniSz
			ds.b (*)&1
; bit 7 enables calculated mod, bit 6 is reserved for modulation type flag
; other bits are the mod envelope index
TrackModulationCtrl:		;ds.b 1			; FM/PSG
TrackModulationPtr:		ds.l 1			; FM/PSG
TrackModulationWait:		ds.b 1			; FM/PSG
TrackModulationSpeed:		ds.b 1			; FM/PSG
TrackModulationDelta:		ds.b 1			; FM/PSG
TrackModulationSteps:		ds.b 1			; FM/PSG
TrackModulationVal:		ds.w 1			; FM/PSG
	if __smpsModEnv
TrackModEnvIndex:		;ds.b 1			; FM/PSG
TrackModEnvPtr:			ds.l 1			; FM/PSG
;TrackModEnvMultiply:		ds.b 1			; FM/PSG
	endif
	if __smpsPortamento
TrackPortamentoFreq:		ds.w 1			; FM/PSG
TrackPortamentoTime:		ds.b 1			; FM/PSG
	endif
	if (*)&1
TrackFmOperators:		ds.b 1			; FM
	endif
TrackPsgSz:			ds.b 0

TrackFmVoiceIndex:		;ds.b 1			; FM
TrackFmVoicePtr:		ds.l 1			; FM
	ifndef TrackFmOperators
TrackFmOperators:		ds.b 1			; FM
	endif
			ds.b (*)&1
TrackFmSz:			ds.b 0
	dephase


	phase 0
v_startofram:			ds.b 0

v_driverflags:			;ds.b 1
.pal				equ 7	; must be 7
.firecore			equ 6
.mono				equ 5
.ssgoff				equ 4
.paused				equ 3	; must be 3
.dopause			equ 2	; must be 2
.speedsong			equ 1
.jingle				equ 0

v_dataptr:			ds.l 1

v_driverflags2:			ds.b 1
.muffle				equ 7	; must be 7
.mdplus				equ 0	; corresponds with bitfield in smps-init
.mcd				equ 1	; ^
.mars				equ 2	; ^	; because 32x isn't a valid label and x32 is cringe

v_communication:		ds.b __smpsCommBytes	; generally used for syncing gameplay with music
v_communication_end:
v_pcmsfx:			ds.b 1

	ds.b (*)&1	; word-alignment
v_soundqueue_start:		ds.b 0
v_soundqueue0:			ds.w 1
v_soundqueue1:			ds.w 1
v_soundqueue2:			ds.w 1
v_soundqueue_end:		ds.b 0
v_random:			ds.w 1

	ds.b (*)&1	; word-alignment
v_startofvariables:		ds.b 0
v_sndprio:			ds.b 1	; sound priority
v_paltimer:			ds.b 1
; (priority of new music/SFX must be higher or equal to this value or it won't play
; bit 7 of priority being set prevents this value from changing)
v_fadeout_counter:		ds.b 1
v_fadein_counter:		ds.b 1	; Timer for fade in
v_revving_pitch:		ds.b 1
v_revving_timer:		ds.b 1
v_contsfx_lastid:		ds.w 1
v_contsfx_loop:			ds.b 1

v_lastpsg4:			ds.b 1
	ds.b (*)&1	; word-alignment
	if __smpsJingle
v_1up_save_ram:			ds.b 0
	endif
v_main_tempo_timeout:		ds.w 1
v_main_tempo:			ds.w 1

v_music_track_ram:		ds.b 0
v_music_pcm_tracks:		ds.b 0
v_music_pcm1_track:		ds.b TrackDacSz
v_music_pcm_tracks_end:		ds.b 0

v_music_fm_tracks:		ds.b 0
v_music_fm1_track:		ds.b TrackFmSz
v_music_fm2_track:		ds.b TrackFmSz
v_music_fm3_track:		ds.b TrackFmSz
v_music_fm4_track:		ds.b TrackFmSz
v_music_fm5_track:		ds.b TrackFmSz
v_music_fm6_track:		ds.b TrackFmSz
v_music_fm_tracks_end:		ds.b 0

v_music_psg_tracks:		ds.b 0
v_music_psg1_track:		ds.b TrackPsgSz
v_music_psg2_track:		ds.b TrackPsgSz
v_music_psg3_track:		ds.b TrackPsgSz
v_music_psg4_track:		ds.b TrackPsgSz
v_music_psg_tracks_end:		ds.b 0
v_music_track_ram_end:		ds.b 0

v_music_fm3_multifreq:		ds.w 3*(__smpsFM3Multi<>0)
	if __smpsJingle
v_1up_save_ram_end:		ds.b 0

v_1up_ram_copy:			ds.b 0
	endif
v_sfx_track_ram:		ds.b 0
v_sfx_fm_tracks:		ds.b 0
v_sfx_fm3_track:		ds.b TrackFmSz
v_sfx_fm4_track:		ds.b TrackFmSz
v_sfx_fm5_track:		ds.b TrackFmSz
v_sfx_fm_tracks_end:		ds.b 0

v_sfx_psg_tracks:		ds.b 0
v_sfx_psg1_track:		ds.b TrackPsgSz
v_sfx_psg2_track:		ds.b TrackPsgSz
v_sfx_psg3_track:		ds.b TrackPsgSz
v_sfx_psg_tracks_end:		ds.b 0
v_sfx_track_ram_end:		ds.b 0
v_sfx_fm3_multifreq:		ds.w 3*(__smpsFM3Multi<>0)

	if __smpsBSFX
v_bsfx_track_ram:		ds.b 0
v_bsfx_fm_tracks:		ds.b 0
v_bsfx_fm4_track:		ds.b TrackFmSz
v_bsfx_fm_tracks_end:		ds.b 0
v_bsfx_psg_tracks:		ds.b 0
v_bsfx_psg3_track:		ds.b TrackPsgSz
v_bsfx_psg_tracks_end:		ds.b 0
v_bsfx_track_ram_end:		ds.b 0
;v_bsfx_fm3_multifreq:		ds.w 3*(__smpsFM3Multi<>0)
	endif

	if __smpsJingle
v_1up_ram_copy_overlap:
				ds.b (v_1up_save_ram_end-v_1up_save_ram)-(v_1up_ram_copy_overlap-v_1up_ram_copy)
v_1up_ram_copy_end:		ds.b 0
	endif
v_endofvariables:
v_endofram:
	dephase