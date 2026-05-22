Mus_TestBgm_Header:
	smpsHeaderStartSong	$F0E50000,1
	smpsHeaderVoice		Mus_TestBgm_Voices
	smpsHeaderVolEnv	Mus_TestBgm_VolEnv
;	smpsHeaderModEnv	Mus_TestBgm_ModEnv
	smpsHeaderChan		$00, $00, $01
	smpsHeaderTempo		$01, $0000
	smpsHeaderDAC		Mus_TestBgm_DAC,  $00, $00
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
; pcm panenv test (TODO)

; pcm modulation test (TODO)
; pcm modenv test (TODO)

; post-sfx restoration test
	smpsPanLeft
	smpsSetVol $40
	dc.b	dSegaChant, $7F, dSegaChant, $7F
; alright we're done
	smpsStop

Mus_TestBgm_Voices:
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
	smpsVcDetune		$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $05, $06
	smpsVcRateScale		$02, $02, $03, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$06, $09, $06, $07
	smpsVcDecayRate2	$08, $06, $06, $07
	smpsVcDecayLevel	$0F, $01, $01, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevelMuffle	$80, $13, $37, $19
	smpsVcTotalLevel	$80, $13, $37, $19

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
