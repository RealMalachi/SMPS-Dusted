; https://www.dropbox.com/scl/fi/7y7bja0lrhsm961f4013g/SONIC-DMF.zip?rlkey=z4twlkj185wewrat539ydc44n&e=2&dl=0
BGM_SonicExe_Piano_Header:
	smpsHeaderStartSong	$F0E50000
	smpsHeaderVoice		BGM_SonicExe_Piano_Voices
	smpsHeaderChan		$06, $00, $00
	smpsHeaderTempo		$0F, $8000	; 15.00 BPM
	smpsHeaderFM	BGM_SonicExe_Piano_FM1,	$00, $00
	smpsHeaderFM	BGM_SonicExe_Piano_FM2,	$00, $00
	smpsHeaderFM	BGM_SonicExe_Piano_FM3,	$00, $00
	smpsHeaderFM	BGM_SonicExe_Piano_FM4,	$00, $00
	smpsHeaderFM	BGM_SonicExe_Piano_FM5,	$00, $00
	smpsHeaderFM	BGM_SonicExe_Piano_FM6,	$00, $0F

BGM_SonicExe_Piano_CallDelay2:
	dc.b nRst, $10, nRst, $10
BGM_SonicExe_Piano_CallDelay:
	dc.b nRst, $10, nRst, $10
	smpsReturn

BGM_SonicExe_Piano_FM1:
	smpsComm	$00
	smpsSetLFORate	$0C
BGM_SonicExe_Piano_FM1_Jump:
	smpsCall	BGM_SonicExe_Piano_CallDelay2

	smpsSetvoice	$02
	dc.b nCs4, $01, nB3, nCs4, nD4, nG4, nD4, nCs4, nB3, nCs4, $03, nAb3, $01, nBb3, $02, nB3
	dc.b nD4, $04, nCs4, $03, nB3, $01, nFs3, $07, $01

	dc.b nFs4, $03, nE4, $01, nD4, $02, nCs4, nE4, nD4, nFs3, nAb3, nD4, $04, nCs4, $03, nFs3
	dc.b $01, nB3, $02, nBb3, nG3, nA3

	dc.b nFs3, $01
	smpsSetvoice	$03
	dc.b nFs4, nFs5, nE5, nD5, $04, nRst, $01, nFs4, nE5, nD5, nCs5, $02, nB4, nB5, nA5, nG5
	dc.b nFs5, nA5, $03, nG5, $01, nFs5, $02, nE5

	smpsSetvoice	$02
	smpsPan		panLeft, $00
	dc.b nB2, $01
	smpsSetvoice	$03
	smpsPan		panRight, $00
	dc.b nFs4
	smpsPan		panLeft, $00
	dc.b nB4, nCs5
	smpsPan		panRight, $00
	dc.b nD5, nCs5
	smpsPan		panLeft, $00
	dc.b nB4, nFs4
	smpsSetvoice	$02
	smpsPan		panRight, $00
	dc.b nB2
	smpsSetvoice	$03
	smpsPan		panLeft, $00
	dc.b nFs4
	smpsPan		panRight, $00
	dc.b nCs5, nD5
	smpsPan		panLeft, $00
	dc.b nB5, nA5
	smpsPan		panRight, $00
	dc.b nG5, nFs5
	smpsSetvoice	$02
	smpsPan		panLeft, $00
	dc.b nB2
	smpsSetvoice	$03
	smpsPan		panRight, $00
	dc.b nB4
	smpsPan		panLeft, $00
	dc.b nE5, nFs5
	smpsPan		panRight, $00
	dc.b nG5, nFs5
	smpsPan		panLeft, $00
	dc.b nA5, nG5
	smpsPan		panCenter, $00
	dc.b nFs5, $02, nE5, nD5, nCs5

	smpsSetvoice	$02
	dc.b nB3, $01, nD3, nFs3, nD3, nCs4, nD3, nFs3, nD3, nD4, nD3, nFs3, nD3, nE4, nFs3, nD4
	dc.b nCs4, nB3
	smpsSetvoice	$03
	dc.b nE5, nFs5, nE5, nG5, nFs5, nA5, nG5, nFs5, $02, nE5, nCs5, nD5

	smpsSetvoice	$02
	dc.b nCs4, $01, nB3, nD3, nA3, nG3, $02, nFs3, nFs4, $01, nE4, nFs3, nD4, nCs4, $02, nB3
	dc.b nG4, $01, nFs4, nA4, nG4, nFs4, nE4, nG4, nFs4, nE4, nD4, nCs4, nFs3, nB3, $02, nBb3

	smpsCommJump	BGM_SonicExe_Piano_FM1_Jump
	dc.b nB3, $10
BGM_SonicExe_Piano_DAC:
	smpsStop


BGM_SonicExe_Piano_FM2:
	smpsSetvoice	$00
BGM_SonicExe_Piano_FM2_Jump:
	smpsCall	BGM_SonicExe_Piano_FM2_Call1

BGM_SonicExe_Piano_FM2_Loop1:
	dc.b nG2
	smpsLoop	0,7,BGM_SonicExe_Piano_FM2_Loop1
	smpsCall	BGM_SonicExe_Piano_FM2_Call2

	smpsSetTranspose	$F4	; down one octave
	smpsCall	BGM_SonicExe_Piano_FM2_Call1
	smpsSetTranspose	$00

BGM_SonicExe_Piano_FM2_Loop2:
	dc.b nCs2
	smpsLoop	0,7,BGM_SonicExe_Piano_FM2_Loop2
	smpsCall	BGM_SonicExe_Piano_FM2_Call2

BGM_SonicExe_Piano_FM2_Loop3:
	dc.b nB1
	smpsLoop	1,7,BGM_SonicExe_Piano_FM2_Loop3
	dc.b nDs2, nE2, nE2, nG2, nF2, nFs2, nFs2, nD2, nBb1
	smpsLoop	0,4,BGM_SonicExe_Piano_FM2_Loop3

	smpsCommJump	BGM_SonicExe_Piano_FM2_Jump
	dc.b nE2, $10
	smpsStop

BGM_SonicExe_Piano_FM2_Call1:
	dc.b nE3, $02
	smpsLoop	0,7,BGM_SonicExe_Piano_FM2_Call1
	dc.b nBb2
BGM_SonicExe_Piano_FM2_Loop4:
	dc.b nB2
	smpsLoop	0,7,BGM_SonicExe_Piano_FM2_Loop4
	dc.b nDs3
	smpsReturn

BGM_SonicExe_Piano_FM2_Call2:
	dc.b nF2
BGM_SonicExe_Piano_FM2_Loop5:
	dc.b nFs2
	smpsLoop	0,6,BGM_SonicExe_Piano_FM2_Loop5
	dc.b nD2, nBb1
	smpsReturn


BGM_SonicExe_Piano_FM3:
	smpsSetvoice	$01
BGM_SonicExe_Piano_FM3_Jump:
	smpsCall	BGM_SonicExe_Piano_FM3_Call1
BGM_SonicExe_Piano_FM3_Loop1:
	dc.b nG1
	smpsLoop	0,7,BGM_SonicExe_Piano_FM3_Loop1
	dc.b nFs1, nD1, nD1, nE1, nE1, nE1, nE1, nDs1, nE1

	smpsCall	BGM_SonicExe_Piano_FM3_Call1
BGM_SonicExe_Piano_FM3_Loop2:
	dc.b nE1
	smpsLoop	0,8,BGM_SonicExe_Piano_FM3_Loop2
	dc.b nFs1, nFs1, nG1, nG1, nE1, nE1, nE1, nF1

BGM_SonicExe_Piano_FM3_Loop3:
	dc.b nD1
	smpsLoop	1,7,BGM_SonicExe_Piano_FM3_Loop3
	dc.b nDs1, nE1, nE1, nE1, nF1, nG1, nFs1, nF1, nE1
	smpsLoop	0,2,BGM_SonicExe_Piano_FM3_Loop3

	smpsCall	BGM_SonicExe_Piano_FM3_Call2
	dc.b nF1, nE1
	smpsCall	BGM_SonicExe_Piano_FM3_Call2
	dc.b nE1, $04

	smpsCommJump	BGM_SonicExe_Piano_FM3_Jump
	dc.b nG1, $10
	smpsStop

BGM_SonicExe_Piano_FM3_Call1:
	dc.b nG1, $02
	smpsLoop	0,8,BGM_SonicExe_Piano_FM3_Call1
BGM_SonicExe_Piano_FM3_Loop4:
	dc.b nD1
	smpsLoop	0,8,BGM_SonicExe_Piano_FM3_Loop4
	smpsReturn

BGM_SonicExe_Piano_FM3_Call2:
	dc.b nD1, $04, $04, $04, $02, nDs1, nE1, $04, $02, nF1, nG1, nFs1
	smpsReturn


BGM_SonicExe_Piano_FM4:
	smpsSetvoice	$01
BGM_SonicExe_Piano_FM4_Jump:
	smpsCall	BGM_SonicExe_Piano_FM4_Call1

	dc.b nB1, nB1, nBb1, nBb1, nB1, nB1, nB1, nBb1
	dc.b nFs1, nFs1, nFs1, nFs1, nG1, nG1, nG1, nFs1

	smpsCall	BGM_SonicExe_Piano_FM4_Call1

BGM_SonicExe_Piano_FM4_Loop1:
	dc.b nG1
	smpsLoop	0,8,BGM_SonicExe_Piano_FM4_Loop1
	dc.b nB1, nB1, nB1, nB1, nG1, nG1, nAb1, nBb1

BGM_SonicExe_Piano_FM4_Loop2:
	dc.b nFs1, nFs1, nG1, nG1, nAb1, nAb1, nA1, nAb1
	dc.b nG1, nG1, nG1, nG1, nB1, nB1, nB1, nBb1
	smpsLoop	0,2,BGM_SonicExe_Piano_FM4_Loop2

	smpsCall	BGM_SonicExe_Piano_FM4_Call2
	dc.b nB1, nBb1

	smpsCall	BGM_SonicExe_Piano_FM4_Call2
	dc.b nBb1, $04

	smpsCommJump	BGM_SonicExe_Piano_FM4_Jump
	dc.b nB1, $10
	smpsStop

BGM_SonicExe_Piano_FM4_Call1:
	dc.b nB1, $02
	smpsLoop	0,8,BGM_SonicExe_Piano_FM4_Call1
BGM_SonicExe_Piano_FM4_Loop3:
	dc.b nFs1
	smpsLoop	0,8,BGM_SonicExe_Piano_FM4_Loop3
	smpsReturn

BGM_SonicExe_Piano_FM4_Call2:
	dc.b nFs1, $04, nG1, nAb1, nA1, $02, nAb1, nG1, $04, $02, $02, nB1, nB1
	smpsReturn


BGM_SonicExe_Piano_FM5:
	smpsSetvoice	$01
BGM_SonicExe_Piano_FM5_Jump:
	smpsCall	BGM_SonicExe_Piano_FM5_Call1

	dc.b nCs2, nCs2, nCs2, nCs2, nE2, nE2, nFs2, nE2
	dc.b nD2, nD2, nCs2, nCs2, nB1, nB1, nBb1, nB1

	smpsCall	BGM_SonicExe_Piano_FM5_Call1

	dc.b nB1, nB1, nBb1, nBb1, nB1, nB1, nCs2, nCs2
	dc.b nCs2, nCs2, nE2, nE2, nCs2, nCs2, nD2, nD2

BGM_SonicExe_Piano_FM5_Loop1:
	dc.b nB1
	smpsLoop	1,10,BGM_SonicExe_Piano_FM5_Loop1
	dc.b nC2, nC2, nD2, nD2, nCs2, nCs2
	smpsLoop	0,2,BGM_SonicExe_Piano_FM5_Loop1

	smpsCall	BGM_SonicExe_Piano_FM5_Call2
	dc.b nCs2, nCs2

	smpsCall	BGM_SonicExe_Piano_FM5_Call2
	dc.b nCs2, $04

	smpsCommJump	BGM_SonicExe_Piano_FM5_Jump
	dc.b nE2, $10
	smpsStop

BGM_SonicExe_Piano_FM5_Call1:
	dc.b nE2, $02, nE2, nDs2, nDs2, nD2, nD2, nCs2, nCs2
	dc.b nB1, nB1, nBb1, nBb1, nA1, nA1, nAb1, nAb1
	smpsReturn

BGM_SonicExe_Piano_FM5_Call2:
	dc.b nB1, $04, $04, $04, $02, $02, $04, nC2, $02, nC2, nD2, nD2
	smpsReturn


BGM_SonicExe_Piano_FM6:
	smpsSetvoice	$03
BGM_SonicExe_Piano_FM6_Jump:
	smpsCall	BGM_SonicExe_Piano_CallDelay2
	smpsCall	BGM_SonicExe_Piano_CallDelay2
	smpsCall	BGM_SonicExe_Piano_CallDelay
	dc.b nB2, $01, nFs4, nB4, nCs5, nD5, nCs5, nB4, nFs4, nB2, nFs4, nCs5, nD5, nB5, nA5, nG5
	dc.b nFs5, nB2, nB4, nE5, nFs5, nG5, nFs5, nA5, nG5, nRst, $08
	smpsCall	BGM_SonicExe_Piano_CallDelay2
	smpsCommJump	BGM_SonicExe_Piano_FM6_Jump
	smpsStop


BGM_SonicExe_Piano_Voices:
;	FM Voice 00 -> 00: Bass
	smpsVcAlgorithm		$00
	smpsVcFeedback		$00
	smpsVcDetune		$03, $03, $03, $02
	smpsVcCoarseFreq	$01, $00, $02, $05
	smpsVcRateScale		$02, $01, $03, $02
	smpsVcAttackRate	$1D, $1D, $1D, $1D
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$00, $09, $06, $07
	smpsVcDecayRate2	$06, $06, $06, $00
	smpsVcDecayLevel	$0F, $00, $01, $03
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$10, $14, $3A, $1C

;	FM Voice 01 -> 01: Piano
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
	smpsVcAmsPms		$00, $02
	smpsVcDetune		$01, $02, $03, $03
	smpsVcCoarseFreq	$04, $0C, $0C, $0C
	smpsVcRateScale		$00, $01, $02, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $07, $06, $02
	smpsVcDecayRate2	$06, $09, $1F, $1F
	smpsVcDecayLevel	$01, $01, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$16, $25, $2B, $3D

;	FM Voice 02 -> 02: Piano
	smpsVcAlgorithm		$02
	smpsVcFeedback		$07
	smpsVcAmsPms		$00, $02
	smpsVcDetune		$01, $02, $03, $03
	smpsVcCoarseFreq	$02, $06, $06, $06
	smpsVcRateScale		$00, $01, $02, $01
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $08, $06, $02
	smpsVcDecayRate2	$07, $09, $1F, $1F
	smpsVcDecayLevel	$01, $03, $0F, $0F
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$14, $25, $2B, $3D

;	FM Voice 03 -> 03: Old Bell
	smpsVcAlgorithm		$04
	smpsVcFeedback		$05
	smpsVcDetune		$07, $07, $00, $03
	smpsVcCoarseFreq	$04, $0E, $01, $03
	smpsVcRateScale		$00, $00, $01, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1B
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$08, $07, $07, $04
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcDecayLevel	$0E, $0D, $0E, $0E
	smpsVcReleaseRate	$0F, $03, $0F, $05
	smpsVcTotalLevel	$20, $27, $1A, $22
