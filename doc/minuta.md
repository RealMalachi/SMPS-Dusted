# smps minutia guide

## description and goal
This document aims to cover the minute details and issues with SMPS, particularly ones that may cause problems with SMPS-Dusted and its attempts to evolve

## smps sonic variants
SMPS has a lengthy history of per-company and per-game variants, such as smps-treasure, sonic 2, milpo, along with all the sega consoles it's been adapted to.

All the Sonic games have a notable addition in the 1UP jingle and subsequent fade-in.

Sonic 2 and 3 also introduced driver-based continuous pitch increases for the spindash.
If the sound is queued again before 60 frames pass by, every subsequent playback increases the pitch by 1 with a cap of 12.
Sonic 2 hard-coded it to the spindash id, Sonic 3 and smps-dusted makes it a sequence command.

Other sonic-specific features can be emulated in the game itself, namely the ring panning.

## main data
| type | data | description |
| - | - | - |
| reserved | $00 | reserved for smps-dusted, invalid time for smps-68k and smps-z80 |
| time | $01-$7F | amount of time that the note or rest takes |
| rest | $80 | mutes the channel until next note |
| note | $81-$DF | note that corresponds to a frequency or sample |
| flag | $E0-$FF | commands that don't fall under any of the other data, such as volume, voices, modulation, loops, even hold |

sequence data is organised as follows: flag,note/rest,time
```
        smpsDetune  $00                             ; detune next note
        dc.b        nBb4,$18                        ; play note for time
        dc.b        $18                             ; play previous note for new time
        dc.b        nBb4,nBb4                       ; play new note for previous time, then play another new note for that same time
        smpsDetune  $01                             ; detune next note
        dc.b        $18                             ; play previous note detuned, for new time
        smpsDetune  $FF                             ; detune next note
        dc.b        nBb4,nBb4,$08                   ; play new note detuned for previous time, then play another new note for new time
        dc.b        nBs7,nRst                       ; play new note for previous time, then rest for previous time
```

## stack
Each channel has 12 individual bytes of stack, which is primarily used by smpsLoop and smpsCall.
smpsLoop uses one byte of stack for a loop index. You can reference any byte in the stack or even go out of bounds, but you'll usually use the first few bytes of stack.
smpsCall uses either 4(68K), 2(Z80,S2) or 3(dusted) bytes of stack, for a pointer to after the call command for when the call is done. The driver handles allocating these automatically, starting from the end of the stack.
- For smps-68K, this allows either using 4 loops and 2 calls, or no loops and 3 calls. You can squeeze three loops in index 0,4,8 for call layers 3,2,1 respectively, but it's not recommended
- For smps-Z80, this allows 4 loops and 4 calls, 2 loops and 5 calls, or 6 calls
- For smps-dusted, this allows 6 loops and 2 calls, or 3 loops and 3 calls

I'd recommend following smps-68K logic for simplicity sake, except for the loop squeezing, don't do that, ever.

## misc oddities

### PSG3 switching
smps-z80 and smps-dusted can switch between psg3 and psg noise on the fly via giving the smpsPSGform paremeter a 0
smps-z80 mutes psgnoise when switching to psg3
smps-dusted mutes psg3 when switching to psgnoise, then mutes psgnoise when switching to psg3

### inaccessible notes
notes nB7 (0xE0) and nBs7 (0xE1) cannot be played without detuning, due to commands starting at 0xE0, thus overriding them... aside for on Clone Driver, where commands start at 0xFE.

### default channel frequency/sample
When initialized channels have default value for their frequency/sample, which is exposed by not setting the note
- smps-68K and smps-z80 defaults frequencies to 0 (mute for FM, max for PSG)
- smps-dusted defaults all frequencies to muted

### rest-time-time
- on smps-68k, the first rest and time rests, next time also rests.
- on smps-z80, the first rest and time rests, next time plays the last frequency/sample
- smps-dusted follows smps-68k logic
```
; sequences like this:
        dc.b nG2, $08, nRst, $04, $24
; need to be changed to this (from Z80):
        dc.b nG2, $08, nRst, $04, nG2, $24
; or this (from 68K):
        dc.b nG2, $08, nRst, $04, nRst, $24
```

### rest on PCM
- on smps-68k it doesn't stop the dac, but it's common to see drivers add that feature
- on smps-z80 it doesn't stop the dac
- on smps-dusted it stops the dac

There's two main ways to emulate not stopping on smps-dusted:
1. don't use rests, simply increase the time the pcm is played
2. use holds or an indefinite hold
```
; sequences like this:
        dc.b dKick,$02,nRst,nRst,dSnare,dKick
; need to be changed to this:
        dc.b dKick,$06,dSnare,$02,dKick
; or this:
        dc.b dKick,$02,smpsNoAttack,nRst,smpsNoAttack,nRst,dSnare,dKick    ; syntax 1
        dc.b dKick,$02,smpsHoldNote,nRst,smpsHoldNote,nRst,dSnare,dKick    ; syntax 2
; or this:
        smpsHoldNotes
        dc.b dKick,$02,nRst,nRst,dSnare,dKick
        smpsReleaseNotes
```
