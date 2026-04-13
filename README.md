# SMPS-Dusted
Enhanced SMPS driver with a focus on convenience and scalability

Features:
- Driver code and sound data are address-independant binary blobs by default
- Driver code can have multiple sets of sound data
- Clean(ish) code design emphasising a lack of hard-coding where possible
- Native AtGames Firecore support
- Massive reduction in stack pointer fuckery
- Greater control over sample playback
- Support for both universal and per-sequence FM patches/instruments, volume envelopes and modulation envelopes
- Support for various BGM tempo algorithms
- SSG-EG provided by FM patches/instruments
- Extensive error handling in debug driver builds

Excludes:
- Sonic hard-coded ring panning
- Sonic 1 hard-coded block pushing sound flag
- Sonic 2 hard-coded CPZ chemical balls play/not-play flag
- Sonic 2 hard-coded spindash pitch increase (a non hard-coded method from Sonic 3 is provided)

Todo:
- Sonic 1 (ASM68K and AS) installs
- Built-in support for DualPCM, DualClown and other custom players
- More communication bytes
- Expose relative ram locations on the user side (communication bytes, queue ids, etc)
- MCD support, PCM and CDDA
- MD+ support
- Negative volume envelopes
- Independant PSG4
- FM drum layout
- Panning animations/envelopes
- FM3 multi-channel and CSM mode
- LFO

## Tools
- [flamewings asl macro assembler fork](https://github.com/flamewing/asl-releases), labelled as asw for... some reason
- [clownacys p2bin](https://github.com/Clownacy/p2bin)
- [sjasmplus](https://github.com/z00m128/sjasmplus)
- [clownlzss](https://github.com/NaotoNTP/clownlzss)

## Special Thanks
| person | thing |
| - | - |
| Alex Field | Disassembling Sonic 2 Simon Wai |
| Devon | Disassembling Sonic CD |
| Flamewing | Disassembling/compiling Sonic 3D Blasts OST, asl |
| Clownacy | Clone Driver, "Dual-Clown", p2bin, clownlzss |
| Undying-Star | Flicky sounds |
| Tomatowave | Beta testing |

## Legal notice
Usage of this sound driver is only endorsed for non-commercial use.

Even if a large majority of it was rewritten or replaced, the core of this driver was written 30+ years ago as part of SEGAs development SDKs. As a result, the copyright for this project is murky at best. I cannot stop you from using it commercially, nor is SEGA likely to care after so long, but in the unlikely event that they do care, you've been warned. There are better homebrew drivers out there, anyway.
