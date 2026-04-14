# smps minutia guide

## description and goal
This document aims to cover the minute details and issues with SMPS, particularly ones that may cause problems with SMPS-Dusted and its attempts to evolve

## smps sonic variants
SMPS has a lengthy history of per-company and per-game variants, such as smps-treasure, sonic 2, milpo, along with the various sega consoles it's been adapted to and there specific requirements.

SMPS-Dusted supports the following Sonic-exclusive features:
- 1UP jingles and subsequent fade-in
- Continuous pitch increasing (spindash) via sequence flag

SMPS-Dusted doesn't support the following Sonic-exclusive features:
- Ring panning sound id hijack
- CPZ gloop play/dontplay
- Continuous pitch increasing (spindash) via hard-coded ID

These features can be easily emulated within the game itself

## main data
| type | data | description |
| - | - | - |
| reserved | $00 | reserved for smps-dusted, invalid time for smps-68k and smps-z80 |
| time | $01-$7F | amount of time that the note or rest takes |
| rest | $80 | mutes the channel until next note |
| note | $81-$DF | note that corresponds to a frequency |
| flag | $E0-$FF | commands that don't fall under any of the other data, such as volume, voices, modulation, loops, even hold |

sequence data is organised as follows: flag,note/rest,time
```
        smpsDetune  $00                             ; detune next note
        dc.b        nBb4,$18                        ; play note for time
        dc.b        $0C                             ; play previous note for new time
        dc.b        nBb4,nB4                        ; play new note for previous time, then play another new note for that same time
        smpsDetune  $01                             ; detune next note
        dc.b        $18                             ; play previous note detuned, for new time
        smpsDetune  $FF                             ; detune next note
        dc.b        nBb4,nB4,$08                    ; play new note detuned for previous time, then play another new note for new time
        dc.b        nBb7,nRst                       ; play new note for previous time, then rest for previous time
```

time is multiplied by the tempo "divider" then ANDed by $FF
```
        smpsChanTempoDiv $02                        ; this sequence results in ($40x$02)&$FF = $80
		dc.b        nRst,$40
        smpsChanTempoDiv $04                        ; this sequence results in ($40x$04)&$FF = $00
		dc.b        nRst,$40
        smpsChanTempoDiv $00                        ; this sequence results in ($40x$00)&$FF = $00
		dc.b        nRst,$40
```
Debug builds of SMPS-Dusted will throw an error when the multiplication is $00 or exceeds $FF

### drum mode
drum mode is a feature that's semi-exclusive to SMPS-Dusted

drum mode replaces notes with a macro format intended to be used for drums, at the cost of flexibility
```
; note mode:
		smpsPcmVoice pKick
		dc.b        dC4,$18
		smpsPcmVoice pSnare
		dc.b        dC4,$18
; drum mode
		dc.b        dKick,$18,dSnare,$18
```
FM, PSG and PCM have separate drum macros and parameters.

YM2612 PCM drum mode logic is inverted, in that it defaults to drum mode by default and enabling driver support for drum mode allows it to run in non-drum mode

## automatic sound updaters

### timeout
| data | smps-68k | smps-z80 | smps-dusted |
|:-|:-:|:-:|:-:|
| channels | FM/PSG | FM/PSG | All |
| time algorithm | per-tick | tick x tempodiv & FFh | per-tick or tick x tempodiv & FFh |

Note timeouts (or perhaps a better name would be note cuts) are a timer that that rests the note. The timer is reset for every non-held note

So instead of doing this:
``` 
	dc.b nC0,$04,nRst,$0C
	dc.b nC0,$04,nRst,$0C
	dc.b nC0,$04,nRst,$0C
	dc.b nC0,$04,nRst,$0C
```
You can do this:
```
    smpsNoteTimeout $04
	dc.b nC0,$10
	dc.b nC0,$10
	dc.b nC0,$10
	dc.b nC0,$10
```
In smps-dusted with PCM rest logic set to hold standard rests, this also serves as an alternative to add rests

### volenv
| data | smps-68k | smps-z80 | smps-dusted |
|:-|:-:|:-:|:-:|
| channels | PSG only | FM/PSG | All |
| volenv range | $00-$7F, $81-$FF | $00-$7F, $84-$FF | $00-$7F |
| PSG internal volume | $00-$0F | $00-$0F | $00-$7F |
| volume cap | nope | nope | $00-$7F |
| HOLD | yep($80) | yep($81) | yep |
| REPEAT/REST | nope | yep($80) | yep |
| INDEX | nope | yep($82) | yep |
| RESET | nope | yep($83) | yep |

SMPS-Dusted currently lacks support for negative volume envelopes. If they were to be added, it should cap to the maximum volume on overflow.

PSG volume being internally consistent with FM means that they can be more easily shared. Songs that had to separate FM and PSG volume envelopes no longer have to, but songs that relied on FM and PSG being given the same thing and acting differently will have to fix their sequences; this usually only happens for broken or poorly planned out sequences.

### modenv
| data | smps-68k | smps-z80 | smps-dusted |
|:-|:-:|:-:|:-:|
| channels | FM/PSG | FM/PSG | FM/PSG |
| s8 modenv | yep | yep | yep |
| s12 modenv | nope | nope | yep |
| s16 modenv | nope | nope | yep |
| REPEAT/REST | nop | yep | yep |
| HOLD | yep | yep | yep |
| INDEX | yep | yep | yep |
| RESET | yep | yep | yep |
| MUL | yep($86); mod x mul | yep($86); mod x ((mul+1)&FFh) | nope |

SMPS-Dusted lacks support for s8 modenv multipliers, but adds support for s12 and s16 to make up for it. Realistically speaking you'll only need s12.

### modalgo
| smps-68k | smps-z80 | smps-dusted |
|:-:|:-:|:-:|
| yep;todo | yep;todo | yep;can select between either of the aforementioned |
Sonic 2s modalgo is slightly different in that it runs when the sequence updates, like smps-z80 but unlike smps-68k. It's otherwise identical to smps-68k

### pananim
| smps-68k | smps-z80 | smps-dusted |
|:-:|:-:|:-:|
| yep;todo | nope | nope |

## stack
Each channel has stack ram, which is primarily used by smpsLoop and smpsCall.
- Stock SMPS variants have 12 bytes of stack
- Sonic 2 has 10 bytes of stack
- SMPS-Dusted is adjustable, usually given 12 or 10 bytes of stack

smpsLoop uses one byte of stack for a loop index. You can reference any byte in the stack or even go out of bounds, but you'll usually want to use the first few bytes of stack.

smpsCall uses either 4(68K), 2(Z80,S2) or 3(dusted) bytes of stack, for a pointer to after the call command for when the call is done. The driver handles allocating these automatically, starting from the end of the stack growing upwards.
- The MSB in a smps-68k pointer is technically useless as the 68000 uses a 24-bit address bus. You can squeeze three loops in index 0/4/8 for call layers 3/2/1 respectively, but it's not recommended

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
- on smps-68k, rests hold the dac, but it's common for driver variants to make them rest the dac
- on smps-z80, rests hold the dac
- on smps-dusted, rest logic depends on a driver flag

there's two main ways to emulate holds for rests when rests are enabled:
1. don't use rests, simply increase the time the pcm is played
2. (smps-dusted exclusive) use holds or an indefinite hold
```
; sequences like this:
        dc.b dKick,$02,nRst,nRst,dSnare,dKick
; need to be changed to this:
        dc.b dKick,$06,dSnare,$02,dKick
; or this (smps-dusted exclusive):
        dc.b dKick,$02,smpsNoAttack,nRst,smpsNoAttack,nRst,dSnare,dKick    ; syntax 1
        dc.b dKick,$02,smpsHoldNote,nRst,smpsHoldNote,nRst,dSnare,dKick    ; syntax 2
; or this (very smps-dusted exclusive):
        smpsHoldNotes
        dc.b dKick,$02,nRst,nRst,dSnare,dKick
        smpsReleaseNotes
```
