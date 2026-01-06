# smps minutia guide

## description and goal
This document aims to cover SMPS in its entirety, in relation to my enhanced versions of the drivers, smps-dusted 68k and smps-dusted z80


## smps sonic variants
smps has a lengthy history of per-company and per-game variants, such as smps-treasure or smps-sonic2
All the Sonic games have a fairly notable addition thanks to the 1UP jingle
Sonic 2 and 3 also introduced driver-based continuous pitch increases for the spindash. If the sound is queued again before 60 frames pass by, every subsequent playback increases the pitch by 1, with the increase capped at 12. Sonic 2 hard-coded it to the spindash id, Sonic 3 and smps-dusted makes it a sequence command

## main data
note:
rest:
time:
flag: control flags are commands that don't fall under any of the other data, such as volume, voices, modulation, loops, 

## stack
each channel has 12 individual bytes of stack, which is primarily used by smpsLoop and smpsCall.
smpsLoop uses one byte of stack for a loop index. You can reference byte in the stack or even go out of bounds, but you'll usually use start from the start of stack
smpsCall uses either 4(68k), 2(Z80,S2) or 3(dusted;68k,Z80) bytes of stack, for a pointer to after the call command for when the call is done. The driver handles allocating these automatically, starting from the end of the stack

For 68000 drivers (and what I'd recommend for all drivers for simplicity sake) is either using 4 loops and 2 calls, or no loops and 3 calls
For Z80 drivers, this allows 4 loops and 4 calls, 2 loops and 5 calls, or 6 calls
For dusted drivers, this allows 6 loops and 2 calls, or 3 loops and 3 calls

## misc oddities

smps-z80 and smps-dusted can switch between psg3 and psg noise on the fly via giving the smpsPSGform paremeter a 0
smps-z80 mutes psgnoise when switching to psg3
smps-dusted mutes psg3 when switching to psgnoise, then mutes psgnoise when switching to psg3


note nB7 (0xE0) and nBs7 (0xE1) cannot be played without detuning, due to commands starting at 0xE0, thus overriding them... aside for on Clone Driver, where commands start at 0xFE.

note-rest-time-time acts oddly on smps-z80
on smps-68k, the note plays for the last saved time, rest occurs for the new time, next time also rests. this is the de-facto standard.
on smps-z80, the note plays for the last saved time, rest occurs for the new time, next time plays the previous note
smps-dusted follows smps-68k logic

## smps-dusted features
smps-dusted supports additional features that no others possess

binary blob intergration: all versions of smps-dusted can be provided in a binary blob
Independant psg noise: If you define four channels for PSG, the fourth is PSG noise. By default it uses 

### 68000 and Z80 differences
68000 is timed via V-int, Z80 is timed for Timer B
68000 sfxs are always tied to the frame rate, Z80 sfxs are tied to Timer B
68000 is designed for its PCM player to be easy to swap out, Z80 is not as simple
68000 requires a set amount of 68000 ram, Z80 doesn't require any 68000 ram
68000 eats a ton of 68000 CPU time
68000 has a ton of assertions and safety checks togglable via the smpsDebug flag

68000 is designed for debugging and flexibility
Z80 is designed for performance


# background music
There are two flags that background music (bgm) can have
PAL slow: This tells the driver to not adjust the music speed for PAL, useful for songs tied to the events which depend on the games framerate (sonic's drowning)
Previous fade-in: This tells the driver to store the previously playing bgm (that doesn't also set this flag) into sfx ram, disables all sfx, then fade in the previous track when the song is done. This is a sonic game specific feature.

# sound effects
standard sound effects (sfx) is what you'd expect, they take unconditional priority over bgm channels.
By default, FM3,FM4,FM5,PSG1,PSG2 and PSG3/Noise are valid sfx channels

there are two additional flags :

background sound effects (bsfx), otherwise known as special sound effects (ssfx) take a lower priority to shared sfx channels
By default, FM4 and PSG3/Noise are valid bsfx channels

continuous sound effects (csfx) are sound effects that if queued multiple times, will loop until it stops being queued
Two different csfx being queued will clobber the previously played one, but sfx and bsfx will not
