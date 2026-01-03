NKDSHMD_Title_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice	NKDSHMD_Title_Voices
	smpsHeaderChan	$06, $03
	smpsHeaderTempo	$02, $1D

	smpsHeaderDAC	NKDSHMD_Title_DAC
	smpsHeaderFM	NKDSHMD_Title_FM1,  $F4, $19
	smpsHeaderFM	NKDSHMD_Title_FM2,  $F4, $19
	smpsHeaderFM	NKDSHMD_Title_FM3,  $F4, $10
	smpsHeaderFM	NKDSHMD_Title_FM4,  $0C, $19
	smpsHeaderFM	NKDSHMD_Title_FM5,  $F4, $19
	smpsHeaderPSG	NKDSHMD_Title_PSG1, $E8, $06, $00, $00
	smpsHeaderPSG	NKDSHMD_Title_PSG2, $E8, $03, $00, $00
	smpsHeaderPSG	NKDSHMD_Title_PSG3, $00, $02, $00, $00

; FM1 Data
NKDSHMD_Title_FM1:
	smpsSetvoice        $00

NKDSHMD_Title_Loop0A:
	smpsModSet          $05, $01, $02, $03
	smpsCall	NKDSHMD_Title_Call0D
	smpsLoop	$00, $03, NKDSHMD_Title_Loop0A
	smpsModSet          $01, $01, $08, $04
	dc.b	nE6, $06, nRst, $06, nE6, $24
	smpsModOff

NKDSHMD_Title_Loop0B:
	smpsCall	NKDSHMD_Title_Call0E
	smpsLoop	$00, $02, NKDSHMD_Title_Loop0B
	smpsCall	NKDSHMD_Title_Call0F
	dc.b	nA5, $03, nG5, nE5, nG5, nE5, nD5, nC5, nA4
	smpsCall	NKDSHMD_Title_Call0F
	dc.b	nRst, $03, nA4, nB4, nC5, nD5, nE5, nF5, nG5
	smpsJump	NKDSHMD_Title_Loop0B

NKDSHMD_Title_Call0D:
	dc.b	nA5, $03, nA5, nA5, nA5, nA5, $06, nA5, $03, nA5, nA5, $06
	dc.b	nC6, nC6, nD6
	smpsReturn

NKDSHMD_Title_Call0E:
	dc.b	nA5, $03, nA5, nG5, nRst, nA5, nC6, $09, nB5, $03, nB5, nG5
	dc.b	nRst, nB5, nD6, $09, nC6, $03, nC6, nB5, nRst, nC6, smpsNoAttack, nD6
	dc.b	nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nE6, smpsNoAttack, $18
	smpsModOff
	dc.b	nD6, $03, nD6, nC6, nRst, nD6, nF6, $09, nE6, $0C
	smpsModSet          $10, $01, $E0, $FF
	dc.b	nA6, $0C
	smpsModOff
	dc.b	nAb6, $03, nAb6, nFs6, nRst, nAb6, nA6, nRst, nB6
	smpsModSet          $01, $01, $08, $04
	dc.b	smpsNoAttack, $18
	smpsModOff
	dc.b	nC7, $03, nB6, nC7, nD7, nRst, nE7, $06, nD7, $03, nC7, nB6
	dc.b	nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nA6, smpsNoAttack, $0C
	smpsModOff
	dc.b	nB6, $03, nA6, nB6, nC7, nRst, nB6, nRst, nA6, nRst, nG6, nRst
	dc.b	nF6
	smpsModSet          $10, $01, $E0, $FF
	dc.b	nE6, $0C
	smpsModOff
	dc.b	nD6, $03, nD6, nC6, nRst, nD6, nF6, nRst, nE6, nRst, nA6, $09
	dc.b	nE6, $06, nC6, nB5, $03, nB5, nD6, nRst, nC6, nB5, nG5, nA5
	smpsModSet          $01, $01, $08, $04
	dc.b	smpsNoAttack, $18
	smpsModOff
	smpsReturn

NKDSHMD_Title_Call0F:
	dc.b	nA5, $06, nA5, nG5, $03, nA5, nRst, nA5, nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nC6, $09
	smpsModOff
	dc.b	nB5, $06, nG5, nA5, nA5, nG5, $03, nA5, nRst, nA5, nA5, nA6
	dc.b	nB5, nB6, nC6, nC7, nB5, nB6, nA5, $06, nA5, nG5, $03, nA5
	dc.b	nRst, nA5, nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nC6, $09
	smpsModOff
	dc.b	nB5, $06, nG5, nA5, nA5, nG5, $03, nA5, nRst, nA5
	smpsReturn

; FM2 Data
NKDSHMD_Title_FM2:
	smpsSetvoice        $00

NKDSHMD_Title_Loop08:
	smpsModSet          $05, $01, $02, $03
	smpsCall	NKDSHMD_Title_Call0A
	smpsLoop	$00, $03, NKDSHMD_Title_Loop08
	smpsModSet          $01, $01, $08, $04
	dc.b	nB5, $06, nRst, $06, nB5, $24
	smpsModOff

NKDSHMD_Title_Loop09:
	smpsCall	NKDSHMD_Title_Call0B
	smpsLoop	$00, $02, NKDSHMD_Title_Loop09
	smpsCall	NKDSHMD_Title_Call0C
	dc.b	nE5, $03, nD5, nC5, nD5, nC5, nB4, nA4, nG4
	smpsCall	NKDSHMD_Title_Call0C
	dc.b	nRst, $03, nE4, nF4, nG4, nA4, nB4, nC5, nD5
	smpsJump	NKDSHMD_Title_Loop09

NKDSHMD_Title_Call0A:
	dc.b	nE5, $03, nE5, nE5, nE5, nE5, $06, nE5, $03, nE5, nE5, $06
	dc.b	nG5, nG5, nA5
	smpsReturn

NKDSHMD_Title_Call0B:
	dc.b	nE5, $03, nE5, nE5, nRst, nE5, nA5, $09, nG5, $03, nG5, nD5
	dc.b	nRst, nG5, nB5, $09, nA5, $03, nA5, nF5, nRst, nA5, smpsNoAttack, nB5
	dc.b	nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nB5, smpsNoAttack, $18
	smpsModOff
	dc.b	nA5, $03, nA5, nA5, nRst, nA5, nD6, $09, nC6, $0C
	smpsModSet          $10, $01, $E0, $FF
	dc.b	nE6
	smpsModOff
	dc.b	nE6, $03, nE6, nE6, nRst, nE6, nE6, nRst, nAb6
	smpsModSet          $01, $01, $08, $04
	dc.b	smpsNoAttack, $18
	smpsModOff
	dc.b	nA6, $03, nA6, nA6, nA6, nRst, nC7, $06, nA6, $03, nA6, nA6
	dc.b	nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nE6, smpsNoAttack, $0C
	smpsModOff
	dc.b	nG6, $03, nG6, nG6, nG6, nRst, nG6, nRst, nG6, nRst, nD6, nRst
	dc.b	nD6
	smpsModSet          $10, $01, $E0, $FF
	dc.b	nB5, $0C
	smpsModOff
	dc.b	nA5, $03, nA5, nA5, nRst, nA5, nD6, nRst, nC6, nRst, $03, nE6
	dc.b	$09, nC6, $06, nA5, nAb5, $03, nAb5, nB5, nRst, nA5, nG5, nD5
	dc.b	nE5
	smpsModSet          $01, $01, $08, $04
	dc.b	smpsNoAttack, $18
	smpsModOff
	smpsReturn

NKDSHMD_Title_Call0C:
	dc.b	nE5, $06, nE5, nD5, $03, nE5, nRst, nE5, nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nG5, $09
	smpsModOff
	dc.b	nFs5, $06, nD5, nE5, nE5, nD5, $03, nE5, nRst, nE5, nE5, nE6
	dc.b	nFs5, nFs6, nG5, nG6, nFs5, nFs6, nE5, $06, nE5, nD5, $03, nE5
	dc.b	nRst, nE5, nRst
	smpsModSet          $01, $01, $08, $04
	dc.b	nG5, $09
	smpsModOff
	dc.b	nFs5, $06, nD5, nE5, nE5, nD5, $03, nE5, nRst, nE5
	smpsReturn

; FM3 Data
NKDSHMD_Title_FM3:
	smpsSetvoice        $03

NKDSHMD_Title_Loop06:
	smpsCall	NKDSHMD_Title_Call07
	smpsLoop	$00, $03, NKDSHMD_Title_Loop06
	dc.b	nE4, $06, nRst, $06, nE4, $24

NKDSHMD_Title_Loop07:
	smpsCall	NKDSHMD_Title_Call08
	smpsLoop	$00, $02, NKDSHMD_Title_Loop07
	smpsCall	NKDSHMD_Title_Call09
	dc.b	nA4, $03, nG4, nE4, nG4, nE4, nD4, nC4, nA3
	smpsCall	NKDSHMD_Title_Call09
	dc.b	nRst, $18
	smpsJump	NKDSHMD_Title_Loop07

NKDSHMD_Title_Call07:
	dc.b	nA3, $0C, nA3, $12, nC4, $06, nC4, nD4
	smpsReturn

NKDSHMD_Title_Call08:
	dc.b	nA3, $06, nA4, nA3, nA4, nG3, nG4, nG3, nG4, nF3, nF4, nF3
	dc.b	nF4, nE3, nE4, nE3, nE4, nD4, nD5, nD4, nD5, nA3, nA4, nA3
	dc.b	nA4, nB3, nB4, nB3, nB4, nE4, nE5, nE4, nE5, nA3, nA4, nA3
	dc.b	nA4, nA3, nA4, nA3, nA4, nG3, nG4, nG3, nG4, nG3, nG4, nG3
	dc.b	nG4, nD4, nD5, nD4, nD5, nA3, nA4, nA3, nA4, nE4, nE5, nE4
	dc.b	nE5, nA3, nA4, nA3, nA4
	smpsReturn

NKDSHMD_Title_Call09:
	dc.b	nA3, $06, nA3, nG3, $03, nA3, nRst, nA3, nRst, nC4, $09, nB3
	dc.b	$06, nG3, nA3, nA3, nG3, $03, nA3, nRst, nA3, nA3, nA4, nB3
	dc.b	nB4, nC4, nC5, nB3, nB4, nA3, $06, nA3, nG3, $03, nA3, nRst
	dc.b	nA3, nRst, nC4, $09, nB3, $06, nG3, nA3, nA3, nG3, $03, nA3
	dc.b	nRst, nA3
	smpsReturn

; FM4 Data
NKDSHMD_Title_FM4:
	smpsPan             panLeft, $00
	smpsAlterPitch      $DC

NKDSHMD_Title_Loop03:
	smpsSetvoice        $06
	smpsModSet          $05, $01, $02, $03
	smpsCall	NKDSHMD_Title_Call06
	smpsLoop	$00, $03, NKDSHMD_Title_Loop03
	smpsModSet          $01, $01, $08, $04
	dc.b	nB5, $06, nRst, $06, nB5, $24
	smpsModOff
	smpsAlterPitch      $24

NKDSHMD_Title_Loop04:
	smpsSetvoice        $05
	dc.b	nE3, $18, nD3, nC3, nB2, nD3, nA2, nB2, nD3, nC3, $30, nB2
	dc.b	$30, nD3, $18, nC3, nB2, nA2
	smpsLoop	$00, $02, NKDSHMD_Title_Loop04

NKDSHMD_Title_Loop05:
	dc.b	nRst, $30
	smpsLoop	$00, $08, NKDSHMD_Title_Loop05
	smpsJump	NKDSHMD_Title_Loop04

NKDSHMD_Title_Call06:
	dc.b	nE5, $06, nRst, $06
	smpsModSet          $01, $01, $08, $04
	dc.b	nE5, $12
	smpsModOff
	dc.b	nG5, $06, nG5, nA5
	smpsReturn

; FM5 Data
NKDSHMD_Title_FM5:
	smpsPan             panRight, $00
	smpsAlterPitch      $DC

NKDSHMD_Title_Loop01:
	smpsSetvoice        $06
	smpsModSet          $05, $01, $02, $03
	smpsCall	NKDSHMD_Title_Call03
	smpsLoop	$00, $03, NKDSHMD_Title_Loop01
	smpsModSet          $01, $01, $08, $04
	dc.b	nE6, $06, nRst, $06, nE6, $24
	smpsModOff
	smpsAlterPitch      $24

NKDSHMD_Title_Loop02:
	smpsSetvoice        $04
	smpsCall	NKDSHMD_Title_Call04
	smpsLoop	$00, $02, NKDSHMD_Title_Loop02
	smpsCall	NKDSHMD_Title_Call05
	dc.b	nA5, $03, nG5, nE5, nG5, nE5, nD5, nC5, nA4
	smpsCall	NKDSHMD_Title_Call05
	dc.b	nRst, $03, nA4, nB4, nC5, nD5, nE5, nF5, nG5
	smpsJump	NKDSHMD_Title_Loop02

NKDSHMD_Title_Call03:
	dc.b	nA5, $06, nRst, $06
	smpsModSet          $01, $01, $08, $04
	dc.b	nA5, $12
	smpsModOff
	dc.b	nC6, $06, nC6, nD6
	smpsReturn

NKDSHMD_Title_Call04:
	dc.b	nA5, $03, nA5, nG5, nRst, nA5, nC6, $09, nB5, $03, nB5, nG5
	dc.b	nRst, nB5, nD6, $09, nC6, $03, nC6, nB5, nRst, nC6, nD6, nRst
	dc.b	nE6, smpsNoAttack, $18, nD6, $03, nD6, nC6, nRst, nD6, nF6, $09, nE6
	dc.b	$0C, nA6, $0C, nAb6, $03, nAb6, nFs6, nRst, nAb6, nA6, nRst, nB6
	dc.b	smpsNoAttack, $18, nC7, $03, nB6, nC7, nD7, nRst, nE7, $06, nD7, $03
	dc.b	nC7, nB6, nRst, nA6, smpsNoAttack, $0C, nB6, $03, nA6, nB6, nC7, nRst
	dc.b	nB6, nRst, nA6, nRst, nG6, nRst, nF6, nE6, $0C, nD6, $03, nD6
	dc.b	nC6, nRst, nD6, nF6, nRst, nE6, nRst, nA6, $09, nE6, $06, nC6
	dc.b	nB5, $03, nB5, nD6, nRst, nC6, nB5, nG5, nA5, smpsNoAttack, $18
	smpsReturn

NKDSHMD_Title_Call05:
	dc.b	nA5, $06, nA5, nG5, $03, nA5, nRst, nA5, nRst, nC6, $09, nB5
	dc.b	$06, nG5, nA5, nA5, nG5, $03, nA5, nRst, nA5, nA5, nA6, nB5
	dc.b	nB6, nC6, nC7, nB5, nB6, nA5, $06, nA5, nG5, $03, nA5, nRst
	dc.b	nA5, nRst, nC6, $09, nB5, $06, nG5, nA5, nA5, nG5, $03, nA5
	dc.b	nRst, nA5
	smpsReturn

; PSG1 Data
NKDSHMD_Title_PSG1:
;	dc.b	nRst, $04
	smpsStop

; PSG2 Data
NKDSHMD_Title_PSG2:
	dc.b	nRst, $60, nRst, $60

NKDSHMD_Title_Loop0D:
	dc.b	nE3, $18, nD3, nC3, nB2, nD3, nA2, nB2, nD3, nC3, $30, nB2
	dc.b	nD3, $18, nC3, nB2, nA2
	smpsLoop	$00, $02, NKDSHMD_Title_Loop0D

	dc.b	nRst, $60, nRst, $60, nRst, $60, nRst, $60
	smpsJump	NKDSHMD_Title_Loop0D

; PSG3 Data
NKDSHMD_Title_PSG3:
	dc.b	nRst, $60, nRst, $60
	smpsPSGform         $E7
	smpsPSGvoice        fTone_02

NKDSHMD_Title_Loop0F:
	dc.b	nMaxPSG, $03, $03, $03, $03, nMaxPSG, $03, $03, $03, $03, nMaxPSG, $03
	dc.b	$03, $03, $03, nMaxPSG, $03, $03, $03, $03
	smpsLoop	$00, $18, NKDSHMD_Title_Loop0F
	smpsJump	NKDSHMD_Title_Loop0F

; DAC Data
NKDSHMD_Title_DAC:
	dc.b	dQuickLooseSnare, $03, $03, $03, $03, $06, $03, $03, $06, $06, $06, $06
	smpsLoop	$00, $03, NKDSHMD_Title_DAC
	dc.b	$0C, $0C
	dc.b	dKickS3, $03, dElectricHighTom, dElectricHighTom, dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom

NKDSHMD_Title_Loop00:
	smpsCall	NKDSHMD_Title_Call00
	dc.b	dElectricHighTom, $03, dElectricHighTom, dElectricMidTom, dElectricMidTom, dElectricLowTom, dElectricLowTom, dElectricFloorTom, dElectricFloorTom
	smpsCall	NKDSHMD_Title_Call00
	dc.b	dSnareS3, $03, $06, $03, $03, $06, $03
	smpsLoop	$00, $02, NKDSHMD_Title_Loop00
	smpsCall	NKDSHMD_Title_Call01
	dc.b	dKickS3, $06, dSnareS3, $03, $03, $06, $03, $03, $03, $03
	smpsCall	NKDSHMD_Title_Call01
	dc.b	dKickS3, $0C, dSnareS3, $03, $09, $03, $03
	smpsJump	NKDSHMD_Title_Loop00

NKDSHMD_Title_Call00:
	dc.b	dKickS3, $0C, dSnareS3

NKDSHMD_Title_Loop10:
	dc.b	dKickS3, $06, dKickS3, dSnareS3, $0C, dKickS3, dSnareS3
	smpsLoop	$01, $03, NKDSHMD_Title_Loop10
	smpsReturn

NKDSHMD_Title_Call01:
	dc.b	dKickS3, $06, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3
	dc.b	nRst, $03, dSnareS3, $09, dSnareS3, $06, dSnareS3, $03, dSnareS3
	dc.b	dKickS3, $06, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3, dKickS3, dKickS3, dKickS3, dSnareS3
	smpsReturn

NKDSHMD_Title_Voices:
;	Voice $00
;	$3D
;	$01, $03, $01, $01, 	$8E, $52, $14, $4C, 	$08, $08, $0E, $03
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$1B, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $03, $01
	smpsVcRateScale     $01, $00, $01, $02
	smpsVcAttackRate    $0C, $14, $12, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $08, $08
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $1B

;	Voice $01
;	$02
;	$00, $00, $00, $00, 	$5C, $54, $1C, $D0, 	$0C, $08, $0A, $05
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$24, $1B, $22, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $03, $00, $01, $01
	smpsVcAttackRate    $10, $1C, $14, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $0A, $08, $0C
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $22, $1B, $24

;	Voice $02
;	$38
;	$63, $41, $02, $01, 	$10, $10, $15, $1F, 	$00, $02, $03, $02
;	$05, $02, $02, $02, 	$5F, $5F, $AF, $3F, 	$1C, $28, $14, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $04, $06
	smpsVcCoarseFreq    $01, $02, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $15, $10, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $03, $02, $00
	smpsVcDecayRate2    $02, $02, $02, $05
	smpsVcDecayLevel    $03, $0A, $05, $05
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $28, $1C

;	Voice $03
;	$20
;	$67, $66, $60, $62, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$2F, $1F, $1F, $FF, 	$1C, $3A, $16, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $06, $06, $06
	smpsVcCoarseFreq    $02, $00, $06, $07
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $16, $3A, $1C

;	Voice $04
;	$16
;	$17, $14, $31, $31, 	$1F, $1F, $1F, $1F, 	$0C, $0B, $0A, $08
;	$04, $02, $03, $05, 	$15, $F7, $07, $25, 	$1C, $8A, $8A, $8A
	smpsVcAlgorithm     $06
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $01, $01
	smpsVcCoarseFreq    $01, $01, $04, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $0A, $0B, $0C
	smpsVcDecayRate2    $05, $03, $02, $04
	smpsVcDecayLevel    $02, $00, $0F, $01
	smpsVcReleaseRate   $05, $07, $07, $05
	smpsVcTotalLevel    $0A, $0A, $0A, $1C

;	Voice $05
;	$3C
;	$63, $61, $62, $33, 	$1F, $0F, $1F, $0F, 	$0C, $10, $07, $10
;	$02, $06, $04, $06, 	$12, $16, $12, $16, 	$1C, $8C, $12, $8C
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $06, $06, $06
	smpsVcCoarseFreq    $03, $02, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $1F, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $07, $10, $0C
	smpsVcDecayRate2    $06, $04, $06, $02
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $06, $02, $06, $02
	smpsVcTotalLevel    $0C, $12, $0C, $1C

;	Voice $06
;	$2C
;	$74, $74, $34, $34, 	$1F, $12, $1F, $1F, 	$00, $00, $00, $00
;	$00, $01, $00, $01, 	$0F, $3F, $0F, $3F, 	$16, $80, $17, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $04, $04, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $01, $00, $01, $00
	smpsVcDecayLevel    $03, $00, $03, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $00, $16

