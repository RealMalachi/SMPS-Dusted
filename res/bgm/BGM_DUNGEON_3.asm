BGM_DUNGEON3_Header:		; To clean up
	smpsHeaderStartSong	$F0E50000,1
	smpsHeaderVoice		BGM_DUNGEON3_Voices
	smpsHeaderVolEnv	BGM_DUNGEON3_VolEnv
	smpsHeaderChan		$06, $03, $00
	smpsHeaderTempo		$02, $4400

;	Given Tempo = 110.00 BPM
;	Approximated Tempo = 110.16 BPM

	smpsHeaderFM	BGM_DUNGEON3_FM1,	$00, $0E
	smpsHeaderFM	BGM_DUNGEON3_FM2,	$00, $0B
	smpsHeaderFM	BGM_DUNGEON3_FM3,	$00, $0E
	smpsHeaderFM	BGM_DUNGEON3_FM4,	$00, $13
	smpsHeaderFM	BGM_DUNGEON3_FM5,	$00, $15
	smpsHeaderFM	BGM_DUNGEON3_FM6,	$00, $1C
	smpsHeaderPSG	BGM_DUNGEON3_PSG1,	$0C, $18, $00, PSG_DUN03_00
	smpsHeaderPSG	BGM_DUNGEON3_PSG2,	$0C, $20, $00, PSG_DUN03_00
	smpsHeaderPSG	BGM_DUNGEON3_PSG3,	$0C, $30, $00, PSG_DUN03_00

BGM_DUNGEON3_Voices:
;	FM Voice 00 -> 00: FM_DUN03_00
	smpsVcAlgorithm		$04
	smpsVcFeedback		$07
	smpsVcDetune		$01, $05, $00, $02
	smpsVcCoarseFreq	$01, $03, $01, $01
	smpsVcRateScale		$02, $03, $02, $03
	smpsVcAttackRate	$19, $1F, $19, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $00, $07, $00
	smpsVcDecayRate2	$05, $08, $06, $08
	smpsVcDecayLevel	$03, $04, $03, $04
	smpsVcReleaseRate	$07, $00, $07, $00
	smpsVcTotalLevel	$80, $1C, $8A, $20

;	FM Voice 01 -> 01: FM_DUN03_01
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
	smpsVcDetune		$03, $03, $07, $07
	smpsVcCoarseFreq	$04, $04, $08, $02
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$10, $1F, $10, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$0A, $00, $0A, $00
	smpsVcDecayRate2	$09, $00, $09, $00
	smpsVcDecayLevel	$01, $00, $01, $00
	smpsVcReleaseRate	$05, $00, $05, $00
	smpsVcTotalLevel	$80, $17, $80, $16

;	FM Voice 02 -> 02: FM_DUN03_02
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
	smpsVcDetune		$03, $03, $04, $07
	smpsVcCoarseFreq	$02, $02, $02, $02
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$12, $12, $12, $12
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $00, $08, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$02, $00, $02, $00
	smpsVcReleaseRate	$06, $00, $06, $00
	smpsVcTotalLevel	$80, $23, $80, $23

;	FM Voice 03 -> 03: FM_DUN03_03
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
	smpsVcDetune		$07, $07, $04, $03
	smpsVcCoarseFreq	$04, $0E, $01, $03
	smpsVcRateScale		$00, $01, $02, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1B
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $07, $08, $04
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0F, $0E, $0F, $0F
	smpsVcReleaseRate	$06, $00, $06, $00
	smpsVcTotalLevel	$87, $29, $80, $23

BGM_DUNGEON3_VolEnv:
	smpsEnvTable START,1,$F0E50000
	smpsEnvTable BGM_DUNGEON3_VOLENV01, PSG_DUN03_00
	smpsEnvTable BGM_DUNGEON3_VOLENV02, PSG_DUN03_01
	smpsEnvTable BGM_DUNGEON3_VOLENV03, PSG_DUN03_02
	smpsEnvTable END

BGM_DUNGEON3_VOLENV01:	smpsEnvVolPsg $07, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01, $01, $01, $01, $01, $01
			smpsEnvVolPsg $02, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $03, $03, $04, $04
			smpsEnvVolPsg $04, $04, $04, $04, $04, $05, $05, $05, $05, $05, $05, $05, $06, HOLD

BGM_DUNGEON3_VOLENV02:	smpsEnvVolPsg $07, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $03, $04, $06, $07
			smpsEnvVolPsg $09, $0A, $0C, $0D, REST

BGM_DUNGEON3_VOLENV03:	smpsEnvVolPsg $07, $00, $00, $00, $00, $00, $00, $00, $01, $03, $04, $06, $07, $09, $0A, $0C
			smpsEnvVolPsg $0D, REST

BGM_DUNGEON3_FM1:

BGM_DUNGEON3_FM1_Jump:
	smpsCall BGM_DUNGEON3_FM1_00_0_144
	smpsCall BGM_DUNGEON3_FM1_01_0_144
	smpsCall BGM_DUNGEON3_FM1_00_0_144
	smpsCall BGM_DUNGEON3_FM1_01_0_144
	smpsCall BGM_DUNGEON3_FM1_02_0_144
	smpsCall BGM_DUNGEON3_FM1_03_0_144
	smpsCall BGM_DUNGEON3_FM1_04_0_144
	smpsCall BGM_DUNGEON3_FM1_05_0_144
	smpsCall BGM_DUNGEON3_FM1_06_0_144_71
	smpsCall BGM_DUNGEON3_FM1_07_0_108
	smpsCall BGM_DUNGEON3_FM1_08_0_144_6E
	smpsCall BGM_DUNGEON3_FM1_09_0_144
	smpsCall BGM_DUNGEON3_FM1_0A_0_144
	smpsCall BGM_DUNGEON3_FM1_0B_0_144
	smpsCall BGM_DUNGEON3_FM1_0C_0_144
	smpsCall BGM_DUNGEON3_FM1_0D_0_144
	smpsCall BGM_DUNGEON3_FM1_0E_0_144
	smpsCall BGM_DUNGEON3_FM1_0F_0_108
	smpsAlterVol	$FA
	smpsJump BGM_DUNGEON3_FM1_Jump

BGM_DUNGEON3_FM1_00_0_144:
	smpsSetvoice	$01
	smpsPan		panCenter, $00
	dc.b nA3, $15, nRst, $03, nE4, $04, nF4, nG4, nE4, $0C, nC4, nD4, nA3, $3C, nC4, $08
	dc.b nRst, $04
	smpsReturn

BGM_DUNGEON3_FM1_01_0_144:
	dc.b nG3, $1E, nRst, $06, nF3, $15, nRst, $03, nC4, $09, nRst, $03, nG3, $21, nRst, $03
	dc.b nF3, $1E, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM1_02_0_144:
	dc.b smpsNoAttack, $06, nE3, nD3, nE3, nA2, nE3, nC3, nD3, nG2, $0F, nRst, $09, nC3, $06, nD3
	dc.b nF2, $0C, nRst, $06, nBb2, nC3, nF3, nG3, $15, nRst, $03
	smpsReturn

BGM_DUNGEON3_FM1_03_0_144:
	dc.b smpsNoAttack, $06, nE3, nD3, nE3, nA2, nE3, nC3, nD3, nG2, $0F, nRst, $09, nC3, $06, nD3
	dc.b nF2, $0C, nRst, $06, nBb2, nC3, nF3, nG3, nC3, nC4, nRst
	smpsReturn

BGM_DUNGEON3_FM1_04_0_144:
	dc.b smpsNoAttack, $0C, nB3, $06, nC4, nG3, nRst, nA3, $15, nRst, $03, nG3, $06, nF3, nE3, $09
	dc.b nRst, $03, nF3, $0F, nRst, $03, nC3, $06, nD3, $1B, nRst, $09
	smpsReturn

BGM_DUNGEON3_FM1_05_0_144:
	dc.b smpsNoAttack, $0C, nB3, $06, nC4, nG3, nRst, nA3, $15, nRst, $03, nC4, $06, nD4, nE4, nF4
	dc.b nD4, $0F, nRst, $09, nD4, $06, nDs4, nC4, $0F, nRst, $09
	smpsReturn

BGM_DUNGEON3_FM1_06_0_144_71:
	dc.b nC4, $06, nCs4, nBb3, $0F, nRst, $09, nBb3, $06, nB3, nAb3, $0F, nRst, $15
	smpsAlterVol	$03
	dc.b nCs3, $09, nRst, $03, nFs3, $09, nRst, $03, nFs3, $1E, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM1_07_0_108:
	dc.b smpsNoAttack, $0C, nB2, $09, nRst, $03, nE3, $09, nRst, $03, nE3, $1E, nRst, $2A
	smpsReturn

BGM_DUNGEON3_FM1_08_0_144_6E:
	smpsSetvoice	$02
	smpsAlterVol	$03
	dc.b nE5, $18, $06, nF5, nE5, $0C, nC5, nA4, nE4, $18, $06, nF4, nE4, $0C, nC4, nA4
	smpsReturn

BGM_DUNGEON3_FM1_09_0_144:
	dc.b nC5, $18, nD5, $0C, nF4, $24, nC5, $18, nD5, $0C, nF4, nG4, nA4
	smpsReturn

BGM_DUNGEON3_FM1_0A_0_144:
	dc.b nE5, $18, $06, nF5, nE5, $0C, nC5, nA4, nG5, $18, $06, nA5, nG5, $0C, nE5, nC5
	smpsReturn

BGM_DUNGEON3_FM1_0B_0_144:
	dc.b nA4, $18, nC5, $0C, nD4, $24, nE4, $06, nF4, nG4, nF4, nG4, nA4, nBb4, nC5, nD5
	dc.b nC5, nD5, nE5
	smpsReturn

BGM_DUNGEON3_FM1_0C_0_144:
	dc.b nG5, $06, nFs5, nD5, nB4, nG4, nFs4, nD4, $24, nF5, $06, nE5, nC5, nA4, nF4, nE4
	dc.b nC4, $24
	smpsReturn

BGM_DUNGEON3_FM1_0D_0_144:
	dc.b nDs5, $06, nD5, nBb4, nG4, nDs4, nD4, nBb3, $18, nC4, $0C, nCs4, $3C, nD4, $06, nE4
	smpsReturn

BGM_DUNGEON3_FM1_0E_0_144:
	dc.b nCs4, $48, $3C, nD4, $06, nE4
	smpsReturn

BGM_DUNGEON3_FM1_0F_0_108:
	dc.b nCs4, $60, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM2:

BGM_DUNGEON3_FM2_Jump:
	smpsCall BGM_DUNGEON3_FM2_00_0_144
	smpsCall BGM_DUNGEON3_FM2_01_0_144
	smpsCall BGM_DUNGEON3_FM2_00_0_144
	smpsCall BGM_DUNGEON3_FM2_01_0_144
	smpsCall BGM_DUNGEON3_FM2_02_0_144
	smpsCall BGM_DUNGEON3_FM2_02_0_144
	smpsCall BGM_DUNGEON3_FM2_03_0_144
	smpsCall BGM_DUNGEON3_FM2_04_0_144
	smpsCall BGM_DUNGEON3_FM2_05_0_144
	smpsCall BGM_DUNGEON3_FM2_06_0_108
	smpsCall BGM_DUNGEON3_FM2_07_0_144
	smpsCall BGM_DUNGEON3_FM2_08_0_144
	smpsCall BGM_DUNGEON3_FM2_07_0_144
	smpsCall BGM_DUNGEON3_FM2_08_0_144
	smpsCall BGM_DUNGEON3_FM2_09_0_144
	smpsCall BGM_DUNGEON3_FM2_0A_0_144
	smpsCall BGM_DUNGEON3_FM2_0B_0_144
	smpsCall BGM_DUNGEON3_FM2_0C_0_108
	smpsJump BGM_DUNGEON3_FM2_Jump

BGM_DUNGEON3_FM2_00_0_144:
	smpsSetvoice	$00
	dc.b nD2, $0B, nRst, $01, nD2, $15, nRst, $03, nD2, $0A, nRst, $02, nD2, $10, nRst, $02
	dc.b nA1, $06, nD2, $0B, nRst, $01, nD2, $15, nRst, $03, nD2, $0A, nRst, $02, nD2, $10
	dc.b nRst, $02, nA1, $06
	smpsReturn

BGM_DUNGEON3_FM2_01_0_144:
	dc.b nBb1, $0B, nRst, $01, nBb1, $15, nRst, $03, nBb1, $0A, nRst, $02, nBb1, $10, nRst, $02
	dc.b nF1, $06, nBb1, $0B, nRst, $01, nBb1, $15, nRst, $03, nBb1, $0A, nRst, $02, nBb1, $10
	dc.b nRst, $02, nF1, $06
	smpsReturn

BGM_DUNGEON3_FM2_02_0_144:
	dc.b nA1, $0E, nRst, $04, nE1, $06, nA1, nE2, nF1, $1E, nRst, $06, nDs1, $1E, nRst, $06
	dc.b nCs2, nAb1, nCs2, $14, nRst, $04
	smpsReturn

BGM_DUNGEON3_FM2_03_0_144:
	dc.b nA1, $0E, nRst, $04, nE1, $06, nA1, nRst, nF1, $1E, nRst, $06, nD2, $0E, nRst, $04
	dc.b nA1, $06, nD2, nRst, nBb1, nRst, nDs1, $15, nRst, $03
	smpsReturn

BGM_DUNGEON3_FM2_04_0_144:
	dc.b nA1, $0E, nRst, $04, nE1, $06, nA1, nE2, nF1, $1E, nRst, $06, nBb1, $0E, nRst, $04
	dc.b nF1, $06, nBb1, nF2, nAb1, $0E, nRst, $04, nDs1, $06, nAb1, nDs2
	smpsReturn

BGM_DUNGEON3_FM2_05_0_144:
	dc.b nFs2, $0E, nRst, $04, nCs2, $06, nFs2, nCs3, nCs2, $0E, nRst, $04, nAb1, $06, nCs2, nAb2
	dc.b nB2, nRst, nB1, $24, nRst, $06, nFs1, nB1, nFs2
	smpsReturn

BGM_DUNGEON3_FM2_06_0_108:
	dc.b nA2, $06, nRst, nA1, $54, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM2_07_0_144:
	dc.b nD2, $0C, nA2, $12, nRst, $06, nD2, $0C, nA2, $12, nA1, $06, nD2, $0C, nA2, $12
	dc.b nRst, $06, nD2, $0C, nA2, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM2_08_0_144:
	dc.b nBb1, $0C, nF2, $12, nRst, $06, nBb1, $0C, nF2, $12, nF1, $06, nBb1, $0C, nF2, $12
	dc.b nRst, $06, nBb1, $0C, nF2, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM2_09_0_144:
	dc.b nE2, $0C, nB2, $12, nRst, $06, nE2, $0C, nB2, $12, nRst, $06, nD2, $0C, nA2, $12
	dc.b nRst, $06, nD2, $0C, nA2, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM2_0A_0_144:
	dc.b nC2, $0C, nG2, $12, nRst, $06, nC2, $0C, nG2, $12, nRst, $06, nB1, $0C, nFs2, $12
	dc.b nRst, $06, nB1, $0C, nFs2, $12, nFs1, $06
	smpsReturn

BGM_DUNGEON3_FM2_0B_0_144:
	dc.b nB1, $0C, nFs2, $12, nRst, $06, nB1, $0C, nFs2, $12, nFs1, $06, nB1, $0C, nFs2, $12
	dc.b nRst, $06, nB1, $0C, nFs2, $12, nFs1, $06
	smpsReturn

BGM_DUNGEON3_FM2_0C_0_108:
	dc.b nB1, $0C, nFs2, $12, nRst, $06, nB1, $42, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM3:

BGM_DUNGEON3_FM3_Jump:
	smpsCall BGM_DUNGEON3_FM3_00_0_144
	smpsCall BGM_DUNGEON3_FM3_01_0_144
	smpsCall BGM_DUNGEON3_FM3_00_0_144
	smpsCall BGM_DUNGEON3_FM3_01_0_144
	smpsCall BGM_DUNGEON3_FM3_02_0_144_71
	smpsCall BGM_DUNGEON3_FM3_02_0_144
	smpsCall BGM_DUNGEON3_FM3_03_0_144
	smpsCall BGM_DUNGEON3_FM3_04_0_144
	smpsCall BGM_DUNGEON3_FM3_05_0_144_6F
	smpsCall BGM_DUNGEON3_FM3_06_0_108
	smpsCall BGM_DUNGEON3_FM3_07_0_144
	smpsCall BGM_DUNGEON3_FM3_08_0_144
	smpsCall BGM_DUNGEON3_FM3_09_0_144
	smpsCall BGM_DUNGEON3_FM3_0A_0_144
	smpsCall BGM_DUNGEON3_FM3_0B_0_144
	smpsCall BGM_DUNGEON3_FM3_0C_0_144
	smpsCall BGM_DUNGEON3_FM3_0D_0_144
	smpsCall BGM_DUNGEON3_FM3_0E_0_108
	smpsAlterVol	$FD
	smpsJump BGM_DUNGEON3_FM3_Jump

BGM_DUNGEON3_FM3_00_0_144:
	smpsSetvoice	$00
	smpsPan		panRight, $00
	dc.b nD2, $06, nA2, nF3, nC4, $12, nD2, $06, nA2, nF3, nC4, $12, nD2, $06, nA2, nG3
	dc.b nC4, $12, nD2, $06, nA2, nF3, nC4, $12
	smpsReturn

BGM_DUNGEON3_FM3_01_0_144:
	dc.b nBb2, $06, nF3, nC4, nG4, $12, nBb2, $06, nF3, nC4, nF4, $12, nBb2, $06, nF3, nC4
	dc.b nG4, $12, nBb2, $06, nF3, nC4, nF4, $12
	smpsReturn

BGM_DUNGEON3_FM3_02_0_144_71:
	smpsAlterVol	$02
	dc.b nA2, $12, nG4, nC3, $24, nBb2, nCs2, $12, nC4
	smpsReturn

BGM_DUNGEON3_FM3_02_0_144:
	dc.b nA2, $12, nG4, nC3, $24, nBb2, nCs2, $12, nC4
	smpsReturn

BGM_DUNGEON3_FM3_03_0_144:
	dc.b nA2, $12, nG4, nC3, $24, nD2, $12, nF3, nBb2, $07, nRst, $05, nDs2, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM3_04_0_144:
	dc.b nA2, $12, nG4, nC3, $24, nBb2, $12, nRst, nAb2, nRst
	smpsReturn

BGM_DUNGEON3_FM3_05_0_144_6F:
	dc.b nFs2, $12, nRst, nCs2, nRst, $1E
	smpsSetvoice	$01
	smpsPan		panCenter, $00
	smpsAlterVol	$01
	dc.b nA2, $09, nRst, $03, nCs3, $09, nRst, $03, nCs3, $1E, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM3_06_0_108:
	dc.b smpsNoAttack, $0C, nFs2, $09, nRst, $03, nB2, $09, nRst, $03, nB2, $1E, nRst, $2A
	smpsReturn

BGM_DUNGEON3_FM3_07_0_144:
	smpsSetvoice	$03
	smpsPan		panLeft, $00
	dc.b nE5, $18, $06, nF5, nE5, $0C, nC5, nA4, nE4, $18, $06, nF4, nE4, $0C, nC4, nA4
	smpsReturn

BGM_DUNGEON3_FM3_08_0_144:
	dc.b nC5, $18, nD5, $0C, nF4, $24, nC5, $18, nD5, $0C, nF4, nG4, nA4
	smpsReturn

BGM_DUNGEON3_FM3_09_0_144:
	dc.b nE5, $18, $06, nF5, nE5, $0C, nC5, nA4, nG5, $18, $06, nA5, nG5, $0C, nE5, nC5
	smpsReturn

BGM_DUNGEON3_FM3_0A_0_144:
	dc.b nA4, $18, nC5, $0C, nD4, $24, nE4, $06, nF4, nG4, nF4, nG4, nA4, nBb4, nC5, nD5
	dc.b nC5, nD5, nE5
	smpsReturn

BGM_DUNGEON3_FM3_0B_0_144:
	dc.b nG5, $06, nFs5, nD5, nB4, nG4, nFs4, nD4, $24, nF5, $06, nE5, nC5, nA4, nF4, nE4
	dc.b nC4, $24
	smpsReturn

BGM_DUNGEON3_FM3_0C_0_144:
	dc.b nDs5, $06, nD5, nBb4, nG4, nDs4, nD4, nBb3, $18, nC4, $0C, nFs4, nCs5, nB4, nE5, $24
	smpsReturn

BGM_DUNGEON3_FM3_0D_0_144:
	dc.b nFs4, $0C, nCs5, nB4, nFs4, $24, $0C, nCs5, nB4, nE5, $24
	smpsReturn

BGM_DUNGEON3_FM3_0E_0_108:
	dc.b nB3, $0C, nCs5, nB4, nB4, $48
	smpsReturn

BGM_DUNGEON3_FM4:

BGM_DUNGEON3_FM4_Jump:
	smpsCall BGM_DUNGEON3_FM4_00_0_144
	smpsCall BGM_DUNGEON3_FM4_01_0_144
	smpsCall BGM_DUNGEON3_FM4_00_0_144
	smpsCall BGM_DUNGEON3_FM4_01_0_144
	smpsCall BGM_DUNGEON3_FM4_03_0_144_6C
	smpsCall BGM_DUNGEON3_FM4_04_0_144
	smpsCall BGM_DUNGEON3_FM4_05_0_144
	smpsCall BGM_DUNGEON3_FM4_06_0_144
	smpsCall BGM_DUNGEON3_FM4_07_0_144
	smpsCall BGM_DUNGEON3_FM4_08_0_108
	smpsCall BGM_DUNGEON3_FM4_09_0_144
	smpsCall BGM_DUNGEON3_FM4_0A_0_144
	smpsCall BGM_DUNGEON3_FM4_09_0_144
	smpsCall BGM_DUNGEON3_FM4_0A_0_144
	smpsCall BGM_DUNGEON3_FM4_0B_0_144
	smpsCall BGM_DUNGEON3_FM4_0C_0_144
	smpsCall BGM_DUNGEON3_FM4_0D_0_144
	smpsCall BGM_DUNGEON3_FM4_0E_0_108
	smpsAlterVol	$03
	smpsJump BGM_DUNGEON3_FM4_Jump

BGM_DUNGEON3_FM4_00_0_144:
	smpsSetvoice	$03
	smpsPan		panLeft, $00
	dc.b nD3, $03, nRst, nA3, nRst, nE4, nRst, nF4, nRst, nC5, nRst, nG5, nRst, nD3, nRst, nA3
	dc.b nRst, nE4, nRst, nF4, nRst, nC5, nRst, nG5, nRst, nD3, nRst, nA3, nRst, nE4, nRst, nF4
	dc.b nRst, nC5, nRst, nG5, nRst, nD3, nRst, nA3, nRst, nE4, nRst, nF4, nRst, nC5, nRst, nG5
	dc.b nRst
	smpsReturn

BGM_DUNGEON3_FM4_01_0_144:
	dc.b nBb2, $03, nRst, nF3, nRst, nC4, nRst, nD4, nRst, nG4, nRst, nC5, nRst, nBb2, nRst, nF3
	dc.b nRst, nC4, nRst, nD4, nRst, nG4, nRst, nC5, nRst, nBb2, nRst, nF3, nRst, nC4, nRst, nD4
	dc.b nRst, nG4, nRst, nC5, nRst, nBb2, nRst, nF3, nRst, nC4, nRst, nD4, nRst, nG4, nRst, nC5
	dc.b nRst
	smpsReturn

BGM_DUNGEON3_FM4_03_0_144_6C:
	dc.b smpsNoAttack, $06
	smpsSetvoice	$00
	smpsAlterVol	$FD
	smpsPan		panRight, $00
	dc.b nE3, $12, nRst, $0C, nA3, $24, nG3, nRst, $06, nAb2, $12, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM4_04_0_144:
	dc.b smpsNoAttack, $06, nE3, $12, nRst, $0C, nA3, $24, nG3, nRst, $06, nAb2, $12, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM4_05_0_144:
	dc.b smpsNoAttack, $06, nE3, $12, nRst, $0C, nA3, $24, nRst, $06, nA2, $12, nC4, $0C, nF3, $06
	dc.b nRst, nDs3, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM4_06_0_144:
	dc.b smpsNoAttack, $06, nE3, $12, nRst, $0C, nA3, $24, nRst, $06, nF3, $12, nRst, nDs3, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM4_07_0_144:
	dc.b smpsNoAttack, $06, nCs3, $12, nRst, nE3, nRst, $0C, nFs3, $06, nRst, nFs3, $36, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM4_08_0_108:
	dc.b nE3, $06, nRst, nE3, $5A, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM4_09_0_144:
	dc.b nD2, $12, nC4, nD2, nC4, nD2, nC4, nD2, nC4
	smpsReturn

BGM_DUNGEON3_FM4_0A_0_144:
	dc.b nBb2, $12, nG4, nBb2, nF4, nBb2, nG4, nBb2, nF4
	smpsReturn

BGM_DUNGEON3_FM4_0B_0_144:
	dc.b nE2, $12, nD4, nE2, nD4, nD2, nC4, nD2, nC4
	smpsReturn

BGM_DUNGEON3_FM4_0C_0_144:
	dc.b nC2, $12, nBb3, nC2, nBb3
	smpsSetvoice	$03
	smpsPan		panLeft, $00
	dc.b nCs4, $48
	smpsReturn

BGM_DUNGEON3_FM4_0D_0_144:
	dc.b nCs4, $48, $48
	smpsReturn

BGM_DUNGEON3_FM4_0E_0_108:
	dc.b nCs4, $24
	smpsSetvoice	$00
	smpsPan		panRight, $00
	dc.b nFs2, $42, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5:

BGM_DUNGEON3_FM5_Jump:
	smpsCall BGM_DUNGEON3_FM5_00_0_144
	smpsCall BGM_DUNGEON3_FM5_01_0_144
	smpsCall BGM_DUNGEON3_FM5_00_0_144
	smpsCall BGM_DUNGEON3_FM5_01_0_144
	smpsCall BGM_DUNGEON3_FM5_02_0_144_6A
	smpsCall BGM_DUNGEON3_FM5_02_0_144
	smpsCall BGM_DUNGEON3_FM5_03_0_144
	smpsCall BGM_DUNGEON3_FM5_04_0_144
	smpsCall BGM_DUNGEON3_FM5_05_0_144
	smpsCall BGM_DUNGEON3_FM5_06_0_108
	smpsCall BGM_DUNGEON3_FM5_07_0_144
	smpsCall BGM_DUNGEON3_FM5_08_0_144
	smpsCall BGM_DUNGEON3_FM5_07_0_144
	smpsCall BGM_DUNGEON3_FM5_08_0_144
	smpsCall BGM_DUNGEON3_FM5_09_0_144
	smpsCall BGM_DUNGEON3_FM5_0A_0_144
	smpsCall BGM_DUNGEON3_FM5_0B_0_144
	smpsCall BGM_DUNGEON3_FM5_0C_0_108
	smpsAlterVol	$05
	smpsJump BGM_DUNGEON3_FM5_Jump

BGM_DUNGEON3_FM5_00_0_144:
	smpsSetvoice	$02
	smpsPan		panCenter, $00
	dc.b nA3, $6C, nG3, $18, nC4, $0C
	smpsReturn

BGM_DUNGEON3_FM5_01_0_144:
	dc.b nD3, $7E, smpsNoAttack, $01, nRst, $11
	smpsReturn

BGM_DUNGEON3_FM5_02_0_144_6A:
	dc.b smpsNoAttack, $0C
	smpsSetvoice	$00
	smpsPan		panRight, $00
	smpsAlterVol	$FB
	dc.b nC4, $12, nRst, $06, nE4, $24, nD4, nRst, $0C, nF3, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_02_0_144:
	dc.b smpsNoAttack, $0C
	dc.b nC4, $12, nRst, $06, nE4, $24, nD4, nRst, $0C, nF3, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_03_0_144:
	dc.b smpsNoAttack, $0C, nC4, $12, nRst, $06, nE4, $24, nRst, $0C, nE3, $12, nRst, $06, nD4, nRst
	dc.b nG3, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_04_0_144:
	dc.b smpsNoAttack, $0C, nC4, $12, nRst, $06, nE4, $24, nRst, $0C, nD4, $18, nRst, $0C, nC4, $18
	smpsReturn

BGM_DUNGEON3_FM5_05_0_144:
	dc.b nRst, $0C, nBb3, $18, nRst, $0C, nB3, $18, nA3, $06, nRst, nA3, $36, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_06_0_108:
	dc.b nG3, $06, nRst, nG3, $5A, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_07_0_144:
	dc.b smpsNoAttack, $06, nA2, $12, nRst, nA2, nRst, nA2, nRst, nA2, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM5_08_0_144:
	dc.b smpsNoAttack, $06, nF3, $12, nRst, nF3, nRst, nF3, nRst, nF3, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM5_09_0_144:
	dc.b smpsNoAttack, $06, nB2, $12, nRst, nB2, nRst, nA2, nRst, nA2, nRst, $0C
	smpsReturn

BGM_DUNGEON3_FM5_0A_0_144:
	dc.b smpsNoAttack, $06, nG2, $12, nRst, nG2, nRst, $0C, nB1, nD3, $12, nRst, $06, nB1, $0C, nD3
	dc.b $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_0B_0_144:
	dc.b nB1, $0C, nD3, $12, nRst, $06, nB1, $0C, nD3, $12, nRst, $06, nB1, $0C, nD3, $12
	dc.b nRst, $06, nB1, $0C, nD3, $12, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM5_0C_0_108:
	dc.b nB1, $0C, nD3, $12, nRst, $06, nD3, $42, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6:

BGM_DUNGEON3_FM6_Jump:
	smpsCall BGM_DUNGEON3_FM6_00_0_144_7F
	smpsCall BGM_DUNGEON3_FM6_01_0_144
	smpsCall BGM_DUNGEON3_FM6_00_0_144
	smpsCall BGM_DUNGEON3_FM6_01_0_144
	smpsCall BGM_DUNGEON3_FM6_02_0_144
	smpsCall BGM_DUNGEON3_FM6_03_0_144
	smpsCall BGM_DUNGEON3_FM6_04_0_144
	smpsCall BGM_DUNGEON3_FM6_05_0_144
	smpsCall BGM_DUNGEON3_FM6_06_0_144_65
	smpsCall BGM_DUNGEON3_FM6_07_0_108
	smpsCall BGM_DUNGEON3_FM6_08_0_144
	smpsCall BGM_DUNGEON3_FM6_09_0_144
	smpsCall BGM_DUNGEON3_FM6_08_0_144
	smpsCall BGM_DUNGEON3_FM6_09_0_144
	smpsCall BGM_DUNGEON3_FM6_0A_0_144
	smpsCall BGM_DUNGEON3_FM6_0B_0_144
	smpsCall BGM_DUNGEON3_FM6_0C_0_144
	smpsCall BGM_DUNGEON3_FM6_0D_0_108
	smpsAlterVol	$0A
	smpsJump BGM_DUNGEON3_FM6_Jump

BGM_DUNGEON3_FM6_00_0_144_7F:
	dc.b smpsNoAttack, $03, nRst, $06
	smpsSetvoice	$01
	smpsPan		panCenter, $00
	smpsAlterNote		$06
	dc.b nA3, $15, nRst, $03, nE4, $04, nF4, nG4, nE4, $0C, nC4, nD4, nA3, $3C, nC4, $03
	smpsReturn

BGM_DUNGEON3_FM6_01_0_144:
	dc.b smpsNoAttack, $05, nRst, $04, nG3, $1E, nRst, $06, nF3, $15, nRst, $03, nC4, $09, nRst, $03
	dc.b nG3, $21, nRst, $03, nF3, $1B
	smpsReturn

BGM_DUNGEON3_FM6_00_0_144:
	dc.b smpsNoAttack, $03, nRst, $06
	dc.b nA3, $15, nRst, $03, nE4, $04, nF4, nG4, nE4, $0C, nC4, nD4, nA3, $3C, nC4, $03
	smpsReturn

BGM_DUNGEON3_FM6_02_0_144:
	dc.b smpsNoAttack, $03, nRst, $0C, nE3, $06, nD3, nE3, nA2, nE3, nC3, nD3, nG2, $0F, nRst, $09
	dc.b nC3, $06, nD3, nF2, $0C, nRst, $06, nBb2, nC3, nF3, nG3, $0F
	smpsReturn

BGM_DUNGEON3_FM6_03_0_144:
	dc.b smpsNoAttack, $06, nRst, $09, nE3, $06, nD3, nE3, nA2, nE3, nC3, nD3, nG2, $0F, nRst, $09
	dc.b nC3, $06, nD3, nF2, $0C, nRst, $06, nBb2, nC3, nF3, nG3, nC3, nC4, $03
	smpsReturn

BGM_DUNGEON3_FM6_04_0_144:
	dc.b smpsNoAttack, $03, nRst, $12, nB3, $06, nC4, nG3, nRst, nA3, $15, nRst, $03, nG3, $06, nF3
	dc.b nE3, $09, nRst, $03, nF3, $0F, nRst, $03, nC3, $06, nD3, $1B
	smpsReturn

BGM_DUNGEON3_FM6_05_0_144:
	dc.b nRst, $15, nB3, $06, nC4, nG3, nRst, nA3, $15, nRst, $03, nC4, $06, nD4, nE4, nF4
	dc.b nD4, $0F, nRst, $09, nD4, $06, nDs4, nC4, $0F
	smpsReturn

BGM_DUNGEON3_FM6_06_0_144_65:
	dc.b nRst, $09, nC4, $06, nCs4, nBb3, $0F, nRst, $09, nBb3, $06, nB3, nAb3, $0F
	smpsSetvoice	$00
	smpsPan		panRight, $00
	smpsAlterNote	$00
	smpsAlterVol	$F6
	dc.b nCs4, $06, nRst, nCs4, $36, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6_07_0_108:
	dc.b nB3, $06, nRst, nB3, $5A, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6_08_0_144:
	dc.b smpsNoAttack, $0C, nF3, $12, nRst, nF3, nRst, nG3, nRst, nF3, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6_09_0_144:
	dc.b smpsNoAttack, $0C, nC4, $12, nRst, nC4, nRst, nC4, nRst, nC4, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6_0A_0_144:
	dc.b smpsNoAttack, $0C, nG3, $12, nRst, nG3, nRst, nF3, nRst, nF3, nRst, $06
	smpsReturn

BGM_DUNGEON3_FM6_0B_0_144:
	dc.b smpsNoAttack, $0C, nDs3, $12, nRst, nDs3, nRst, $0C, nFs2, nA3, $12, nRst, $06, nFs2, $0C, nA3
	dc.b $12
	smpsReturn

BGM_DUNGEON3_FM6_0C_0_144:
	dc.b nRst, $06, nFs2, $0C, nA3, $12, nRst, $06, nFs2, $0C, nA3, $12, nRst, $06, nFs2, $0C
	dc.b nA3, $12, nRst, $06, nFs2, $0C, nA3, $12
	smpsReturn

BGM_DUNGEON3_FM6_0D_0_108:
	dc.b nRst, $06, nFs2, $0C, nA3, $12, $42, nRst, $06
	smpsReturn

BGM_DUNGEON3_PSG1:

BGM_DUNGEON3_PSG1_Jump:
	smpsCall BGM_DUNGEON3_PSG1_00_0_144
	smpsCall BGM_DUNGEON3_PSG1_00_0_144
	smpsCall BGM_DUNGEON3_PSG1_00_0_144
	smpsCall BGM_DUNGEON3_PSG1_00_0_144
	smpsCall BGM_DUNGEON3_PSG1_01_0_144
	smpsCall BGM_DUNGEON3_PSG1_02_0_144
	smpsCall BGM_DUNGEON3_PSG1_03_0_144
	smpsCall BGM_DUNGEON3_PSG1_04_0_144
	smpsCall BGM_DUNGEON3_PSG1_05_0_144_0B
	smpsCall BGM_DUNGEON3_PSG1_06_0_108
	smpsCall BGM_DUNGEON3_PSG1_07_0_144_03
	smpsCall BGM_DUNGEON3_PSG1_08_0_144
	smpsCall BGM_DUNGEON3_PSG1_07_0_144
	smpsCall BGM_DUNGEON3_PSG1_08_0_144
	smpsCall BGM_DUNGEON3_PSG1_09_0_144_08
	smpsCall BGM_DUNGEON3_PSG1_0A_0_144
	smpsCall BGM_DUNGEON3_PSG1_0B_0_144
	smpsCall BGM_DUNGEON3_PSG1_0C_0_108
	smpsJump BGM_DUNGEON3_PSG1_Jump

BGM_DUNGEON3_PSG1_00_0_144:
	dc.b smpsNoAttack, $7E, smpsNoAttack, $12
	smpsReturn

BGM_DUNGEON3_PSG1_01_0_144:
	dc.b smpsNoAttack, $06
	smpsPSGvoice	PSG_DUN03_00
	dc.b nE2, nD2, nE2, nA1, nE2, nC2, nD2, nG1, $0F, nRst, $09, nC2, $06, nD2, nF1, $0C
	dc.b nRst, $06, nBb1, nC2, nF2, nG2, $15, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG1_02_0_144:
	dc.b smpsNoAttack, $06, nE2, nD2, nE2, nA1, nE2, nC2, nD2, nG1, $0F, nRst, $09, nC2, $06, nD2
	dc.b nF1, $0C, nRst, $06, nBb1, nC2, nF2, nG2, nC2, nC3, nRst
	smpsReturn

BGM_DUNGEON3_PSG1_03_0_144:
	dc.b smpsNoAttack, $0C, nB2, $06, nC3, nG2, nRst, nA2, $15, nRst, $03, nG2, $06, nF2, nE2, $09
	dc.b nRst, $03, nF2, $0F, nRst, $03, nC2, $06, nD2, $1B, nRst, $09
	smpsReturn

BGM_DUNGEON3_PSG1_04_0_144:
	dc.b smpsNoAttack, $0C, nB2, $06, nC3, nG2, nRst, nA2, $15, nRst, $03, nC3, $06, nD3, nE3, nF3
	dc.b nD3, $0F, nRst, $09, nD3, $06, nDs3, nC3, $0F, nRst, $09
	smpsReturn

BGM_DUNGEON3_PSG1_05_0_144_0B:
	dc.b nC3, $06, nCs3, nBb2, $0F, nRst, $09, nBb2, $06, nB2, nAb2, $0F, nRst, $15
	smpsPSGvoice	PSG_DUN03_01
	smpsPSGAlterVol	$08
	dc.b nCs2, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b nFs2, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $14
	smpsReturn

BGM_DUNGEON3_PSG1_06_0_108:
	dc.b smpsNoAttack, $0C
	smpsPSGAlterVol	$C0
	dc.b nB1, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b nE2, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $38
	smpsReturn

BGM_DUNGEON3_PSG1_07_0_144_03:
	smpsPSGvoice	PSG_DUN03_00
	smpsPSGAlterVol	$D0
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG1_08_0_144:
	dc.b nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03
	dc.b nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03
	dc.b nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03, nF1, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG1_07_0_144:
	smpsPSGvoice	PSG_DUN03_00
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	dc.b nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03, nE1, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG1_09_0_144_08:
	smpsPSGvoice	PSG_DUN03_02
	smpsPSGAlterVol	$E8
	dc.b nD2, $06, nB1, nG1, nFs1, nD1, nB0, nG0, nB0, nFs1, nG1, nB1, nD2, nC2, nA1, nF1
	dc.b nE1, nC1, nA0, nF0, nA0, nE1, nF1, nA1, nC2
	smpsReturn

BGM_DUNGEON3_PSG1_0A_0_144:
	dc.b nBb1, $06, nG1, nDs1, nD1, nBb0, nG0, nDs0, nG0, nD1, nDs1, nG1, nBb1, nCs2, nA1, nFs1
	dc.b nD1, nB0, nG0, nFs0, nG0, nB0, nD1, nFs1, nA1
	smpsReturn

BGM_DUNGEON3_PSG1_0B_0_144:
	dc.b nCs2, $06, nA1, nFs1, nD1, nB0, nG0, nFs0, nG0, nB0, nD1, nFs1, nA1, nCs2, nA1, nFs1
	dc.b nD1, nB0, nG0, nFs0, nG0, nB0, nD1, nFs1, nA1
	smpsReturn

BGM_DUNGEON3_PSG1_0C_0_108:
	dc.b nCs2, $06, nA1, nFs2, nD2, nA2, nFs2
	smpsPSGvoice	PSG_DUN03_00
	dc.b nCs3, $30, nRst, $18
	smpsReturn

BGM_DUNGEON3_PSG2:

BGM_DUNGEON3_PSG2_Jump:
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_00_0_144
	smpsCall BGM_DUNGEON3_PSG2_01_0_144
	smpsCall BGM_DUNGEON3_PSG2_02_0_144
	smpsCall BGM_DUNGEON3_PSG2_03_0_144_0A
	smpsCall BGM_DUNGEON3_PSG2_04_0_108
	smpsCall BGM_DUNGEON3_PSG2_05_0_144_03
	smpsCall BGM_DUNGEON3_PSG2_06_0_144
	smpsCall BGM_DUNGEON3_PSG2_05_0_144
	smpsCall BGM_DUNGEON3_PSG2_06_0_144
	smpsCall BGM_DUNGEON3_PSG2_07_0_144
	smpsCall BGM_DUNGEON3_PSG2_08_0_144
	smpsCall BGM_DUNGEON3_PSG2_09_0_144
	smpsCall BGM_DUNGEON3_PSG2_0A_0_108
	smpsPSGAlterVol	$F0
	smpsJump BGM_DUNGEON3_PSG2_Jump

BGM_DUNGEON3_PSG2_00_0_144:
	dc.b smpsNoAttack, $7E, smpsNoAttack, $12
	smpsReturn

BGM_DUNGEON3_PSG2_01_0_144:
	dc.b smpsNoAttack, $7E, smpsNoAttack, $12
	smpsReturn

BGM_DUNGEON3_PSG2_02_0_144:
	dc.b smpsNoAttack, $7E, smpsNoAttack, $12
	smpsReturn

BGM_DUNGEON3_PSG2_03_0_144_0A:
	dc.b smpsNoAttack, $54
	smpsPSGvoice	PSG_DUN03_01
	dc.b nA1, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b nCs2, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $14
	smpsReturn

BGM_DUNGEON3_PSG2_04_0_108:
	dc.b smpsNoAttack, $0C
	smpsPSGAlterVol	$C0
	dc.b nFs1, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b nB1, $08
	smpsPSGAlterVol	$20
	dc.b $04
	smpsPSGAlterVol	$E0
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $08
	smpsPSGAlterVol	$20
	dc.b $38
	smpsReturn

BGM_DUNGEON3_PSG2_05_0_144_03:
	smpsPSGvoice	PSG_DUN03_00
	smpsPSGAlterVol	$D0
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_06_0_144:
	dc.b nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03
	dc.b nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03
	dc.b nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03, nBb0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_05_0_144:
	smpsPSGvoice	PSG_DUN03_00
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_07_0_144:
	dc.b nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03
	dc.b nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03
	dc.b nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03, nD1, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_08_0_144:
	dc.b nC1, $09, nRst, $03, nC1, $09, nRst, $03, nC1, $09, nRst, $03, nC1, $09, nRst, $03
	dc.b nC1, $09, nRst, $03, nC1, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03
	dc.b nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_09_0_144:
	dc.b nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03
	dc.b nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03
	dc.b nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG2_0A_0_108:
	dc.b nB0, $09, nRst, $03, nB0, $09, nRst, $03, nB0, $09, nRst, $03, nFs1, $1E, nRst, $2A
	smpsReturn

BGM_DUNGEON3_PSG3:

BGM_DUNGEON3_PSG3_Jump:
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_108
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_00_0_144
	smpsCall BGM_DUNGEON3_PSG3_01_0_144
	smpsCall BGM_DUNGEON3_PSG3_0F_0_144
	smpsCall BGM_DUNGEON3_PSG3_10_0_144
	smpsCall BGM_DUNGEON3_PSG3_11_0_108
	smpsJump BGM_DUNGEON3_PSG3_Jump

BGM_DUNGEON3_PSG3_00_0_144:
	dc.b smpsNoAttack, $7E, smpsNoAttack, $12
	smpsReturn

BGM_DUNGEON3_PSG3_00_0_108:
	dc.b smpsNoAttack, $6C
	smpsReturn

BGM_DUNGEON3_PSG3_01_0_144:
	smpsPSGvoice	PSG_DUN03_00
	dc.b nG0, $09, nRst, $03, nG0, $09, nRst, $03, nG0, $09, nRst, $03, nG0, $09, nRst, $03
	dc.b nG0, $09, nRst, $03, nG0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	dc.b nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03, nA0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG3_0F_0_144:
	dc.b nG0, $09, nRst, $03, nG0, $09, nRst, $03, nG0, $09, nRst, $03, nG0, $09, nRst, $03
	dc.b nG0, $09, nRst, $03, nG0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03
	dc.b nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG3_10_0_144:
	dc.b nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03
	dc.b nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03
	dc.b nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03
	smpsReturn

BGM_DUNGEON3_PSG3_11_0_108:
	dc.b nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nFs0, $09, nRst, $03, nB0, $1E, nRst, $2A
	smpsReturn
