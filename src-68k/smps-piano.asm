; INPUT
; a0 = piano ram
; a1 = driver ram
; TRASHES: d0-d7/a0-a6
; piano ram is channel x 8 bytes in length
; channels (there's 12): FM1, FM2, FM3, FM4, FM5, FM6, PSG1, PSG2, PSG3, PSG4, DAC1, DAC2
; per-channel ram is as follows (dots are undefined):
; - EP....SS - [E]Enabled, [P]Played note, [S]Sound effect, 0=bgm 1=sfx 2=bsfx
; - RNNNNNNN - note(approx), rest
; - FFFFFFFF - frequency/sample MSB
; - ffffffff - frequency/sample LSB
; - 0VVVVVVV - volume
; - RRRRLLLL - pan
; - TTTTTTTT - duration time
; - 00000000 - reserved
; ---------------------------------------------------------------------------
SetupPianoRoll:
		moveq	#0,d7
		move.l	a0,a6
.loop:
; figure out what channel ram we're using, put it in a5
		lea	.snd(pc),a0
		move.w	(a0,d7.w),d0
		bne.s	.valid
		addq.w	#8,a6
		bra.w	.doloop
.valid:		lea	(a1,d0.w),a5
		moveq	#0,d5
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		beq.s	.bgm
		moveq	#1,d5
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		smpsGetChannelFromRamIndex a1,d0,d1,a0,a5
.bgm:
		moveq_	1<<_playing,d0					; bit 7
		and.b	TrackPlaybackControl(a5),d0
		if _playing<>7
		fatal "The _playing flag in TrackPlaybackControl isn't 7 but the piano roll expects it to be, add code to account for that"
		endif
		or.b	d0,d5
; dump channel data into piano buffer
		move.w	#$C0,d0
		and.b	TrackVoiceControl(a5),d0
		lsr.b	#4,d0
		moveq_	1<<_playing|1<<_resting,d1			; if it's playing and not resting, update the frequency
		and.b	TrackPlaybackControl(a5),d1
		cmp.b	#1<<_playing|0<<_resting,d1
		beq.s	.resting
		add.w	#16,d0
.resting:
		jsr	.lut(pc,d0.w)
		move.b	d5,(a6)+
		move.b	d0,(a6)+
		move.w	d6,(a6)+
		move.b	TrackVolume(a5),d2
		bpl.s	.vol
		moveq	#$7F,d2
.vol:		move.b	d2,(a6)+
		move.b	d1,(a6)+
		move.b	TrackDurationTimeout(a5),(a6)+
		clr.b	(a6)+
; loop
.doloop:
		addq.w	#2,d7
		cmp.w	#.snde-.snd,d7
		blo.w	.loop
		rts
.lut:
		bra.w	.fm		; 0
		bra.w	.pcm
		bra.w	.psg
		bra.w	.psg3
		bra.w	.fm_rest	; 16
		bra.w	.pcm_rest
		bra.w	.psg_rest
		bra.w	.psg3_rest

.snd:		dc.w v_music_fm1_track
		dc.w v_music_fm2_track
		dc.w v_music_fm3_track
		dc.w v_music_fm4_track
		dc.w v_music_fm5_track
		dc.w v_music_fm6_track
		dc.w v_music_psg1_track
		dc.w v_music_psg2_track
		dc.w v_music_psg3_track
		dc.w v_music_psg4_track
		dc.w v_music_pcm1_track
		dc.w 0;v_music_pcm2_track
.snde:
		even
; ---------------------------------------------------------------------------
; PSG frequencies range from $3FF-$000 (higher is lower pitch)
; Margin of error is necessary due to detune/modulation/portamento
.psg3:
.psg:		moveq	#-1,d2
		bsr.w	GetFrequency
		bmi.s	.psg_rest
		and.w	#$3FF,d6
		lea	PSGFrequencies(pc),a0
		move.w	(a0)+,d2
		moveq	#$5F,d0
.psgl:		move.w	d2,d3
		move.w	(a0)+,d2
		sub.w	d2,d3
		lsr.w	#1,d3
		add.w	d2,d3
		cmp.w	d6,d3
		dble	d0,.psgl
		if __smpsDebug
		bgt.s	.psger1
		lea	PSGFrequenciesEnd(pc),a3
		cmp.l	a3,a0
		bhi.s	.psger2
		endif
		neg.w	d0
		add.w	#$5F,d0
		moveq	#-1,d1
		rts
.psger1:	SMPS_assert "Piano PSG error 1"
.psger2:	SMPS_assert "Piano PSG error 2"
.psg_rest:
.psg3_rest:
		moveq	#-1,d6
		moveq	#-1,d0
		moveq	#-1,d1
		rts
; ---------------------------------------------------------------------------
.pcm:
		moveq	#0,d6
		move.b	TrackSavedDAC(a5),d6
		moveq	#-1,d0
		move.b	TrackAMSFMSPan(a5),d1	; ........ RL......
		ext.w	d1			; RRRRRRRR RL......
		add.b	d1,d1			; RRRRRRRR L......0
		smi.b	d1			; RRRRRRRR LLLLLLLL
		lsr.w	#4,d1			; ....RRRR RRRRLLLL
		rts
.pcm_rest:
.fm_rest:
		moveq	#-1,d0
		moveq	#-1,d6
		move.b	TrackAMSFMSPan(a5),d1	; ........ RL......
		ext.w	d1			; RRRRRRRR RL......
		add.b	d1,d1			; RRRRRRRR L......0
		smi.b	d1			; RRRRRRRR LLLLLLLL
		lsr.w	#4,d1			; ....RRRR RRRRLLLL
		rts
; ---------------------------------------------------------------------------
; FM frequencies range from $0000-$3FFF (lower is lower pitch)
; Margin of error is necessary due to detune/modulation/portamento
.fm:		moveq	#-1,d2
		bsr.w	GetFrequency
		bmi.s	.fm_rest
		and.w	#$3FFF,d6
		lea	FMFrequencies(pc),a0
		moveq	#$5F,d0
.fml:		move.w	(a0)+,d2
		move.w	(a0),d3
		sub.w	d2,d3
		lsr.w	#1,d3
		add.w	d2,d3
		cmp.w	d6,d3
		dbge	d0,.fml
		if __smpsDebug
		blt.s	.fmer1
		lea	FMFrequenciesEnd-2(pc),a3
		cmp.l	a3,a0
		bhi.s	.fmer2
		endif
		neg.w	d0
		add.w	#$5F,d0
		move.b	TrackAMSFMSPan(a5),d1	; ........ RL......
		ext.w	d1			; RRRRRRRR RL......
		add.b	d1,d1			; RRRRRRRR L......0
		smi.b	d1			; RRRRRRRR LLLLLLLL
		lsr.w	#4,d1			; ....RRRR RRRRLLLL
		rts
.fmer1:		SMPS_assert "Piano FM error 1"
.fmer2:		SMPS_assert "Piano FM error 2"