; INPUT
; a0 = piano ram
; a1 = driver ram
; TRASHES: d0-d7/a0-a6
; piano ram is channel x 8 bytes in length
; channels (there's 12): FM1, FM2, FM3, FM4, FM5, FM6, PSG1, PSG2, PSG3, PSG4, DAC1, DAC2
; per-channel ram is as follows (dots are undefined):
; - E.....SS - [E]Enabled [S]Sound effect, 0=bgm 1=sfx 2=bsfx
; - RNNNNNNN - note(approx), rest
; - FFFFFFFF - frequency/sample MSB
; - ffffffff - frequency/sample LSB
; - 0VVVVVVV - volume
; - RRRRLLLL - pan
; - 00000000 - reserved 1
; - 00000000 - reserved 2
; ---------------------------------------------------------------------------
SetupPianoRoll:
		moveq	#0,d7
.loop:
; figure out what channel ram we're using, put it in a5
		move.l	a1,a5
		lea	.snd(pc),a2
		add.w	(a2,d7.w),a5
		btst	#_sfxoverride,TrackPlaybackControl(a5)
		beq.s	.bgm
		smpsMakeChannelRamIndex d0,TrackVoiceControl(a5)
		smpsGetChannelFromRamIndex a1,d0,d1,a2,a5
.bgm:
; dump stuff
		move.w	#$C0,d0
		and.b	TrackVoiceControl(a5),d0
		lsr.b	#4,d0
		jsr	.lut(pc,d0.w)
		tst.b	TrackPlaybackControl(a5)
		smi.b	(a0)+
		move.b	d0,(a0)+
		move.w	d6,(a0)+
		move.b	TrackVolume(a5),d2
		bpl.s	.volexceed
		moveq	#$7F,d2
.volexceed:
		move.b	d2,(a0)+
		move.b	d1,(a0)+
		clr.w	(a0)+
; loop
		addq.w	#2,d7
		cmp.w	#.snde-.snd,d7
		blo.s	.loop
		rts
.lut:
		bra.w	.fm
		bra.w	.pcm
		bra.w	.psg
		bra.w	.psg3

.snd:		dc.w v_music_fm1_track
		dc.w v_music_fm2_track
		dc.w v_music_fm3_track
		dc.w v_music_fm4_track
		dc.w v_music_fm5_track
		dc.w v_music_fm6_track
		dc.w v_music_psg1_track
		dc.w v_music_psg2_track
		dc.w v_music_psg3_track
		dc.w v_music_psg3_track;v_music_psg4_track
		dc.w v_music_dac1_track
		dc.w v_music_dac1_track;v_music_dac2_track
.snde:
; ---------------------------------------------------------------------------
; PSG frequencies range from $3FF-$000 (higher is lower pitch)
; Margin of error is necessary due to detune/modulation/portamento
.psg3:
.psg:
		moveq	#-1,d1
		bsr.w	GetFrequency
		bmi.s	.restnote
		and.w	#$3FF,d6
		lea	PSGFrequencies(pc),a2
		moveq	#$5F,d0
.psgl:		move.w	(a2)+,d3
		move.w	(a2),d2
		sub.w	d2,d3
		lsr.w	#1,d3
		add.w	d2,d3
		cmp.w	d6,d3
		dble	d0,.psgl
		if __smpsDebug
		bgt.s	.psger1
		lea	PSGFrequenciesEnd-2(pc),a3
		cmp.l	a3,a2
		bhi.s	.psger2
		endif
		neg.w	d0
		add.w	#$5F,d0
		rts
.psger1:	SMPS_assert "Piano PSG error 1"
.psger2:	SMPS_assert "Piano PSG error 2"
; ---------------------------------------------------------------------------
.pcm:
		move.b	TrackAMSFMSPan(a5),d1	; ........ RL......
		ext.w	d1			; RRRRRRRR RL......
		add.b	d1,d1			; RRRRRRRR L......0
		smi.b	d1			; RRRRRRRR LLLLLLLL
		lsr.w	#4,d1			; ....RRRR RRRRLLLL
		move.w	TrackSavedDAC(a5),d6
.restnote:
		moveq	#-1,d0
		rts
; ---------------------------------------------------------------------------
; FM frequencies range from $0000-$3FFF (lower is lower pitch)
; Margin of error is necessary due to detune/modulation/portamento
.fm:		move.b	TrackAMSFMSPan(a5),d1	; ........ RL......
		ext.w	d1			; RRRRRRRR RL......
		add.b	d1,d1			; RRRRRRRR L......0
		smi.b	d1			; RRRRRRRR LLLLLLLL
		lsr.w	#4,d1			; ....RRRR RRRRLLLL
		bsr.w	GetFrequency
		bmi.s	.restnote
		and.w	#$3FFF,d6
		lea	FMFrequencies(pc),a2
		moveq	#$5F,d0
.fml:		move.w	(a2)+,d2
		move.w	(a2),d3
		sub.w	d2,d3
		lsr.w	#1,d3
		add.w	d2,d3
		cmp.w	d6,d3
		dbge	d0,.fml
		if __smpsDebug
		blt.s	.fmer1
		lea	FMFrequenciesEnd-2(pc),a3
		cmp.l	a3,a2
		bhi.s	.fmer2
		endif
		neg.w	d0
		add.w	#$5F,d0
		rts
.fmer1:		SMPS_assert "Piano FM error 1"
.fmer2:		SMPS_assert "Piano FM error 2"