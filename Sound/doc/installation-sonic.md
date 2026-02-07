# Rundown
Due to the nature of refusing to add hard-coded IDs and extending IDs to word-sized, smps-dusted has compatibility issues with the mainline Sonic games.
This guide will help sort out all these issues without touching the sound driver itself

# General
The base sonic games use a version of QueueSound that only uses the d0 register, allowing a1 to be used for anything
Since smps-dusted requires a1 to point to driver ram for the vast majority of its API, including QueueSound, we're going to use a wrapper subroutine to change and restore a1 as such:
```
QueueSound:
		move.l	a1,-(sp)
		lea		(v_soundram).w,a1
		jsr		(SMPS_QueueSound).l
		move.l	(sp)+,a1
		rts
```
Additionally, the base sonic games versions of SMPS use byte-sized IDs whereas smps-dusted uses word-sized. You'll have to change every instance of a call to QueueSound to use a word-sized value
```
		move.b	#mus_song,d0		; Don't do this
		moveq	#mus_song,d0		; Only do this if you know the ID will be below $80
		move.w	#mus_song,d0		; Do this
		jsr		(QueueSound).w		; The subroutine
```

# Vblank
Sonic 1s driver had a nasty bug with how it handles stack for note timeouts, which had to be avoided via hackish Vblank/Hblank code

# Sonic IDs

## Sonic 1/2/3 spike move sound
The spike move sound has an out-of-bounds note which sounds odd outside of Sonic 1s driver. The debug driver binary will throw an error when that note is played.

## Sonic 1/2/3 ring panning
How the rings work is that when the left panning ring sound is played, it'll flip an internal bit and use the right panning ring ID if that bit was set prior to the flip.
Notably, this same logic doesn't apply if you queued the right panning ring ID. It also carries over the sound effect priority of the left pan ID, assuming that they're different.

First, let's add a new byte-sized variable in ram, for this example I'll call it `v_specsoundbitfield`

Then replace every instance of queuing the left ring sound with a call to this subroutine:
```
PlayRingSound:
		move.w	#sndid_ringleft,d0
		bchg	#7,(v_specsoundbitfield).w		; flip bit
		beq.s	.left							; if it was zero before being flipped, use left
		move.w	#sndid_ringright,d0
.left:	jmp		(QueueSound).l
```

## Sonic 2 Chemical Plant Gloop sound
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

## Sonic 2 spindash rev
Sonic 2 and Clone Driver hardcodes the pitch increase for subsequent spindash rev to its ID, whereas Sonic 3 and smps-dusted use a control flag.
Locate ".asm"
then simply add `smpsRevUp` to the start of `[name]_FM5` as such:
```
[name]_FM5:
		smpsRevUp
```

## Sonic 1 pushable block sound
Sonic 1 introduced a flag for the MZ pushable block sound.
When the sound ID gets queued it will check if the flag is already set and not queue the sound if it's set. The flag is then cleared at the end of the sound using a control flag
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