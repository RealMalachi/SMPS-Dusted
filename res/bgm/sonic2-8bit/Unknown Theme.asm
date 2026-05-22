; https://github.com/sonicretro/s2smsdisasm/blob/master/sound/music_unknown.asm
; ---------------------------------------------------------------------------
Mus_S28BitUnused_Header:
	smpsHeaderStartSong	1,1
	smpsHeaderVoiceNull
	smpsHeaderChan		$00, $04
	smpsHeaderTempo		$02, $05
	smpsHeaderPSG		Mus_S28BitUnused_PSG1, $00, $02, $00, $00	; $FF
	smpsHeaderPSG		Mus_S28BitUnused_PSG2, $00, $02, $00, $00	; $FF
	smpsHeaderPSG		Mus_S28BitUnused_PSG3, $00, $04, $00, $00	; $FF
	smpsHeaderPSG		Mus_S28BitUnused_PSG4, $00, $00, $00, $00

Mus_S28BitUnused_PSG1:
; while it probably didn't exist in smps-sms, loops 1 and 2 can be a call
Mus_S28BitUnused_PSG1_Loop1:
	smpsPSGvoice	fS28bit_04	; this could be out of the loop ; while it didn't exist in smps-sms, this can be defined in the channel header
	dc.b	nA3,$03,nF3,nB3,nF3,nC4,nF3,nD4,nF3
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop1
Mus_S28BitUnused_PSG1_Loop2:
	dc.b	nG3,$03,nE3,nA3,nE3,nB3,nE3,nC4,nE3		; you don't need to set the time, it's always $03
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop2
Mus_S28BitUnused_PSG1_Jump:
; loops 3 and 4 can use the aforementioned call
Mus_S28BitUnused_PSG1_Loop3:
	smpsPSGvoice	fS28bit_04	; this is redundant, it's already $04
	dc.b	nA3,$03,nF3,nB3,nF3,nC4,nF3,nD4,nF3		; you don't need to set the time, it's always $03
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop3
Mus_S28BitUnused_PSG1_Loop4:
	dc.b	nG3,$03,nE3,nA3,nE3,nB3,nE3,nC4,nE3		; you don't need to set the time, it's always $03
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop4
Mus_S28BitUnused_PSG1_Loop5:
	dc.b	nC4,$03,nA3,nD4,nA3,nE4,nA3,nF4,nA3		; you don't need to set the time, it's always $03
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop5
Mus_S28BitUnused_PSG1_Loop6:
	dc.b	nB3,$03,nG3,nC4,nG3,nD4,nG3,nE4,nG3		; you don't need to set the time, it's always $03
	smpsLoop	0,8,Mus_S28BitUnused_PSG1_Loop6
	smpsJump	Mus_S28BitUnused_PSG1_Jump
	smpsStop

Mus_S28BitUnused_PSG3:
Mus_S28BitUnused_PSG3_Loop1:
	smpsPSGvoice	fS28bit_02	; this could be out of the loop ; while it didn't exist in smps-sms, this can be defined in the channel header
	dc.b	nF1,$02,nA1,nC2
	dc.b	nE2,$03
	smpsPSGAlterVol	$03
	dc.b	nE2,$03		; either the note or time could be removed since they're both already set
	smpsPSGAlterVol	$FD
	smpsPSGAlterVol	$02
	smpsLoop	0,4,Mus_S28BitUnused_PSG3_Loop1
	smpsPSGAlterVol	$F8
	smpsLoop	1,4,Mus_S28BitUnused_PSG3_Loop1
	smpsAlterPitch	$FB
	smpsLoop	2,2,Mus_S28BitUnused_PSG3_Loop1
	smpsAlterPitch	$0A
Mus_S28BitUnused_PSG3_Jump:
Mus_S28BitUnused_PSG3_Loop2:
	smpsPSGvoice	fS28bit_03	; this could be out of the loop
	dc.b	nF0,$03
	smpsPSGAlterVol	$05	; oh god.
	dc.b	nF0
	smpsPSGAlterVol	$FB	; OH GOD!
	dc.b	nA0
	smpsPSGAlterVol	$05
	dc.b	nA0
	smpsPSGAlterVol	$FB
	dc.b	nC1
	smpsPSGAlterVol	$05
	dc.b	nC1
	smpsPSGAlterVol	$FB
	dc.b	nE1
	dc.b	nF0
	smpsPSGAlterVol	$05
	dc.b	nF0
	smpsPSGAlterVol	$FB
	dc.b	nF0
	dc.b	nA0
	smpsPSGAlterVol	$05
	dc.b	nA0
	smpsPSGAlterVol	$FB
	dc.b	nC1
	smpsPSGAlterVol	$05
	dc.b	nC1
	smpsPSGAlterVol	$FB
	dc.b	nE1
	smpsPSGAlterVol	$05
	dc.b	nE1
	smpsPSGAlterVol	$FB
	smpsLoop	0,4,Mus_S28BitUnused_PSG3_Loop2
Mus_S28BitUnused_PSG3_Loop3:
	smpsPSGvoice	fS28bit_03	; this is redundant, it's already $03
	dc.b	nC0,$03
	smpsPSGAlterVol	$05
	dc.b	nC0
	smpsPSGAlterVol	$FB
	dc.b	nE0
	smpsPSGAlterVol	$05
	dc.b	nE0
	smpsPSGAlterVol	$FB
	dc.b	nG0
	smpsPSGAlterVol	$05
	dc.b	nG0
	smpsPSGAlterVol	$FB
	dc.b	nB0
	dc.b	nC0
	smpsPSGAlterVol	$05
	dc.b	nC0
	smpsPSGAlterVol	$FB
	dc.b	nC0
	dc.b	nE0
	smpsPSGAlterVol	$05
	dc.b	nE0
	smpsPSGAlterVol	$FB
	dc.b	nG0
	smpsPSGAlterVol	$05
	dc.b	nG0
	smpsPSGAlterVol	$FB
	dc.b	nB0
	smpsPSGAlterVol	$05
	dc.b	nB0
	smpsPSGAlterVol	$FB
	smpsLoop	0,4,Mus_S28BitUnused_PSG3_Loop3
	smpsJump	Mus_S28BitUnused_PSG3_Jump
	smpsStop

; why is it down here? ideally it'd be above or below PSG1
Mus_S28BitUnused_PSG2:
	dc.b	nRst,$09
	smpsPSGAlterVol	$05				; just do that in the header?
	smpsJump	Mus_S28BitUnused_PSG1
	smpsStop	; ???

Mus_S28BitUnused_PSG4:
	smpsEnableDrumMode
Mus_S28BitUnused_PSG4_Loop1:
	dc.b	nRst,$30
	smpsLoop	0,7,Mus_S28BitUnused_PSG4_Loop1
	smpsPSGAlterVol	$01					; just do that in the header? ; smps-sms has dedicated command for drum volume
	dc.b	nRst,$18					; why not half the loop time and loop it 15 times?

	dc.b	pdS28bit_00,$03,pdS28bit_03
	dc.b	pdS28bit_00,pdS28bit_00,pdS28bit_03,pdS28bit_00,pdS28bit_03,pdS28bit_03
Mus_S28BitUnused_PSG4_Jump:
Mus_S28BitUnused_PSG4_Loop2:
	dc.b	pdS28bit_00,$03,pdS28bit_00,pdS28bit_00,pdS28bit_00,pdS28bit_03,pdS28bit_00,pdS28bit_00,pdS28bit_00	; you don't need to set the time, it's always $03
	dc.b	pdS28bit_00,    pdS28bit_00,pdS28bit_00,pdS28bit_00,pdS28bit_03,pdS28bit_00,pdS28bit_00,pdS28bit_00	; why not remove this and loop 14 times?
	smpsLoop	0,7,Mus_S28BitUnused_PSG4_Loop2

	dc.b	pdS28bit_00,$03,pdS28bit_00,pdS28bit_00,pdS28bit_00,pdS28bit_03			; you don't need to set the time, it's always $03
	dc.b	pdS28bit_00,    pdS28bit_00,pdS28bit_00,pdS28bit_00,pdS28bit_03			; smpsLoop would save like, one byte
	dc.b	pdS28bit_00,pdS28bit_00,pdS28bit_03,pdS28bit_00,pdS28bit_03,pdS28bit_03
	smpsJump	Mus_S28BitUnused_PSG4_Jump
	smpsStop	; ???