Mus_TestBgm_Header:
	smpsHeaderStartSong	$F0E50000,1
	smpsHeaderVoiceUVB
;	smpsHeaderVolEnv	Mus_TestBgm_VolEnv
;	smpsHeaderModEnv	Mus_TestBgm_ModEnv
	smpsHeaderChan		$02, $04, $01
	smpsHeaderTempo		$01, $0000
	smpsHeaderDAC		Mus_TestBgm_DAC,  $00, $00
	smpsHeaderDAC		Mus_TestBgm_FM1,  $00, $00
	smpsHeaderDAC		Mus_TestBgm_FM2,  $00, $00
	smpsHeaderPSG		Mus_TestBgm_PSG1, $00, $00, $00, $00
	smpsHeaderPSG		Mus_TestBgm_PSG2, $00, $00, $00, $00
	smpsHeaderPSG		Mus_TestBgm_PSG3, $00, $00, $00, $00
	smpsHeaderPSG		Mus_TestBgm_PSG4, $00, $00, $00, $00

; PSG Data
Mus_TestBgm_PSG1:
Mus_TestBgm_PSG2:
	smpsStop

Mus_TestBgm_FM1:
	smpsFMvoice pTrumpet1
	smpsFMSetVol $13
Mus_TestBgm_FM1_Loop:
	dc.b nC0,1,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	dc.b nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
	dc.b nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
	dc.b nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
	dc.b nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
	dc.b nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
	dc.b nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
	dc.b nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
	smpsLoop 0,48,Mus_TestBgm_FM1_Loop
	smpsStop

Mus_TestBgm_FM2:
	smpsEnableDrumMode
Mus_TestBgm_FM2_Loop:
	dc.b fdTest1,32
	smpsLoop 0,48,Mus_TestBgm_FM2_Loop
	smpsStop

Mus_TestBgm_PSG3:
	smpsPSGSetVol 14<<3
Mus_TestBgm_PSG3_Loop:
	dc.b nC0,1,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	dc.b nC1,nCs1,nD1,nEb1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1
	dc.b nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2,nG2,nAb2,nA2,nBb2,nB2
	dc.b nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3,nB3
	dc.b nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4
	dc.b nC5,nCs5,nD5,nEb5,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5
	dc.b nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6,nG6,nAb6,nA6,nBb6,nB6
	smpsLoop 0,48,Mus_TestBgm_PSG3_Loop
	smpsStop

Mus_TestBgm_PSG4:
	smpsDisableDrumMode
Mus_TestBgm_PSG4_Loop:
	dc.b nnP10,120,nnP20,nnP40,nnPPSG3,nnN10,nnN20,nnN40,nnNPSG3
	smpsLoop 0,8,Mus_TestBgm_PSG4_Loop
	smpsStop

; DAC Data
Mus_TestBgm_DAC:
; pcm test
	dc.b	dIntroKick, $18
; pcm rest test
	dc.b	dIntroKick, $0C, nRst, $0C
; pcm rest time time test
;	dc.b	dIntroKick, $0C, nRst, $02, $0A
; pcm note timeout test
	smpsNoteFill $0C, 0
	dc.b	dIntroKick, $18
	smpsNoteFill $00, 0
; pcm hold test
	dc.b	dIntroKick, $0C, smpsNoAttack, nRst, $0C

; pcm volume test
Mus_TestBgm_DAC_Loop1:
	dc.b	dIntroKick, $18
	smpsAlterVol $08
	smpsLoop 0,16,Mus_TestBgm_DAC_Loop1
	smpsSetVol $00
; pcm volume whilst holding test
	dc.b	dIntroKick, $04
Mus_TestBgm_DAC_Loop2:
	smpsAlterVol $02
	dc.b	smpsNoAttack, nRst, $02
	smpsLoop 0,16,Mus_TestBgm_DAC_Loop2
	smpsPanCentre
; pcm volenv test
	smpsPSGvoice $01
	dc.b	dIntroKick, $18
	smpsPSGvoice $00

; pcm panning test
	smpsPanLeft
	dc.b	dIntroKick, $18
	smpsPanRight
	dc.b	dIntroKick, $18
	smpsPanCentre
; pcm panning whilst holding test
	dc.b	dIntroKick, $04
Mus_TestBgm_DAC_Loop3:
	smpsPanLeft
	dc.b	smpsNoAttack, nRst, $02
	smpsPanRight
	dc.b	smpsNoAttack, nRst, $02
	smpsLoop 0,8,Mus_TestBgm_DAC_Loop3
	smpsPanCentre
; pcm panenv test
	smpsPanAni 2,1,pEnv_00,"UPD-REPEAT"
	dc.b	dIntroKick, $18, $18, $18, $18, $18, $18, $18, $18
	smpsPanAni 2,1,pEnv_00,"TICK-REPEAT"
	dc.b	dIntroKick, $18, $18, $18, $18, $18, $18, $18, $18
	smpsPanAni 2,1,pEnv_00,"TICK-HOLD"
	dc.b	dIntroKick, $18, $18, $18, $18, $18, $18, $18, $18
	smpsPanAni "OFF"

; pcm modulation test (TODO)
; pcm modenv test (TODO)

; post-sfx restoration test
	smpsPanLeft
	smpsSetVol $40
	dc.b	dSegaChant, $7F, dSegaChant, $7F
; alright we're done
	smpsStop

Mus_TestBgm_VolEnv:
	smpsEnvTable START,1
	smpsEnvTable Mus_TestBgm_VolEnv_m01
	smpsEnvTable END,$100
Mus_TestBgm_VolEnv_m01:	smpsEnvVol $00,$08,$10,$18,$20,$28,$30,$38,$40,$48,$50,$58,$60,$68,$70,$78,REST

;Mus_TestBgm_ModEnv:
;	smpsEnvTable START
;	smpsEnvTable Mus_TestBgm_ModEnv_m01
;	smpsEnvTable END
;Mus_TestBgm_ModEnv_m01:	smpsEnvMod $00,HOLD
