BGM_EraserVS_Header:
	smpsHeaderStartSong $F0E50000
	smpsHeaderVoice     BGM_EraserVS_Voices
	smpsHeaderChan      $06, $00, $01
	smpsHeaderTempo     $01, $6000

	smpsHeaderDAC       BGM_EraserVS_DAC
	smpsHeaderFM        BGM_EraserVS_FM1,	$0C, $0A
	smpsHeaderFM        BGM_EraserVS_FM2,	$00, $0A+9
	smpsHeaderFM        BGM_EraserVS_FM6,	$00, $06
	smpsHeaderFM        BGM_EraserVS_FM3,	$00, $00
	smpsHeaderFM        BGM_EraserVS_FM4,	$00, $08+9
	smpsHeaderFM        BGM_EraserVS_FM5,	$0C, $08+9

; FM1 Data
BGM_EraserVS_FM1:
	smpsSetvoice        $03
	smpsPan             panRight, $00

BGM_EraserVS_Loop0B:
	dc.b	nG1, $06, nG2, nA1, nA2, nB1, nB2, nC2, nC3, nRst, $29
	smpsLoop            $01, $02, BGM_EraserVS_Loop0B
	dc.b	nG1, $06, nG2, nA1, nA2, nB1, nB2, nC2, nC3, nG1, nG2, nA1
	dc.b	nA2, nC2, nC3, nE2, nE3, nF2, nF3, nF2, nF3, nF2, nF3, nG2
	dc.b	nG3, nG2, nG3, nG2, nG3
	smpsLoop            $00, $02, BGM_EraserVS_Loop0B
	dc.b	nE2, nE3, nE2, nE3, nE2, nE3, nE2, nD3, nCs3, nB2, nE2, nE3
	dc.b	nA1, nA2, nA1, nA2, nA2, nA1, nG1, nG2, nG1, nG2, nG2, nG1
	dc.b	nF1, nF2, nE1, nE2, nEb1, nEb2, nD1, nD2, nCs1, nCs2, nCs1, nCs2
	dc.b	nA1, nA2, nA2, nA1, nA2, nA1, nG1, nG2, nG2, nG1, nG2, nG1
	dc.b	nF2, nF2, nRst, nCs2, nB1, nEb2, nRst, nAb2, nRst, nG2, nG1, nG2
	dc.b	nG1, nG2, $0C, nBb2, nG2, nD2, $06, nEb2, nF2
	smpsJump            BGM_EraserVS_Loop0B

; FM2 Data
BGM_EraserVS_FM2:
	smpsSetvoice        $00
	smpsModSet          $36, $01, $0E, $7E, 0

BGM_EraserVS_Loop08:
	dc.b	nB4, $18, smpsNoAttack, nB4, $06, nB4, smpsNoAttack, nB4, nC5, nRst, $29
	smpsLoop            $01, $02, BGM_EraserVS_Loop08
	dc.b	nB4, $18, smpsNoAttack, nB4, $06, nB4, smpsNoAttack, nB4, nC5, smpsNoAttack, nC5, $18
	dc.b	smpsNoAttack, nC5, $06, nC5, smpsNoAttack, nC5, nC5, nC5, $24, nB4
	smpsLoop            $00, $02, BGM_EraserVS_Loop08
	dc.b	nB4, $24, nB4, nA4, $24, nG4

BGM_EraserVS_Loop09:
	dc.b	nF4, $12, nCs4, $06, nRst, $0C
	smpsLoop            $01, $02, BGM_EraserVS_Loop09
	dc.b	nA4, $24, nG4, nF4, $0C, nCs4, $06, nRst, nB3, nRst, nCs4, nEb4
	dc.b	nRst, nF4, nG4, $24

BGM_EraserVS_Loop0A:
	dc.b	smpsNoAttack, nG4, $03
	smpsAlterVol        $FF
	smpsLoop            $00, $0C, BGM_EraserVS_Loop0A
	smpsAlterVol        $0C
	smpsJump            BGM_EraserVS_Loop08

; FM5 Data
BGM_EraserVS_FM5:
	smpsSetvoice        $00
	smpsModSet          $36, $01, $0F, $7E, 0

BGM_EraserVS_Loop05:
	dc.b	nG4, $18, smpsNoAttack, nG4, $06, nG4, smpsNoAttack, nG4, nG4, nRst, $29
	smpsLoop            $01, $02, BGM_EraserVS_Loop05
	dc.b	nG4, $18, smpsNoAttack, nG4, $06, nG4, smpsNoAttack, nG4, nG4, smpsNoAttack, nG4, $18
	dc.b	smpsNoAttack, nG4, $06, nG4, smpsNoAttack, nG4, nG4, nG4, $24, nG4
	smpsLoop            $00, $02, BGM_EraserVS_Loop05
	dc.b	nA4, $24, nAb4, nE4, $24, nD4

BGM_EraserVS_Loop06:
	dc.b	nCs4, $12, nAb3, $06, nRst, $0C
	smpsLoop            $01, $02, BGM_EraserVS_Loop06
	dc.b	nE4, $24, nD4, nCs4, $0C, nF3, $06, nRst, nEb3, nRst, nF3, nAb3
	dc.b	nRst, nA3, nBb3, $24

BGM_EraserVS_Loop07:
	dc.b	smpsNoAttack, nBb3, $03
	smpsAlterVol        $FF
	smpsLoop            $00, $0C, BGM_EraserVS_Loop07
	smpsAlterVol        $0C
	smpsJump            BGM_EraserVS_Loop05

; FM4 Data
BGM_EraserVS_FM4:
	smpsSetvoice        $00
	smpsPan             panLeft, $00
	smpsModSet          $36, $01, $14, $7E, 0

BGM_EraserVS_Loop02:
	dc.b	nD4, $18, smpsNoAttack, nD4, $06, nD4, smpsNoAttack, nD4, nE4, nRst, $29
	smpsLoop            $01, $02, BGM_EraserVS_Loop02
	dc.b	nD4, $18, smpsNoAttack, nD4, $06, nD4, smpsNoAttack, nD4, nE4, smpsNoAttack, nE4, $18
	dc.b	smpsNoAttack, nE4, $06, nE4, smpsNoAttack, nE4, nE4, nF4, $24, nF4
	smpsLoop            $00, $02, BGM_EraserVS_Loop02
	dc.b	nE4, $24, nE4, nCs4, $24, nB3

BGM_EraserVS_Loop03:
	dc.b	nAb3, $12, nF3, $06, nRst, $0C
	smpsLoop            $01, $02, BGM_EraserVS_Loop03
	dc.b	nCs4, $24, nB3, nAb3, $0C, nAb3, $06, nRst, nFs3, nRst, nAb3, nBb3
	dc.b	nRst, nC4, nF4, $30

BGM_EraserVS_Loop04:
	dc.b	smpsNoAttack, nF4, $03
	smpsAlterVol        $FF
	smpsLoop            $00, $08, BGM_EraserVS_Loop04
	smpsAlterVol        $08
	smpsJump            BGM_EraserVS_Loop02

; FM3 Data
BGM_EraserVS_FM3:
	smpsPan             panLeft, $00
	smpsSetvoice        $01
	dc.b	nG2, $30
	smpsSetvoice        $02
	smpsPan             panCenter, $00
	dc.b	nG7, $06, nA7, nD7, nE7, $07, nA6, $08, nB6
	smpsLoop            $01, $02, BGM_EraserVS_FM3
	smpsSetvoice        $01
	smpsPan             panLeft, $00
	dc.b	nG2, $30, nG2, nG2, $24, nG2
	smpsLoop            $00, $02, BGM_EraserVS_FM3
	smpsPan             panCenter, $00
	dc.b	nG2, nG2
	smpsPan             panRight, $00
	dc.b	nBb3, $3C, nRst, $60, nRst, nRst
	smpsJump            BGM_EraserVS_FM3

; DAC Data
BGM_EraserVS_DAC:
	smpsStop

BGM_EraserVS_FM6:
	smpsSetvoice	$05
	dc.b	nGs0, $0C
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, $06
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nRst, $29
	smpsAlterVol	-3
	smpsLoop            $01, $02, BGM_EraserVS_FM6

BGM_EraserVS_Loop00:
	smpsSetvoice	$05
	dc.b	nGs0, $0C
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, $06
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nRst
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsAlterVol	-3
	smpsLoop            $01, $02, BGM_EraserVS_Loop00

BGM_EraserVS_Loop01:
	smpsSetvoice	$05
	dc.b	nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4
	smpsAlterVol	-3
	smpsLoop            $01, $02, BGM_EraserVS_Loop01
	smpsLoop            $00, $02, BGM_EraserVS_FM6
	smpsSetvoice	$05
	dc.b	nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4, nDs4, nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4, nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0, nGs0
	smpsSetvoice	$04
	smpsAlterVol	5
	smpsPan		panLeft, $00
	dc.b	nF4
	smpsSetvoice	$05
	smpsAlterVol	-5
	smpsPan		panCentre, $00
	dc.b	nGs0
	smpsSetvoice	$04
	smpsAlterVol	5
	dc.b	nD4
	smpsSetvoice	$05
	smpsAlterVol	-5
	dc.b	nGs0
	smpsSetvoice	$04
	smpsAlterVol	5
	smpsPan		panRight, $00
	dc.b	nB3
	smpsSetvoice	$05
	smpsAlterVol	-5
	smpsPan		panCentre, $00
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$06
	smpsAlterVol	3
	dc.b	nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0
	smpsSetvoice	$04
	smpsAlterVol	5
	smpsPan		panLeft, $00
	dc.b	nF4
	smpsPan		panCentre, $00
	dc.b	nD4
	smpsPan		panRight, $00
	dc.b	nB3
	smpsSetvoice	$05
	smpsAlterVol	-5
	smpsPan		panCentre, $00
	dc.b	nGs0, nGs0
	smpsSetvoice	$04
	smpsAlterVol	7
	dc.b	nGs4, nGs4
	smpsSetvoice	$06
	smpsAlterVol	-4
	dc.b	nDs4, nDs4
	smpsSetvoice	$05
	smpsAlterVol	-3
	dc.b	nGs0, nGs0
	smpsSetvoice	$04
	smpsAlterVol	5
	smpsPan		panRight, $00
	dc.b	nB3, nB3
	smpsAlterVol	-5
	smpsPan		panCentre, $00
	smpsJump            BGM_EraserVS_FM6

BGM_EraserVS_Voices:
;	Voice $00
;	$03
;	$11, $12, $71, $71, 	$14, $15, $18, $15, 	$04, $04, $00, $00
;	$00, $00, $00, $00, 	$10, $10, $10, $1F, 	$1E, $02, $12, $89
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $01, $01
	smpsVcCoarseFreq    $01, $01, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $18, $15, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $04, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $00, $12, $02, $1E

;	Voice $01
;	$32
;	$04, $20, $70, $70, 	$1F, $1F, $1F, $1F, 	$09, $00, $00, $08
;	$09, $00, $00, $0B, 	$00, $00, $00, $0F, 	$0C, $00, $30, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $02, $00
	smpsVcCoarseFreq    $00, $00, $00, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $00, $00, $09
	smpsVcDecayRate2    $0B, $00, $00, $09
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $00, $00, $00
	smpsVcTotalLevel    $00, $30, $00, $0C

;	Voice $02
;	$38
;	$73, $04, $71, $01, 	$DF, $DD, $DF, $DF, 	$0F, $05, $05, $04
;	$05, $04, $02, $03, 	$2F, $1F, $3F, $FF, 	$12, $1C, $1A, $8F
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $07, $00, $07
	smpsVcCoarseFreq    $01, $01, $04, $03
	smpsVcRateScale     $03, $03, $03, $03
	smpsVcAttackRate    $1F, $1F, $1D, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $05, $05, $0F
	smpsVcDecayRate2    $03, $02, $04, $05
	smpsVcDecayLevel    $0F, $03, $01, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0F, $1A, $1C, $12

;	Voice $03
;	$00
;	$37, $37, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$2F, $1F, $1F, $FF, 	$19, $37, $13, $87
	smpsVcAlgorithm     $00
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $07, $07
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $13, $37, $19

;	Voice $04; Tom
;	$3E
;	$60, $30, $30, $30,	$19, $1F, $1F, $1F,	$15, $11, $11, $0C
;	$10, $0A, $06, $09,	$4F, $5F, $AF, $8F,	$00, $82, $83, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $06
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $11, $11, $15
	smpsVcDecayRate2    $09, $06, $0A, $10
	smpsVcDecayLevel    $08, $0A, $05, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $03, $02, $00

;	Voice $05; Kick
;	$72
;	$33, $30, $32, $31,	$1E, $1B, $1C, $15,	$16, $12, $17, $10
;	$10, $18, $1E, $14, 	$4F, $5F, $4F, $4F,	$08, $00, $10, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $06
	smpsVcUnusedBits    $01
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $02, $00, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $15, $1C, $1B, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $17, $12, $16
	smpsVcDecayRate2    $14, $1E, $18, $10
	smpsVcDecayLevel    $04, $04, $05, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $10, $00, $08

;	Voice $06; Snare
;	$3C
;	$0F, $00, $00, $00, 	$1F, $1A, $18, $1C, 	$17, $11, $1A, $0E
;	$00, $0F, $14, $10, 	$1F, $EC, $FF, $FF, 	$07, $80, $16, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1C, $18, $1A, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $1A, $11, $17
	smpsVcDecayRate2    $10, $14, $0F, $00
	smpsVcDecayLevel    $0F, $0F, $0E, $01
	smpsVcReleaseRate   $0F, $0F, $0C, $0F
	smpsVcTotalLevel    $00, $16, $00, $07

	smpsFooterEndSong	"DaxKatter/Mus - Eraser VS.asm"