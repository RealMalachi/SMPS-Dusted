# How the API works
SMPS-Dusted 68K is primarily provided as a binary blob, akin to many homebrew drivers nowadays.
```
SMPS_DriverCode:	incbin "smps-drv.bin"
SMPS_InitDriver		equ SMPS_DriverCode+SMPS_Offset_InitDriver
SMPS_RunDriver		equ SMPS_DriverCode+SMPS_Offset_RunDriver
SMPS_QueueSound		equ SMPS_DriverCode+SMPS_Offset_QueueSound
SMPS_UpdateFIFO		equ SMPS_DriverCode+SMPS_Offset_UpdateFIFO
SMPS_ReadComm		equ SMPS_DriverCode+SMPS_Offset_ReadComm
SMPS_WriteComm		equ SMPS_DriverCode+SMPS_Offset_WriteComm
SMPS_GuardDriver	equ SMPS_DriverCode+SMPS_Offset_GuardDriver
SMPS_UnguardDriver	equ SMPS_DriverCode+SMPS_Offset_UnguardDriver
SMPS_SetupPianoRoll	equ SMPS_DriverCode+SMPS_Offset_SetupPianoRoll
SMPS_PlayCDDA		equ SMPS_DriverCode+SMPS_Offset_PlayCDDA
SMPS_PauseDriver	equ SMPS_DriverCode+SMPS_Offset_PauseDriver
SMPS_ResumeDriver	equ SMPS_DriverCode+SMPS_Offset_ResumeDriver
SMPS_SetBgmTempo	equ SMPS_DriverCode+SMPS_Offset_SetBgmTempo
SMPS_SetBgmSpeed	equ SMPS_DriverCode+SMPS_Offset_SetBgmSpeed
SMPS_Signature		equ SMPS_DriverCode+SMPS_Offset_Signature
```
A generated definitions file provides the offsets for various routines prefixed with `SMPS_Offset_`; said routines are the topic of this document.

## InitDriver
input:
- a0 = driver data
- a1 = driver ram
- d0.l = desired external hardware bitfield
output
- d0.l = enabled/acknowledged external hardware bitfield
trashes: d0-d7,a0-a6

description:
Initialises driver ram and sound hardware

Both the input and output of d0 share a bitfield, corresponding to additional/different sound hardware from the base target
- The input denotes what hardware the game wants the driver to check for and utilise
- The output communicates what the driver could find
- Many of the bits are unmapped and may be used in the future, these should be avoided for forward-compatibility; input should initialise them as 0, output should ignore them
- Any bits that aren't used by the drivers target hardware (pico bits for md, etc) should also be avoided
```
........ ........ ......MC ....FXDP
P = (MD) MDplus
    - Adds CDDA support
D = (MD) MegaCD
    - Adds CDDA and PCM support
X = (MD) 32X
    - Adds PWM support
F = (MD) Firecore
    - Adds compatibility
C = (Pico) Yamaha Copera
    - Adds FM (YMF262) and PCM support
M = (Pico) MegaPico
    - Adds FM and PCM (YM2612) support
```

example:
```
	lea	(SMPS_DriverData).l,a0
	lea	(v_soundram).w,a1
	moveq	#0,d0
	jsr	(SMPS_InitDriver).l
```

## RunDriver
input:
- a1 = driver ram

trashes: d0-d7,a0-a6

description:
Plays back sound sequences, expected to be called at the end of v-int.
Can survive h-int and ex-int, aside for assert errors.

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_RunDriver).l
```

## QueueSound
input:
- a1 = driver ram
- d0.w = id

description:
This is the subroutine which you funnel ID-based sound commands through: music, sound effect, pcm and various commands.
Note that it uses word-sized IDs, compared to SMPS' usual byte-sized.

example:
```
	move.w	#sndid,d0
	lea	(v_soundram).w,a1
	jsr	(SMPS_QueueSound).l
```

## UpdateFIFO
input:
- a1 = driver ram

trashes: ?

description:
While relevant for the Pico/32X/arcades, this will cause an assert on the base Mega Drive as a warning that you're wasting performance.

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_UpdateFIFO).l
```

## ReadComm
input:
- a1 = driver ram
- d1.b = array index

output:
- d0.b = communicated byte

trashes: d1

description:
Reads a byte within an array that both the driver and the game have access to. The size of the array depends on the `__smpsCommBytes` setting

example:
```
	lea	(v_soundram).w,a1
	moveq	#0,d1
	jsr	(SMPS_ReadComm).l
	; do whatever you want with d0.b
```

## WriteComm
input:
- a1 = driver ram
- d0.b = communicating byte
- d1.b = array index

trashes: d1

description:
Writes a byte within an array that both the driver and the game have access to. The size of the array depends on the `__smpsCommBytes` setting

example:
```
	moveq	#0,d0
	lea	(v_soundram).w,a1
	moveq	#0,d1
	jsr	(SMPS_WriteComm).l
```

## GuardDriver
input:
- a1 = driver ram

trashes: ?

description:
Enables driver hardware protections if applicable.

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_GuardDriver).l
```

## UnguardDriver
input:
- a1 = driver ram

trashes: ?

description:
Disables driver hardware protections if applicable.

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_UnguardDriver).l
```

## SetupPianoRoll
input:
- a0 = piano ram
- a1 = driver ram

trashes: d0-a6

description:
Updates a ram buffer with data that can be used to render a sound test screen. The buffer size is defined as `smpspianoramsize` within the generated def files.

example:
```
; ram allocation
v_pianoram:		rs.b smpspianoramsize
...
; api call
	lea	(v_pianoram).w,a0
	lea	(v_soundram).w,a1
	jsr	(SMPS_SetupPianoRoll).l
```

## RunMiscCommand
input:
- a1 = driver ram
- d0.w = command
- other inputs depend on the command

trashes: ?

description:
Handle smaller and less common commands that didn't deserve their own dedicated API call

| command id | description | parameters |
| - | - | - |
| 0 | PauseDriver | N/A |
| 1 | ResumeDriver | N/A |
| 2 | SetBgmTempo | d1.w = new tempo |

example:
```
	lea	(v_soundram).w,a1
	moveq	#2,d0			; SetBgmTempo
	move.w	#$8000,d1
	jsr	(SMPS_InitDriver).l
```

## PauseDriver
input:
- a1 = driver ram

description: Pauses the sound driver

## ResumeDriver
input:
- a1 = driver ram

description: Resumes the sound driver after a pause

## SetBgmTempo
input:
- a1 = driver ram
- d0.w = new tempo

description: Sets the bgms internal tempo to a new value

## SetBgmSpeed
input:
- a1 = driver ram
- d0.b = new speed

description:
Sets a timer to update the bgm twice every X frames. Unlike S3K, setting it to 1 is valid.

note for drv68K: NTSC uses the timer directly, whereas PAL uses a LUT

## Signature
description:
A zero-terminated ASCII string, serves as a signature for the driver
