;__smpsDebug		equ 0		; defined during assembler call
__smpsDataVer		equ 3		; if these don't match between the driver and sound data, it complains
__smpsTarget		equ "md68k"	; read below
__smpsPCM		equ "MegaPCM2"	; read below
__smpsWarnDisabledUsage	equ __smpsDebug	; 0 ignores or circumvents disabled features, 1 triggers an assert
__smpsSeqStack		equ 10		; defines the amount of stack given for each sequence channel, ideally an even number
__smpsCommBytes		equ 8		; defines the amount of driver communication bytes

__smpsDefaultFreq	equ 0		; 0 maxes PSG and mutes the others, 1 mutes all
__smpsRestTimeTime	equ 1		; 0 will crash, 1 will act like SMPS-68K
__smpsRestPCM		equ 0		; 0 holds (including when the track stops), 1 rests
__smpsFMTable		equ 0		; 0 is SMPS-68K, 1 is SMPS-Z80
__smpsJingle		equ 1		; 1 enables jingles that restore the prior song when done
__smpsBSFX		equ 1		; 1 enables background sound effect, the layer in between bgm and sfx
__smpsModEnv		equ 1		; 1 enables modulation envelopes
__smpsPanEnv		equ 1		; 1 enables panning envelopes
__smpsFM3Multi		equ 0		; (TODO) 1 enables FM3 multifrequency mode
__smpsDrum		equ 1		; 1 enables YMPCM notes and FM/PSG macros (primarily used for drums)
__smpsPortamento	equ 1		; 1 enables portamento

__smpsRevFreq		equ 0		; 1 reverses the frequency table, 2 reverses some other stuff on top of that. Why? Shits and giggles.
; __smpsTarget values:
; "md68k"		| 68K driver + Z80 PCM player
; "mdz80"		| (TODO) Z80 driver + 68K API
; "fuckFM"		| 68K driver with FM disabled
; "sys14"		| (TODO) 68K driver for 2xYM2203 System 14s
; "pico"		| (TODO) 68K driver for Sega Pico
; "copera"		| (TODO) 68K driver for Yamaha Copera
; "mpico68k"		| (TODO) 68K driver for MegaPico hardware mods https://youtu.be/xWsJlW3UeXM
; "mpicoz80"		| (TODO) Z80 driver for MegaPico hardware mods https://youtu.be/xWsJlW3UeXM

; __smpsPCM values: (these only apply to md68k)
; "null"		| Nothing
; "MegaPCM1"		| (WIP) MegaPCM v1.1 by vladikcomper
; "MegaPCM2"		| MegaPCM v2.0 by vladikcomper
; "MegaPCM2-1"		| (TODO) MegaPCM v2.1 by vladikcomper
; "DualPCM"		| (TODO) The first public version of the 2-channel software mixer by MarkeyJester
; "DualPCM-FlexEd"	| (TODO) What most people call DualPCM is the second version, also by MarkeyJester
; "DualClown"		| (TODO) The custom 2-channel software mixer from CloneDriver v2.8 by CLownacy
; "Sonar"		| (TOOD) DPCM driver by Nat
; "VDPCM"		| (TOOD) Custom PCM format by Malachi; Legal name:`Variance Differencial Pulse Code Modulation`
