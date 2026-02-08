# smps-dusted v1.0 specifications



sequences contain resting times, notes, and control flags.
| $00     | reserved (invalid time in stock smps) |
| $01-$7F | note/rest time |
| $80     | rest |
| $81-$DF | note |
| $E0-$FF | control flags |

sequence data is organised as follows: flag,note,time
```
        smpsDetune  $00                             ; detune next note
        dc.b        nBb4,$18                        ; play note for time
        dc.b        $18                             ; play previous note for new time
        dc.b        nBb4,nBb4                       ; play new note for previous time, then play another new note for that same time
        smpsDetune  $01                             ; detune next note
        dc.b        $18                             ; play previous note detuned, for new time
        smpsDetune  $FF                             ; detune next note
        dc.b        nBb4,nBb4,$08                   ; play new note detuned for previous time, then play another new note for new time
```

rest-time-time causes problems
```
        dc.b        nRst,$7F,$7F,$1D                ; only works on smps-68K
        dc.b        nRst,$7F,nRst,nRst,$1D          ; works on all
```
note-time-rest-rest causes problems on smps-z80
```
        dc.b        nC0,$08,nRst,nRst               ; second rest will play previous note on smps-z80
```

# Control Flags

## smpsCommunicate
Set driver-to-gameplay communication byte, this helps sync gameplay related sequences to music

## smpsJump, smpsStop
smpsJump is used for infinite loops, smpsStop is used for one-time loops

## smpsCall, smpsReturn
In Motorola 68000 terms, these are essentially `bsr` and `rts` respectively.


Channel stack
Each channel is given 12 bytes of stack which is shared with the loop counters, each call is worth 4 bytes of stack on 68000 drivers.
Loops extend upwards (0,1,2,etc), Calls extend downwards (12,11,10,etc)
As a general rule of thumb, I would suggest sticking to two calls and four loops, if there are no loops then you can do three calls

## smpsLoop, smpsConditionalJump
smpsLoop is given an index (which loop counter to use), a timer to initiate that index with and count down, and a pointer to where loops begin
```
.outer
        dc.b        nBb4, $18
.inner
        dc.b        smpsHoldNote, nBb4
        smpsLoop 1,12,.inner
        smpsLoop 0,12,.outer
```

## smpsSetLoop (unimplemented)
smpsSetLoop initiates a loop index timer independantly from smpsLoop or smpsConditionalJump.
This allows calls to loops to have different loop timers
```
; Call
        dc.b nB2, 4
        smpsSetLoop 0,14
        smpsCall LoopIndexExample
        smpsDetune 1
        smpsSetLoop 0,28
        smpsCall LoopIndexExample
        smpsStop
LoopIndexExample:
        dc.b nB2
        smpsLoop 0,1,LoopIndexExample       ; default loop time is 1, this goes unused.
        smpsReturn

; Jump
        dc.b nB2, 4
LoopIndexExample:
        dc.b nB2
        smpsLoop 0,8,LoopIndexExample        ; default loop time is 8, this gets used for the songs intro
        ...
        smpsSetLoop 0,14                     ; all subsequent loops use 14
        smpsJump LoopIndexExample

; Conditional
Song_PSG1:
        smpsSetLoop 0,0
        smpsJump Song_PSG12

Song_PSG2:
        smpsSetLoop 0,1

Song_PSG12:
        ...
        smpsConditionalJump 0,Song_PSG12_2special
        ...                ; only do this for PSG1
Song_PSG12_2special:
        ...
```

## smpsStop, smpsStopFM, smpsStopSpecial
Stops the channel

smpsStopFM additionalls mutes the channel entirely if it's FM
smpsStopSpecial is the equivalent of smpsStop for background sound effects

## Sound control

## smpsSetVol, smpsFMSetVol, smpsPSGSetVol
Sets the channel volume. Volume is 7-bit, 0 is loudest, 7F or more is silent
smpsSetVol will add the volume to any channel, whereas smpsFMSetVol and smpsPSGSetVol will only apply to channels of those respective sound chips
All PSG equivalents will left shift the volume by 3 bits, due to PSGs initially using a 4-bit volume system

## smpsAddVol, smpsFMAddVol, smpsPSGAddVol
Backcompat label: smpsAlterVol, smpsFMAlterVol, smpsPSGAlterVol
Compared to smpsSetVol, smpsAddVol/smpsAlterVol will add to the current volume. Negative numbers subtract the volume.

## smpsDetune
Sets detune. Detune is a signed 8-bit value applied to the frequency.
```
        smpsDetune $05
        dc.b        nC0        ; FM base frequency is 0x0284, detune adds 0x05, result is 0x0289
```

## smpsModSet, smpsModOn, smpsModOff
smpsModSet will enable modulation and setup its parameters
smpsModOn will enable modulation without setting up parameters. This is usually used for when modulation was already setup and disabled
smpsModOff will disable modulation
Modulation is applied to the frequency, much like smpsDetune
```
        smpsModSet 0,0,0,0
        dc.b        nC0
```

## smpsModChg, smpsModChg2
smpsModChg 
smpsModChg2 has two parameters, first is for FM, second is for PSG. If sequence data is shared between FM and PSG channels, this will apply different mod values

7 6 5 4 3 2 1 0
| | | < < < < <
| | | Modulation envelope ID (0 for disabled, all other values serve as IDs)
| | Modulation algorithm type (0 for 68000, 1 for Z80)
| Modulation algorithm enabled (0 for off, 1 for one)

## smpsSetTranspose
This sets the channels pitch, which is added to the current note
```
        smpsSetTranspose $01
        dc.b        nC0        ; the next note after nC0 is nCs0
```

## smpsSetNote
Compared to smpsSetTranspose, the value is... pre-subtracted by 0x40. I don't know man.

## smpsAddTranspose
Backcompat label: smpsChangeTransposition, smpsAlterPitch
Compared to smpsSetTranspose, this adds to the current transpose

## smpsRandPitch
This sets a random pitch between two parameters, `to` and `from`
```
        smpsRandPitch -12,12        ; set random pitch between -12 and 12
        dc.b        nC2        ; from nC1 to nC3
```

## smpsPan
Sets panning, retains saved LFO. LFO doesn't apply to PCM, none of this applies to PSG.
Due to a poor design decision on SMPS' developers part, whatever smpsPan defined for LFO gets logically OR'ed to the previous with no regard for what used to be there.
Due to a poor design decision on smps2asms end, LFO has to be defined for every use of smpsPan, despite defining LFO via smpsPan being bad practice, making all pannings have a seemingly random 0 defined all the time. So you mess with that zero, it does nothing until given a value exceeding 0x3F where it then fucks with the panning, because the values are ADDED together. I don't like this at all, but can't do anything about it.

## smpsPanCenter, smpsPanCentre, smpsPanLeft, smpsPanRight
Shortcuts to common panning settings from smpsPan
smpsPanCentre pans directly to the center
smpsPanLeft   pans directly to the left
smpsPanRight  pans directly to the right

## smpsPanAuto (unimplemented)

## smpsFMvoice
Backcompat label: smpsSetvoice
This sets the FM voice. The value of the voice depends on the voice table, which is either a custom one defined in the sequences header, or the Universal Voice Bank.

## smpsPSGvoice
This sets the PSG voice. PSGs also have a UVB

## smpsPSGform
This sets the noise waveform for PSG Noise. Valid values are 0 (sets channel to PSG3) or between $E0-$E7 (sets channel to PSG noise with those settings)

## smpsHoldNote
Backcompat label: smpsNoAttack
Notably, this smps2asm command isn't a macro, but rather a constant. This means it's included in a dc.b alongside the notes and timer
```
        dc.b        smpsHoldNote, nBb4, $18
        smpsDetune $10
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $1B
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $1C
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $14
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $05
        dc.b        nBb4, $01
```

## smpsHoldNotes, smpsReleaseNotes
Compared to smpsHoldNote, this holds multiple notes without specifying them individually. Useful for songs that hold consecutive notes for extended periods of time, or SFXs that always hold
When using smpsHoldNote while smpsHoldNotes is active, it releases the note.
```
Before:
        dc.b        smpsHoldNote, nBb4, $18
        smpsDetune $10
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $1B
        dc.b        nBb4, $01
        smpsDetune $1C
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $14
        dc.b        smpsHoldNote, nBb4, $01
        smpsDetune $05
        dc.b        nBb4, $01

After:
        smpsHoldNotes
        dc.b        nBb4, $18
        smpsDetune $10
        dc.b        nBb4, $01
        smpsDetune $1B
        dc.b        smpsHoldNote, nBb4, $01                ; release note
        smpsDetune $1C
        dc.b        nBb4, $01
        smpsDetune $14
        dc.b        nBb4, $01
        smpsReleaseNotes
        smpsDetune $05
        dc.b        nBb4, $01
```

## Misc

## smpsFMICommand, smpsFMIICommand, smpsChanFMCommand
smpsFMICommand    write an arbitrary value to YmA0. It does not care if the channel is overwritten by a SFX or SSFX
smpsFMIICommand   write an arbitrary value to YmA1. It does not care if the channel is overwritten by a SFX or SSFX
smpsChanFMCommand write an arbitrary value to the FM channel. If the channel is overwritten by a SFX or SSFX, it does not do the write

## smpsRevUp
Backcompat label: smpsSpindashRev
smpsRevUp increases the channels pitch, starting from 0 and ending at 12
When not constantly updated, the current rev pitch dissipates in 60 frames; 1s NTSC, 1.2s PAL

## smpsRevAddCurr
smpsRevAddCurr adds the current rev pitch to the channel, without adding to or initiating the rev.
If a sound effect has two channels effected by rev, only the first should use smpsRevUp and the others should use smpsRevAddCurr

## smpsRevReset
Backcompat label: smpsSpindashReset
smpsRevReset will reset the rev pitch