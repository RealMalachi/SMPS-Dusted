# SMPS-Dusted
Enhanced SMPS driver with convenience upfront

Features
- Driver code and sound data are binary blobs by default
- Driver code can have multiple sets of sound data
- Clean-ish code design that emphasises a lack of hard-coding where possible
- Native AtGames Firecore support
- Massive reduction in stack pointer fuckery
- FM Universal Voice Bank
- Per-song Volume Envolope Bank
- SMPS-Z80 BGM tempo
- SSG-EG provided by FM instruments
- Extensive error handling

Excludes
- Sonic hard-coded ring panning
- Sonic 1 hard-coded block pushing sound flag
- Sonic 2 hard-coded CPZ chemical balls play/not-play flag
- Sonic 2 hard-coded spindash pitch increase (a non hard-coded method from Sonic 3 is provided)
