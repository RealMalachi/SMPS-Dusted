;__smpsDebug		equ 0		; defined during assembler call
__smpsDataVer		equ 2
__smpsTarget		equ "md68k"	; read below
__smpsPCM		equ "MegaPCM2"	; read below
__smpsRestPCM		equ 1		; 0 holds (including when the track stops), 1 rests
__smpsJingle		equ 1
__smpsBFX		equ 1
__smpsModEnv		equ 1
__smpsPanEnv		equ 0
__smpsDrum		equ 0
__smpsSeqStack		equ 10
__smpsCommBytes		equ 8
; __smpsTarget values:
; "md68k"		| 68K driver + Z80 PCM player
; "mdz80"		| (TODO) Z80 driver + 68K API (unimplemented)
; "fuckFM"		| 68K driver with FM disabled
; "sys14"		| (TODO) 68K driver for 2xYM2203 System 14s
; "pico"		| (TODO) 68K driver for Sega Pico
; "copera"		| (TODO) 68K driver for Yamaha Copera
; "mpico68k"		| (TODO) 68K driver for MegaPico hardware mods https://youtu.be/xWsJlW3UeXM
; "mpicoz80"		| (TODO) Z80 driver for MegaPico hardware mods https://youtu.be/xWsJlW3UeXM

; __smpsPCM values: (these only apply to md68k)
; "null"		| Nothing
; "MegaPCM1"		| MegaPCM v1.1
; "MegaPCM2"		| MegaPCM v2.0
; "DualPCM"		| (TODO) The first public version of the 2-channel software mixer by MarkeyJester
; "DualPCM-FlexEd"	| (TODO) What most people call DualPCM is actually this, the second version
; "DualClown"		| (TODO) The custom 2-channel software mixer from CloneDriver v2.8
; "Sonar"		| (TOOD) DPCM driver by Nat
