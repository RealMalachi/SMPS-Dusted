# How the API works
SMPS Dusted-68K is primarily provided in a binary blob, akin to many homebrew drivers nowadays. At the start of the blob is a LUT for every subroutine the user should have immediate access to.

## InitDriver
relative address: +0
input:
- a1 = driver ram
- d0.w = driver ram size
trashes:
- d0-d7,a0-a6
description:
initialises ram and sound hardware
if the game doesn't allocate enough ram for the sound driver, it'll assert an illegal instruction. If the blob has __smpsDebug enabled, it'll print out a kdebug warning

## RunDriver
relative address: +4
input:
- a1 = driver ram
trashes:
- d0-d7,a0-a6
description:
plays back sound sequences, expected to be called at the end of v-int
can survive h-int and ex-int, sans the kdebug warnings when __smpsDebug is enabled

## QueueSound
relative address: +8
input:
- a1 = driver ram
- d0.w = id
description:
This is the subroutine which you funnel ID-based sound commands through, songs/sfxs/commands
Note that it uses word-sized IDs

## UpdateFIFO
relative address: +12
description:
While relevant for the Pico/32X/arcades, this will cause an assert on the base Mega Drive as a warning that you're wasting performance.

## ReadComm
relative address: +16
input:
- a1 = driver ram
- d0.b = communication byte

## WriteComm
relative address: +20
input:
- a1 = driver ram
output:
- d0.b = communication byte

## PauseDriver
relative address: +24
input:
- a1 = driver ram

## ResumeDriver
relative address: +28
input:
- a1 = driver ram