# smps-dusted
Enhanced SMPS driver with convenience upfront

Features
- Full compatibility with smps2asm
- System 14 (YM2203) build flag
- AtGames Firecore support
- Support for entire driver being a binary blob
- Massive reduction in stack pointer fuckery
- FM Universal Voice Bank
- PSG per-song Envolope Bank
- Reorganised SMPS commands list
- SMPS-Z80 BGM tempo
- SSG-EG provided by instruments
- Sonic song fade-ins
- Sonic SFX pitch increase (spindash rev)
- 7-bit PSG and PCM volume (truncated to the usual 4-bit when sent to the psg) (yes this was taken from clonedriver)
- Extensive error handling

Excludes
- Sonic ring panning
- Sonic 1 pushing flag
- Sonic 2 alternating play/not-play flag for CPZ chemical balls
- Sonic hard-coded SFX pitch increase