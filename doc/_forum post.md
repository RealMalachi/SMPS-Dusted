SMPS, abbreviation of [REDACTED], the sound driver powering many Mega Drive software at the time, of interest to most people in this forum, including the mainline Sonic games.
...that sentence was a half truth. They all use SMPS, but not the same version of SMPS. SMPS has colourful history of getting revisions and added features not from its original developers, sometimes on a per-game basis. The Sonic games are no different, the 1up music fade-in is not a native smps feature, nor is the spindash rev up, nor the Sonic 1 pushable block flag, nor the ring panning

smps-dusted is a standard I'm attempting to set up, akin to Flamedriver, Clone Driver, AMPS etc
It's designed with the following principles in mind:
- Ease of use and alteration: If someone wants to replace the DAC player, or make SFXs update at proper speed in PAL, introduce new features or remove them, they should be able to. This is both to keep in line with the spirit of SMPS, and well, this is a community driver.
- Independance from the main game: The driver should be modular enough to be provided in a binary blob, with no hard-coded data dependant on the game itself
- QOL features for music creation:


# Compatibility issues
Due to the nature of refusing to add hard-coded IDs, smps-dusted has compatibility issues with the mainline Sonic games. This guide will help sort those out without touching the sound driver itself

# General
The base sonic games use a version of QueueSound that only uses the d0 register, allowing a1 to be used for anything
Since smps-dusted requires a1 to point to driver ram for the vast majority of its API, including QueueSound.
```
QueueSound:
		move.w	d0,-(sp)
		move.l	a1,-(sp)
		and.w	#$FF,d0
		lea		(v_soundram).w,a1
		jsr		(SMPS_QueueSound).l
		move.l	(sp)+,a1
		move.w	(sp)+,d0
		rts
```

# Sonic 1/2/3 spike move sound

# Sonic 1/2/3 ring panning
How the rings work is that if the left panning ring ID is played, it'll alternate a bit and if the bit is set, use the right panning ring ID instead.
Notably, this same logic doesn't apply if you queued the right panning ring ID. It also carries over the sound priority of the left pan ID, assuming they're different

First, let's add a new byte-sized variable in ram, for this example I'll call it `v_specsoundbitfield`

Then just uhh:
```
PlayRingSound:
		move.w	#sndid_ringleft,d0
		bchg	#7,(v_specsoundbitfield).w		; flip bit
		beq.s	.left							; if it was zero before being flipped, use left
		move.w	#sndid_ringright,d0
.left:	jmp		(QueueSound).l
```

# Sonic 2 Chemical Plant Gloop sound
Similarly to the ring panning, the CPZ gloop uses an alternating bit, except it alternates between playing and not play the sound
Same deal as before, just use a different bit from the ring so they dont clobber each other
```
PlayGloopSound:
		bchg	#6,(v_specsoundbitfield).w		; flip bit
		bne.s	.nosnd							; if it was zero before being flipped, play the sound
		move.w	#sndid_gloop,d0
		jmp		(QueueSound).l
.nosnd:	rts
```

# Sonic 2 spindash rev
Sonic 2 and Cloner Driver hardcodes the pitch increase for subsequent spindash rev to its ID, whereas Sonic 3 and smps-dusted use a control flag.
Locate ".asm"
then simply add `smpsRevUp` to the start of `[name]_FM5` as such:
```
[name]_FM5:
		smpsRevUp
```

# Sonic 1 pushable block sound
Sonic 1 introduced a flag for the MZ pushable block sound.
When the sound ID gets queued it will check if the flag is already set and if so then not queue it, if not then set the flag. The flag is then cleared at the end of the sound using a control flag
Instead of preventing playback on a driver level, we will instead introduce a timer to the pushable object, which prevents playing the sound when we don't want it to

In "_incObj/33 - MZ Pushable Block.asm", add the following to the start:
```
pushb_sfxtimer = objoff_2F

PushBlock:
```

Locate `loc_C218`, add the following:
```
loc_C218:
		tst.b	pushb_sfxtimer(a0)
		beq.s	.nodec
		subq.b	#1,pushb_sfxtimer(a0)
.nodec:
```

Locate `sfx_Push`, replace this:

with this:
```
		tst.b	pushb_sfxtimer(a0)
		bne.s	.nosfx
		move.b	#30,pushb_sfxtimer(a0)
		move.w	d0,-(sp)
		sfx	sfx_Push
		move.w	(sp)+,d0
.nosfx:
```
You could also use the communication byte, but I'd rather reserve that for BGM.