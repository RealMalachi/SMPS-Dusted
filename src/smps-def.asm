; defined during assembler call
;__smpsDebug	equ 0
__smpsDataVer	equ 0

; "fuckFM" is MD without FM
; "sys14" is 2xYM2203 (unimplemented)
; "pico" is Pico (unimplemented)
; "copera" is Copera (unimplemented)
; "mdgen" is YM2612/SN76-blah blah
__smpsTarget	equ "mdgen"
__smpsPCM	equ "MegaPCM2"
__smpsJingle	equ 1
__smpsBFX	equ 1
__smpsModEnv	equ 1
__smpsPanEnv	equ 0
; picoADPCM
; coperaADPCM
	if (__smpsPCM=="null") || (__smpsTarget=="fuckFM")
	include "src/null/smps-pcm-def.asm"
;	elseif __smpsPCM=="DirtyPCM"
;	include "src/dirtypcm/smps-pcm-def.asm"
	elseif __smpsPCM=="MegaPCM1"
	include "src/mpcm1/smps-pcm-def.asm"
	elseif __smpsPCM=="MegaPCM2"
	include "src/mpcm2/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualPCM"
;	include "src/dualpcm/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualPCM-FlexEd"
;	include "src/dualpcm-flexed/smps-pcm-def.asm"
;	elseif __smpsPCM=="DualClown"
;	include "src/dualclown/smps-pcm-def.asm"
	else
	fatal "Unknown PCM type"
	endif
; ---------------------------------------------------------------------------
; NTSC 53693175
; PAL: 53203424
Master_Clock		= 53693175
M68000_Clock		= Master_Clock/7	; 7670453
Z80_Clock		= Master_Clock/15	; 3579478
FM_Sample_Rate		= M68000_Clock/(6*6*4)	; 53267
PSG_Sample_Rate		= Z80_Clock/16		; 223721
; ---------------------------------------------------------------------------
vdpdata		equ $C00000
vdpctrl		equ $C00004
	if __smpsTarget=="mdgen"
ymstat		equ $A04000
yma0		equ $A04000
ymd0		equ $A04001
yma1		equ $A04002
ymd1		equ $A04003
psginput	equ $C00011
smpsZ80RAM	equ $A00000
	elseif __smpsTarget=="fuckFM"
psginput	equ $C00011
	elseif __smpsTarget=="sys14"
ymstat		equ $840101
yma0		equ $840101
ymd0		equ $840103
yma1		equ $840105
ymd1		equ $840107
	elseif __smpsTarget=="pico"
psginput	equ $C00011
; [1cct dddd]
; T = Type (of data), 0 for tone/noise, 1 for volume
; C = Channel, 0 for channel 1, 1 for channel 2 etc
; D = Data, 10-bit value for tone, 4-bit value for volume
; [0.DD DDDD]
; D = Data, this write isn't necessary for volume (the lower 4 bits overwrite the already provided volume)
; Data types
; Tone:   DDDDDDdddd = cccccccccc
; Noise:  (DDDDDD)dddd = (---trr)-trr
; Volume: (DDDDDD)dddd = (--vvvv)vvvv
smps_adpcmdata	equ $800010
; reads return how much bytes are free in FIFO
; writes add bytes into the FIFO
smps_adpcmctrl	equ $800012
; reads [B... .... .... ....]
; B = BUSY status, 1 if the chip currently playing a sample
; write [RI.. ?... FF.. .VVV]
; R = Write 1 to reset
; I = Interrupt enable. Level 3 interrupts will trigger based on FIFO fullness when set, or not when clear
; ? = Sega driver always sets this bit outside of reset, but some games expect ADPCM to work with it clear.
; F = Low-pass filter selection, 11 = 16 kHz, 10 = 12 kHz, 01 = 6 kHz, 00 = ??
; V = Volume
	elseif __smpsTarget=="copera"
smps_ymz263B_stat	equ $BFF801	; u8 ; YMZ263B Status read/address write (no Copera games write to this address, but it should work based on the YMZ263B datasheet)
smps_ymz263B_ch1_data	equ $BFF803	; u8 ; YMZ263B Channel #1 data
smps_ymz263B_addr	equ $BFF805	; u8 ; YMZ263B Address write
smps_ymz263B_ch2_data	equ $BFF807	; u8 ; YMZ263B Channel #2 data

smps_ymf262_stat	equ $BFF824
smps_ymf262_addr1	equ $BFF824	; u  ; YMF262 Address Part #1 write/Status read
smps_ymf262_data	equ $BFF828	; u  ; YMF262 Data write
smps_ymf262_addr2	equ $BFF834	; u  ; YMF262 Address Part #2 write

smps_ym712B		equ $BFF840	; u8 ; YM712B write
	else
	fatal "Unknown hardware target"
	endif

SMPS_stopZ80 macro
	move.w	#$100,($A11100).l
	endm
SMPS_waitZ80 macro
.w:	btst	#0,($A11100).l
	bne.s	.w
	endm
SMPS_startZ80 macro
	move.w	#0,($A11100).l
	endm
SMPS_kdebugtext macro
	if __smpsDebug=1
	nop
	endif
	endm

smpsren_vram_null	= 0
smpsren_vram_plane	= $100
smpsren_vram_length	= $200

SMPS_assert macro
	if __smpsDebug
		if ARGCOUNT==0
		bra.w	RenderAssert
		else
		pea	.t(pc)
		bra.w	RenderAssert
.t:		dc.b ALLARGS,0
		even
		endif
	else
	illegal
	endif
	endm
SMPS_assertascii macro
	dc.b ALLARGS,0
	endm

; VDP/DMA
; makes a VDP command
vdpComm function addr,type,(((type)&3)<<30)|((addr&$3FFF)<<16)|(((type)&$FC)<<2)|((addr&$C000)>>14)
; makes a VDP address difference
vdpCommDelta function addr,((addr&$3FFF)<<16)|((addr&$C000)>>14)

; function to calculate the location of a tile in plane mappings
planeLoc function width,col,line,(((width*line)+col)*2)

; simplication of the VDP memory access flags
; in truth, bit 5 is DMA and bit 4 is a VRAM to VRAM DMA flag
REG_WRITE	= %000010

VRAM_READ	= %000000
VRAM_WRITE	= %000001
VRAM_DMA	= %100001
VRAM_READ8	= %001100	; 8bit half reads, useful for reading with 128kb vram
VRAM_COPYDMA	= %110001	; VRAM to VRAM DMA

CRAM_READ	= %001000
CRAM_WRITE	= %000011
CRAM_DMA	= %100011
CRAM_COPYDMA	= %110011	; CRAM to CRAM DMA

VSRAM_READ	= %000100
VSRAM_WRITE	= %000101
VSRAM_DMA	= %100101
VSRAM_COPYDMA	= %110101	; VSRAM to VSRAM DMA
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
.uvbdac:	ds.l 1
	dephase
; ---------------------------------------------------------------------------
	phase 0
TrackPlaybackControl:		ds.b 1			; All	; word writes include TrackVoiceControl
_resting	= 0
_sfxoverride	= 1
_special	= 2	; FM3 multi/PSG3 Noise 
_holdnotes	= 3
_noattack	= 4
_nouservol	= 6
_playing	= 7	; bpl/bmi

TrackVoiceControl:		ds.b 1			; All	; expected to be 1
; YM1 = $00-$02
; YM2 = $04-$06
; PCM = $40-$5F
; PSGsquare = $80/$A0/$C0
; PSGnoise  = $E0-$E7

TrackTempoDivider:		ds.b 1			; All
TrackStackPointer:		ds.b 1			; All
TrackDurationTimeout:		ds.b 1			; All
TrackSavedDuration:		ds.b 1			; All

TrackSavedDAC:			;ds.w 1			; DAC
TrackFreq:			ds.w 1			; FM/PSG
TrackTranspose:			ds.b 1			; FM/PSG	; pitch ; word writes include TrackVolume
TrackVolume:			ds.b 1			; All
TrackDetune:			ds.b 1			; FM/PSG
TrackAMSFMSPan:			ds.b 1			; FM/DAC

TrackVolEnvIndex:		;ds.b 1			; All
TrackVolEnvPtr:			ds.l 1			; All
TrackVolEnvCtrl:		;ds.b 1			; All
TrackDataPointer:		ds.l 1			; All

TrackNoteTimeout:		ds.b 1			; All
TrackNoteTimeoutMaster:		ds.b 1			; All

; loop indexes start upward, subroutine calls extend downward
TrackGoSubStackEnd:		;ds.b 0			; All
TrackLoopCounters:		ds.b 12 		; All
TrackGoSubStack:		;ds.b 0
TrackDacSz:			;ds.b 0

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
TrackPsgSz:			;ds.b 0

TrackFmVoiceIndex:		;ds.b 1			; FM
TrackFmVoicePtr:		ds.l 1			; FM
TrackFmSz:			;ds.b 0
	dephase

	phase 0
v_startofram:			ds.b 0

v_driverflags:			;ds.b 1	; RFMS PPSU
; TODO: proper bitfield labels
; R = Refresh rate flag, 0 = 60hz, 1 = 50hz
; F = Firecore flag, achieves better sound quality on the AtGames Firecore
; M = Mono, 0 = Stereo, 1 = Mono
; S = SSG-EG, 0 enables it, 1 disables it. Disabled by default on AtGames
; P = pause flag, 0 = play, 1 = pausing, 2 = paused, 3 = resuming
; S = Speedup
; U = 1-up playing
v_dataptr:			ds.l 1

v_driverflags2:			ds.b 1	; W... ....
; TODO: proper bitfield labels
; W = water muffle, 0 = no muffle, 1 = muffle

v_communication_byte:		ds.b 1	; generally used for syncing gameplay with music

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

	ds.b (*)&1	; word-alignment
v_1up_save_ram:			ds.b 0
v_main_tempo_timeout:		ds.w 1
v_main_tempo:			ds.w 1

v_music_track_ram:		ds.b 0
v_music_dac_tracks:		ds.b 0
v_music_dac1_track:		ds.b TrackDacSz
v_music_dac_tracks_end:		ds.b 0

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
v_music_psg_tracks_end:		ds.b 0
v_music_track_ram_end:		ds.b 0
v_1up_save_ram_end:		ds.b 0

	if __smpsJingle=1
v_1up_ram_copy:
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

	if __smpsBFX=1
v_spcsfx_track_ram:		ds.b 0
v_spcsfx_fm_tracks:		ds.b 0
v_spcsfx_fm4_track:		ds.b TrackFmSz
v_spcsfx_fm_tracks_end:		ds.b 0
v_spcsfx_psg_tracks:		ds.b 0
v_spcsfx_psg3_track:		ds.b TrackPsgSz
v_spcsfx_psg_tracks_end:	ds.b 0
v_spcsfx_track_ram_end:		ds.b 0
	endif

	if __smpsJingle=1
v_1up_ram_copy_overlap:		ds.b (v_1up_save_ram_end-v_1up_save_ram)-(v_1up_ram_copy_overlap-v_1up_ram_copy)
v_1up_ram_copy_end:		ds.b 0
	endif
v_endofvariables:
v_endofram:
	dephase