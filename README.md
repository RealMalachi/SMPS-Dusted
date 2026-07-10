# SMPS-Dusted
Enhanced [SMPS sound driver](https://hiddenpalace.org/News/Sega_of_Japan_Sound_Documents_and_Source_Code) with a focus on convenience and scalability

Features:
- Driver code and sound data are address-independant binary blobs by default
- Clean(ish) code design emphasising a lack of hard-coding where possible
- Native AtGames Firecore support
- Massive reduction in stack pointer fuckery
- Greater control over sample playback
- Support for both universal and per-sequence FM patches/instruments, volume envelopes and modulation envelopes
- Support for various BGM tempo algorithms
- SSG-EG and LFO provided by FM patches/instruments
- Portamento support
- Independant PSG4 channels
- Drum modes for PSG
- Extensive error handling in debug driver builds

Excludes:
- Sonic hard-coded ring panning
- Sonic 1 hard-coded block pushing sound flag
- Sonic 2 hard-coded CPZ chemical balls play/not-play flag
- Sonic 2 hard-coded spindash pitch increase (a non hard-coded method from Sonic 3 is provided)

## Bundled tools
- [flamewings asl macro assembler fork](https://github.com/flamewing/asl-releases), labelled as asw for... some reason
- [clownacys p2bin](https://github.com/Clownacy/p2bin)
- [sjasmplus](https://github.com/z00m128/sjasmplus)
- [ZX0 salvador](https://github.com/emmanuel-marty/salvador)

## Related tools
- [smps2asm](https://forums.sonicretro.org/threads/smps2asm-and-improved-s-k-driver.26876)
- [smpsopt](https://sonicresearch.org/community/index.php?threads/smps-optimizer.3001)
- [vgm2smps](https://sonicresearch.org/community/index.php?threads/vgm2smps.5561)
- [vgm2mid](https://vgmrips.net/wiki/Vgm2mid)
- [mid2smps](https://forums.sonicretro.org/threads/mid2smps.25337)
- [xm4smps](https://info.sonicretro.org/Xm4smps)
- [furnace smps export](https://github.com/Pr0jectFM/furnace-smps-export)

## Special Thanks
| person | thing |
| - | - |
| Alex Field | Disassembling Sonic 2 Simon Wai |
| Devon | Disassembling Sonic CD |
| Flamewing | Disassembling/compiling Sonic 3D Blasts OST, asl |
| Clownacy | Clone Driver V2, p2bin |
| Undying-Star | Flicky sounds |
| Tomatowave | Beta testing |

## Legal notice
Usage of this sound driver is only endorsed for non-commercial use.

Even if a large majority of it was rewritten or replaced, the core of this driver was written 30+ years ago as part of SEGAs development SDKs. As a result, the copyright for this project is murky at best. I cannot stop you from using it commercially, nor is SEGA likely to care after so long, but in the unlikely event that they do care, you've been warned. There are better homebrew drivers out there, anyway.
