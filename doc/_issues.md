# Complete refactor
Make all the code original and better able to take FM and Z80 wait times into account, do things in parallel where possible
Examples: AMPS, mdsdrv

# Flesh out visual asserts
It's currently just an ASCII printer

# Allow for greater control with driver blob data
Saving all the absolute addresses for the blobs offset pointers could allow for more flexibility
Let's say you only want to change the PCM table, while some pcm drivers can support it, for full compatibility right now you'd need to have a copy of all the sound data

# Ability to mix-match between universal and specific instrument/effects data
This could allow songs to use both simultaneously

# Ability to save and restore BGMs
In the current specs you can only do that for SFX-preventing jingles, but what about enterring then exitting a battle scenario like in an RPG? Having the music continue where it left off is an amazing QOL feature we take for granted nowadays, but it takes up more RAM then I'm comfortable allocating
A potential workaround would be having multiple driver rams, when in the overworld use one, in battles use another, when going back into the overworld setup a fade into the previous song

# Ability to change bgm panning arbitrarily
(The Goosic enemy from Undertale Yellow)[https://youtu.be/WQahzamXHo0&t=5600] demonstrates a gameplay use for force panning music to a certain direction
Centre panning already exists but it applies to all sound playback, ideally this effect would only apply to bgm

# Pre-calculated FM voice water muffle
The driver currently applies dynamically by checking the FM algorithm. Pre-calculating it into the FM voices (still basing the default pre-calc on algo) could allow for user controlled muffling, at least on the FM side. It'd also make FM voices faster, since it could be aligned to 32 bytes, an easy id<<5

# User-controller pitch and music tempo
Many sonic hack sound tests have this features, namely Sonic Megamix and the default AMPS sound test.
(Paprium)[https://youtu.be/gRoLiznZxtU&t=566] demonstrates a practical application for pitch increases
Tempo could be a complication with the added flags

# Sound channel enable/disable flags
(Super Mario World)[https://youtu.be/v_KsonqcMv0&t=39] with its Yoshi drums
(Paprium)[https://youtu.be/gRoLiznZxtU&t=892] with its Saxman

# Music echo effect
(Super Mario World)[https://youtu.be/v_KsonqcMv0&t=91] with its SFX in caves

# Music wobble effect
(Paprium)[https://youtu.be/TcnW4iLTK-k&t=812] with its low health effect

# LFO support
Self-explanatory, add smps-source's LFO control flags

# PCM pitching in the sample table
Particularly useful for drivers that play at a consistent rate but support fractional addition/subtraction like DualPCM
Recent github has a factional thing that could serve as a solid base for this:
```
	dac_sample_metadata SndDAC_Timpani,			; 85h
	dac_sample_metadata SndDAC_Tom,				; 86h
	dac_sample_metadata SndDAC_Bongo,			; 87h
	dac_sample_metadata SndDAC_Timpani, 1.30	; 88h
	dac_sample_metadata SndDAC_Timpani, 1.20	; 89h
	dac_sample_metadata SndDAC_Timpani, 0.97	; 8Ah
	dac_sample_metadata SndDAC_Timpani, 0.95	; 8Bh
	dac_sample_metadata SndDAC_Tom,     1.70	; 8Ch
	dac_sample_metadata SndDAC_Tom,     1.30	; 8Dh
	dac_sample_metadata SndDAC_Tom,     1.10	; 8Eh
	dac_sample_metadata SndDAC_Bongo,   2.00	; 8Fh
	dac_sample_metadata SndDAC_Bongo,   1.75	; 90h
	dac_sample_metadata SndDAC_Bongo,   1.30	; 91h
```

# Support for AMPS and SMPS-adjacent drivers
AMPS is still pretty frequently used, but will likely not be developed any further for obvious reasons. Easing migration could be beneficial
Things to keep in mind:
- custom smps2asm macro set, see issue below
- modulation algorithm
- driver double updating (speed shoes)

# Support for non-flamewing smps2asm variants and conceptualising a new variant
In regard to the new variant, put simply flamewings smps2asm (the one in the disassemblys) has a lot of baggage that I don't want to deal with anymore


Notes:
LFO
Save BGM register writes when SFX overwrite them
Look into Furnace flags
- '16xy': operator multiplier
Portamento
Global gameplay-effecting-music communication
Better pitch slides
Easier swapping between distinct modes (FM6/PCM, FM3, PSG3/Noise)