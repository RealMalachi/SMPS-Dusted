# How the API works
SMPS-Dusted 68K is primarily provided in a binary blob, akin to many homebrew drivers nowadays.

At the start of the blob is a LUT for subroutines and data that the user should have immediate access to.

## InitDriver
relative address: +0

input:
- a1 = driver ram
- d0.w = driver ram size

trashes: d0-d7,a0-a6

description:
Initialises ram and sound hardware

example:
```
	lea	(SMPS_DriverData).l,a0
	lea	(v_soundram).w,a1
	jsr	(SMPS_InitDriver).l
```

## RunDriver
relative address: +4

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
relative address: +8

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
relative address: +12

input:
- a1 = driver ram

description:
While relevant for the Pico/32X/arcades, this will cause an assert on the base Mega Drive as a warning that you're wasting performance.

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_UpdateFIFO).l
```

## ReadComm
relative address: +16

input:
- a1 = driver ram

output:
- d0.b = communication byte

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_ReadComm).l
	; do whatever you want with d0.b
```

## WriteComm
relative address: +20

input:
- a1 = driver ram
- d0.b = communication byte

example:
```
	moveq	#0,d0
	lea	(v_soundram).w,a1
	jsr	(SMPS_WriteComm).l
```

## PauseDriver
relative address: +24

input:
- a1 = driver ram

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_PauseDriver).l
```

## ResumeDriver
relative address: +28

input:
- a1 = driver ram

example:
```
	lea	(v_soundram).w,a1
	jsr	(SMPS_ResumeDriver).l
```

## SetupPianoRoll
relative address: +32

input:
- a0 = piano ram
- a1 = driver ram

trashes: d0-a6

description:

example:
```
	lea	(v_pianoram).w,a0
	lea	(v_soundram).w,a1
	jsr	(SMPS_SetupPianoRoll).l
```

## SetDriverDataPointer
relative address: +36

input:
- a0 = driver data address
- a1 = driver ram

description:
Changes the driver data pointer which is otherwise setup during InitDriver

example:
```
	lea	(SMPS_DriverData).l,a0
	lea	(v_soundram).w,a1
	jsr	(SMPS_InitDriver).l
```
