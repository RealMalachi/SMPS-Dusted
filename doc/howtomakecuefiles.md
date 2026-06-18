# how to make cue file

## Music format
Converting it to 44.1KHz signed 16-bit WAV files should do the trick

## Cue file
```
FILE "file.wav" WAVE
  TRACK 01 AUDIO
    INDEX 01 00:00:00
	REM COMMENT "example for thing below"
```
MegaSD v1.04 checks for optional metadata within `REM`s. These will overwrite whatever playback settings you use in-game
```
REM NOLOOP
REM LOOP
REM LOOP xxxxx
REM COMMENT "xxxxx"
```
Loop points are based on CDDA frames (75fps)

For Audacity, this can be seen by clicking on the right arrow on most of the timers, which shows a variety of timing types.

Select "CDDA Frames", and figure out the loop point you desire relative to CDDA frame timing.
