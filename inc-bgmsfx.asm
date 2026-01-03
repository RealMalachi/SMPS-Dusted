SMPS_Start:
.s:	dc.w bgm__Last-bgm__First
	dc.w sfx__Last-sfx__First
	dc.w pcm__Last-pcm__First
	dc.w SMPS_MusicIndex-.s
	dc.w SMPS_SoundIndex-.s
	dc.w SMPS_ModEnvIndex-.s
	dc.w SMPS_UVB_FM-.s
	dc.w SMPS_VolEnvIndex-.s
	dc.l SMPS_SampleTable-.s
; ---------------------------------------------------------------------------
; Universal Modulation Envelopes
; ---------------------------------------------------------------------------
SMPS_ModEnvIndex:

; ---------------------------------------------------------------------------
; Universal Volume Envelopes
; ---------------------------------------------------------------------------
SourceSMPS2ASM := 1
SourceDriver := 1

SMPS_VolEnvIndex:
	smpsEnvTable START
	smpsEnvTable .ft01,fTone_01
	smpsEnvTable .ft02,fTone_02
	smpsEnvTable .ft03,fTone_03
	smpsEnvTable .ft04,fTone_04
	smpsEnvTable .ft05,fTone_05
	smpsEnvTable .ft06,fTone_06
	smpsEnvTable .ft07,fTone_07
	smpsEnvTable .ft08,fTone_08
	smpsEnvTable .ft09,fTone_09
	smpsEnvTable .ft0A,fTone_0A
	smpsEnvTable .ft0B,fTone_0B
	smpsEnvTable .ft0C,fTone_0C
	smpsEnvTable .ft0D,fTone_0D
	smpsEnvTable .st01,sTone_01
	smpsEnvTable .st02,sTone_02
	smpsEnvTable .st04,sTone_04
	smpsEnvTable .st08,sTone_08
	smpsEnvTable .st0A,sTone_0A
	smpsEnvTable .st0C,sTone_0C
	smpsEnvTable .st0D,sTone_0D
	smpsEnvTable .st1B,sTone_1B
	smpsEnvTable .sml04,smlTone_04
	smpsEnvTable .sml06,smlTone_06
	smpsEnvTable END

.ft01:	smpsEnvPsg $00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,HOLD
.ft02:	smpsEnvPsg $00,$02,$04,$06,$08,$10,HOLD
.ft03:	smpsEnvPsg $00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,RESET
.ft04:	smpsEnvPsg $00,$00,$02,$03,$04,$04,$05,$05,$05,$06,HOLD
.ft05:	smpsEnvPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02
	smpsEnvPsg $03,$03,$03,$03,$03,$03,$03,$03,$04,HOLD
.ft06:	smpsEnvPsg $03,$03,$03,$02,$02,$02,$02,$01,$01,$01,$00,$00,$00,$00,HOLD
.ft07:	smpsEnvPsg $00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02
	smpsEnvPsg $03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$07,HOLD
.ft08:	smpsEnvPsg $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02
	smpsEnvPsg $03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06
	smpsEnvPsg $06,$06,$06,$06,$07,$07,$07,HOLD
.ft09:	smpsEnvPsg $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,RESET
.ft0A:	smpsEnvPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02
	smpsEnvPsg $02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,HOLD
.ft0B:	smpsEnvPsg $04,$04,$04,$03,$03,$03,$02,$02,$02,$01,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,HOLD
.ft0C:	smpsEnvPsg $04,$04,$03,$03,$02,$02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02
	smpsEnvPsg $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03
	smpsEnvPsg $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
	smpsEnvPsg $03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	smpsEnvPsg $04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
	smpsEnvPsg $05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06
	smpsEnvPsg $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,HOLD
.ft0D:	smpsEnvPsg $0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00,HOLD

.st01:	smpsEnvPsg $02,REST
.st02:	smpsEnvPsg $00,$02,$04,$06,$08,$10,REST
.st03:	smpsEnvPsg $02,$01,$00,$00,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,HOLD
.st04:	smpsEnvPsg $00,$00,$02,$03,$04,$04,$05,$05,$05,$06,$06,HOLD
.st05:	smpsEnvPsg $03,$00,$01,$01,$01,$02,$03,$04,$04,$05,HOLD
.st06:	smpsEnvPsg $00,$00,$01,$01,$02,$03,$04,$05,$05,$06,$08,$07,$07,$06,HOLD
.st07:	smpsEnvPsg $01,$0C,$03,$0F,$02,$07,$03,$0F,RESET
.st08:	smpsEnvPsg $00,$00,$00,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0F,HOLD
.st09:	smpsEnvPsg $03,$02,$01,$01,$00,$00,$01,$02,$03,$04,HOLD
.st0A:	smpsEnvPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,HOLD
.st0B:	smpsEnv    $10,$20,$30,$40,$30,$20,$10,$00,$7F,RESET	; ...,-$10,RESET
.st0C:	smpsEnvPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
.st0D:	smpsEnvPsg $00,HOLD
.st0E:	smpsEnvPsg $02,REST
.st0F:	smpsEnvPsg $00,$02,$04,$06,$08,$7F,REST
.st10:	smpsEnvPsg $09,$09,$09,$08,$08,$08,$07,$07,$07,$06,$06,$06,$05,$05,$05,$04
	smpsEnvPsg $04,$04,$03,$03,$03,$02,$02,$02,$01,$01,$01,$00,$00,$00,HOLD
.st11:	smpsEnvPsg $01,$01,$01,$00,$00,$00,HOLD
.st12:	smpsEnvPsg $03,$00,$01,$01,$01,$02,$03,$04,$04,$05,HOLD
.st13:	smpsEnvPsg $00,$00,$01,$01,$02,$03,$04,$05,$05,$06,$08,$07,$07,$06,HOLD
.st14:	smpsEnvPsg $0A,$05,$00,$04,$08,REST
.st15:	smpsEnvPsg $00,$00,$00,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0F,REST
.st16:	smpsEnvPsg $03,$02,$01,$01,$00,$00,$01,$02,$03,$04,HOLD
.st17:	smpsEnvPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04
	smpsEnvPsg $04,$04,$05,$05,HOLD
.st18:	smpsEnv    $10,$20,$30,$40,$30,$20,$10,$00,$10,$20,$30,$40,$30,$20,$10,$00
	smpsEnv    $10,$20,$30,$40,$30,$20,$10,$00,RESET
.st19:	smpsEnvPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
.st1A:	smpsEnv    $00,$02,$04,$06,$08,$16,REST
.st1B:	smpsEnvPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
.st1C:	smpsEnvPsg $04,$04,$04,$04,$03,$03,$03,$03,$02,$02,$02,$02,$01,$01,$01,$01,REST

.st1D:	smpsEnvPsg $00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03
	smpsEnvPsg $04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$07
	smpsEnvPsg $08,$08,$08,$08,$09,$09,$09,$09,$0A,$0A,$0A,$0A,HOLD
.st1E:	smpsEnvPsg $00,$0A,REST
.st1F:	smpsEnvPsg $00,$02,$04,HOLD
.st20:	smpsEnv    $30,$20,$10,$00,$00,$00,$00,$00,$08,$10,$20,$30, HOLD
.st21:	smpsEnvPsg $00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$06,$06,$06,$08,$08
	smpsEnvPsg $0A,REST
.st22:	smpsEnvPsg $00,$02,$03,$04,$06,$07,HOLD
.st23:	smpsEnvPsg $02,$01,$00,$00,$00,$02,$04,$07,HOLD
.st24:	smpsEnvPsg $0F,$01,$05,REST
.st25:	smpsEnvPsg $08,$06,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,REST
.st26:	smpsEnvPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
	smpsEnvPsg $01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03
	smpsEnvPsg $03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04
	smpsEnvPsg $04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06
	smpsEnvPsg $06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07
	smpsEnvPsg $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09
	;smpsEnvPsg $09,$09		; S3A has these two extra ticks
	smpsEnvPsg $09,$09,RESET
.st27:	smpsEnvPsg $00,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,REST

.sml04:	smpsEnvPsg $00,$00,$00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$07,$09,RESET
.sml06:	smpsEnvPsg $00,$01,$02,$04,$06,$08,$0A,$0C,$0E,$10,RESET

; ---------------------------------------------------------------------------
; FM Universal Voice Bank
; ---------------------------------------------------------------------------
SourceSMPS2ASM := 1
SourceDriver := 1

SMPS_UVB_FM:
;   Synth Bass 2
;	Voice $00
;	$3C
;	$01, $00, $00, $00, 	$1F, $1F, $15, $1F, 	$11, $0D, $12, $05
;	$07, $04, $09, $02, 	$55, $3A, $25, $1A, 	$1A, $80, $07, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $15, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $12, $0D, $11
	smpsVcDecayRate2    $02, $09, $04, $07
	smpsVcDecayLevel    $01, $02, $03, $05
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $07, $00, $1A
;   Trumpet 1
;	Voice $01
;	$3D
;	$01, $01, $01, $01, 	$94, $19, $19, $19, 	$0F, $0D, $0D, $0D
;	$07, $04, $04, $04, 	$25, $1A, $1A, $1A, 	$15, $80, $80, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $19, $19, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $0D, $0D, $0F
	smpsVcDecayRate2    $04, $04, $04, $07
	smpsVcDecayLevel    $01, $01, $01, $02
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $15
;   Slap Bass 2
;	Voice $02
;	$03
;	$00, $D7, $33, $02, 	$5F, $9F, $5F, $1F, 	$13, $0F, $0A, $0A
;	$10, $0F, $02, $09, 	$35, $15, $25, $1A, 	$13, $16, $15, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $0D, $00
	smpsVcCoarseFreq    $02, $03, $07, $00
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0F, $13
	smpsVcDecayRate2    $09, $02, $0F, $10
	smpsVcDecayLevel    $01, $02, $01, $03
	smpsVcReleaseRate   $0A, $05, $05, $05
	smpsVcTotalLevel    $00, $15, $16, $13
;   Synth Bass 1
;	Voice $03
;	$34
;	$70, $72, $31, $31, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $15, $1A, 	$10, $83, $18, $83
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $03, $18, $03, $10
;   Bell Synth 1
;	Voice $04
;	$3E
;	$77, $71, $32, $31, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
;	$08, $06, $00, $00, 	$15, $0A, $0A, $0A, 	$1B, $80, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $1B
;   Bell Synth 2
;	Voice $05
;	$34
;	$33, $41, $7E, $74, 	$5B, $9F, $5F, $1F, 	$04, $07, $07, $08
;	$00, $00, $00, $00, 	$FF, $FF, $EF, $FF, 	$23, $80, $29, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $04, $03
	smpsVcCoarseFreq    $04, $0E, $01, $03
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $07, $07, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0E, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $07, $29, $00, $23
;   Synth Brass 1
;	Voice $06
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18
;   Synth like Bassoon
;	Voice $07
;	$3C
;	$32, $32, $71, $42, 	$1F, $18, $1F, $1E, 	$07, $1F, $07, $1F
;	$00, $00, $00, $00, 	$1F, $0F, $1F, $0F, 	$1E, $80, $0C, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $03, $03
	smpsVcCoarseFreq    $02, $01, $02, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1E, $1F, $18, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $1F, $07, $1F, $07
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0C, $00, $1E
;   Synth Horn with Small Bell
;	Voice $08
;	$3C
;	$71, $72, $3F, $34, 	$8D, $52, $9F, $1F, 	$09, $00, $00, $0D
;	$00, $00, $00, $00, 	$23, $08, $02, $F7, 	$15, $80, $1D, $87
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $04, $0F, $02, $01
	smpsVcRateScale     $00, $02, $01, $02
	smpsVcAttackRate    $1F, $1F, $12, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $00, $00, $09
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $00, $00, $02
	smpsVcReleaseRate   $07, $02, $08, $03
	smpsVcTotalLevel    $07, $1D, $00, $15
;   Synth Bass 3
;	Voice $09
;	$3D
;	$01, $01, $00, $00, 	$8E, $52, $14, $4C, 	$08, $08, $0E, $03
;	$00, $00, $00, $00, 	$1F, $1F, $1F, $1F, 	$1B, $80, $80, $9B
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $01, $01
	smpsVcRateScale     $01, $00, $01, $02
	smpsVcAttackRate    $0C, $14, $12, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $08, $08
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $9B, $80, $80, $1B
;   Synth Trumpet
;	Voice $0A
;	$3A
;	$01, $01, $01, $02, 	$8D, $07, $07, $52, 	$09, $00, $00, $03
;	$01, $02, $02, $00, 	$52, $02, $02, $28, 	$18, $22, $18, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $01, $01
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $12, $07, $07, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $00, $00, $09
	smpsVcDecayRate2    $00, $02, $02, $01
	smpsVcDecayLevel    $02, $00, $00, $05
	smpsVcReleaseRate   $08, $02, $02, $02
	smpsVcTotalLevel    $00, $18, $22, $18
;   Wood Block
;	Voice $0B
;	$3C
;	$36, $31, $76, $71, 	$94, $9F, $96, $9F, 	$12, $00, $14, $0F
;	$04, $0A, $04, $0D, 	$2F, $0F, $4F, $2F, 	$33, $80, $1A, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $01, $06, $01, $06
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $16, $1F, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $14, $00, $12
	smpsVcDecayRate2    $0D, $04, $0A, $04
	smpsVcDecayLevel    $02, $04, $00, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $00, $33
;   Tubular Bell
;	Voice $0C
;	$34
;	$33, $41, $7E, $74, 	$5B, $9F, $5F, $1F, 	$04, $07, $07, $08
;	$00, $00, $00, $00, 	$FF, $FF, $EF, $FF, 	$23, $90, $29, $97
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $04, $03
	smpsVcCoarseFreq    $04, $0E, $01, $03
	smpsVcRateScale     $00, $01, $02, $01
	smpsVcAttackRate    $1F, $1F, $1F, $1B
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $07, $07, $04
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0E, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $17, $29, $10, $23
;   Strike Bass
;	Voice $0D
;	$38
;	$63, $31, $31, $31, 	$10, $13, $1A, $1B, 	$0E, $00, $00, $00
;	$00, $00, $00, $00, 	$3F, $0F, $0F, $0F, 	$1A, $19, $1A, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $06
	smpsVcCoarseFreq    $01, $01, $01, $03
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1B, $1A, $13, $10
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1A, $19, $1A
;   Elec Piano
;	Voice $0E
;	$3A
;	$31, $25, $73, $41, 	$5F, $1F, $1F, $9C, 	$08, $05, $04, $05
;	$03, $04, $02, $02, 	$2F, $2F, $1F, $2F, 	$29, $27, $1F, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $04, $07, $02, $03
	smpsVcCoarseFreq    $01, $03, $05, $01
	smpsVcRateScale     $02, $00, $00, $01
	smpsVcAttackRate    $1C, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $05, $08
	smpsVcDecayRate2    $02, $02, $04, $03
	smpsVcDecayLevel    $02, $01, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1F, $27, $29
;   Bright Piano
;	Voice $0F
;	$04
;	$71, $41, $31, $31, 	$12, $12, $12, $12, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$23, $80, $23, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $04, $07
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $12, $12, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0C, $0C, $0C, $0C
	smpsVcTotalLevel    $00, $23, $00, $23
;   Church Bell
;	Voice $10
;	$14
;	$75, $72, $35, $32, 	$9F, $9F, $9F, $9F, 	$05, $05, $00, $0A
;	$05, $05, $07, $05, 	$2F, $FF, $0F, $2F, 	$1E, $80, $14, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $05, $02, $05
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $05, $05
	smpsVcDecayRate2    $05, $07, $05, $05
	smpsVcDecayLevel    $02, $00, $0F, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $00, $1E
;   Synth Brass 2
;	Voice $11
;	$3D
;	$01, $00, $01, $02, 	$12, $1F, $1F, $14, 	$07, $02, $02, $0A
;	$05, $05, $05, $05, 	$2F, $2F, $2F, $AF, 	$1C, $80, $82, $80
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $02, $01, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $14, $1F, $1F, $12
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $02, $02, $07
	smpsVcDecayRate2    $05, $05, $05, $05
	smpsVcDecayLevel    $0A, $02, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $02, $00, $1C
;   Bell Piano
;	Voice $12
;	$1C
;	$73, $72, $33, $32, 	$94, $99, $94, $99, 	$08, $0A, $08, $0A
;	$00, $05, $00, $05, 	$3F, $4F, $3F, $4F, 	$1E, $80, $19, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $03, $02, $03
	smpsVcRateScale     $02, $02, $02, $02
	smpsVcAttackRate    $19, $14, $19, $14
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $08, $0A, $08
	smpsVcDecayRate2    $05, $00, $05, $00
	smpsVcDecayLevel    $04, $03, $04, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $19, $00, $1E
;   Wet Wood Bass
;	Voice $13
;	$31
;	$33, $01, $00, $00, 	$9F, $1F, $1F, $1F, 	$0D, $0A, $0A, $0A
;	$0A, $07, $07, $07, 	$FF, $AF, $AF, $AF, 	$1E, $1E, $1E, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $03
	smpsVcCoarseFreq    $00, $00, $01, $03
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0A, $0A, $0D
	smpsVcDecayRate2    $07, $07, $07, $0A
	smpsVcDecayLevel    $0A, $0A, $0A, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $1E, $1E
;   Silent Bass
;	Voice $14
;	$3A
;	$70, $76, $30, $71, 	$1F, $95, $1F, $1F, 	$0E, $0F, $05, $0C
;	$07, $06, $06, $07, 	$2F, $4F, $1F, $5F, 	$21, $12, $28, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $07
	smpsVcCoarseFreq    $01, $00, $06, $00
	smpsVcRateScale     $00, $00, $02, $00
	smpsVcAttackRate    $1F, $1F, $15, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0C, $05, $0F, $0E
	smpsVcDecayRate2    $07, $06, $06, $07
	smpsVcDecayLevel    $05, $01, $04, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $12, $21
;   Picked Bass
;	Voice $15
;	$28
;	$71, $00, $30, $01, 	$1F, $1F, $1D, $1F, 	$13, $13, $06, $05
;	$03, $03, $02, $05, 	$4F, $4F, $2F, $3F, 	$0E, $14, $1E, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $03, $00, $07
	smpsVcCoarseFreq    $01, $00, $00, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1D, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $06, $13, $13
	smpsVcDecayRate2    $05, $02, $03, $03
	smpsVcDecayLevel    $03, $02, $04, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1E, $14, $0E
;   Xylophone
;	Voice $16
;	$3E
;	$38, $01, $7A, $34, 	$59, $D9, $5F, $9C, 	$0F, $04, $0F, $0A
;	$02, $02, $05, $05, 	$AF, $AF, $66, $66, 	$28, $80, $A3, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $00, $03
	smpsVcCoarseFreq    $04, $0A, $01, $08
	smpsVcRateScale     $02, $01, $03, $01
	smpsVcAttackRate    $1C, $1F, $19, $19
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $0F, $04, $0F
	smpsVcDecayRate2    $05, $05, $02, $02
	smpsVcDecayLevel    $06, $06, $0A, $0A
	smpsVcReleaseRate   $06, $06, $0F, $0F
	smpsVcTotalLevel    $00, $23, $00, $28
;   Pseudo-Square Wave
;	Voice $17
;	$39
;	$32, $31, $72, $71, 	$1F, $1F, $1F, $1F, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$1B, $32, $28, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $01, $02, $01, $02
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $28, $32, $1B
;   Pipe Organ
;	Voice $18
;	$07
;	$34, $74, $32, $71, 	$1F, $1F, $1F, $1F, 	$0A, $0A, $05, $03
;	$00, $00, $00, $00, 	$3F, $3F, $2F, $2F, 	$8A, $8A, $80, $80
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $03
	smpsVcCoarseFreq    $01, $02, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $02, $03, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $0A, $0A
;   Synth Brass 3
;	Voice $19
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $06, $02, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0E, $0D, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $26, $28, $17
;   Bell Synth 1, but without any detune
;	Voice $1A
;	$3B
;	$3A, $31, $71, $74, 	$DF, $1F, $1F, $DF, 	$00, $0A, $0A, $05
;	$00, $05, $05, $03, 	$0F, $5F, $1F, $5F, 	$32, $1E, $0F, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $00, $00, $00, $1B
;   Metallic Bass
;	Voice $1B
;	$05
;	$04, $01, $02, $04, 	$8D, $1F, $15, $52, 	$06, $00, $00, $04
;	$02, $08, $00, $00, 	$1F, $0F, $0F, $2F, 	$16, $90, $84, $8C
	smpsVcAlgorithm     $05
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $04, $02, $01, $04
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $12, $15, $1F, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $04, $00, $00, $06
	smpsVcDecayRate2    $00, $00, $08, $02
	smpsVcDecayLevel    $02, $00, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0C, $04, $10, $16
;   Alternate Metallic Bass
;	Voice $1C
;	$2C
;	$71, $74, $32, $32, 	$1F, $12, $1F, $12, 	$00, $0A, $00, $0A
;	$00, $00, $00, $00, 	$0F, $1F, $0F, $1F, 	$16, $80, $17, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $02, $02, $04, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $12, $1F, $12, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $00, $0A, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $01, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $00, $16
;   Backdropped Metallic Bass
;	Voice $1D
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $8F
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0F, $27, $28, $18
;   Sine like Bell
;	Voice $1E
;	$36
;	$7A, $32, $51, $11, 	$1F, $1F, $59, $1C, 	$0A, $0D, $06, $0A
;	$07, $00, $02, $02, 	$AF, $5F, $5F, $5F, 	$1E, $8B, $81, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $05, $03, $07
	smpsVcCoarseFreq    $01, $01, $02, $0A
	smpsVcRateScale     $00, $01, $00, $00
	smpsVcAttackRate    $1C, $19, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0A, $06, $0D, $0A
	smpsVcDecayRate2    $02, $02, $00, $07
	smpsVcDecayLevel    $05, $05, $05, $0A
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $01, $0B, $1E
;   Synth Bass 1, but without any Detune
;	Voice $1F
;	$34
;	$00, $02, $01, $01, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $15, $1A, 	$10, $80, $18, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $01, $01, $03
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $18, $00, $10
;   Wet Plucked Bass
;	Voice $20
;	$3B
;	$0D, $01, $00, $00, 	$9F, $1F, $1F, $1F, 	$0E, $0D, $09, $09
;	$00, $00, $00, $00, 	$DF, $DF, $DF, $DF, 	$33, $15, $17, $80
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $00, $00, $01, $0D
	smpsVcRateScale     $00, $00, $00, $02
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $09, $0D, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0D, $0D, $0D, $0D
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $17, $15, $33
;   Rock Organ
;	Voice $21
;	$07
;	$34, $74, $32, $71, 	$1F, $1F, $1F, $1F, 	$0A, $0A, $05, $03
;	$00, $00, $00, $00, 	$3F, $3F, $2F, $2F, 	$8A, $8A, $8A, $8A
	smpsVcAlgorithm     $07
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $07, $03
	smpsVcCoarseFreq    $01, $02, $04, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $05, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $02, $02, $03, $03
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0A, $0A, $0A, $0A
;   Strike like Slap Bass
;	Voice $22
;	$20
;	$36, $35, $30, $31, 	$DF, $DF, $9F, $9F, 	$07, $06, $09, $06
;	$07, $06, $06, $08, 	$20, $10, $10, $F8, 	$19, $37, $13, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $04
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $05, $06
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $09, $06, $07
	smpsVcDecayRate2    $08, $06, $06, $07
	smpsVcDecayLevel    $0F, $01, $01, $02
	smpsVcReleaseRate   $08, $00, $00, $00
	smpsVcTotalLevel    $00, $13, $37, $19
;   1103 Prototype Flute
;	Voice $23
;	$14
;	$71, $72, $31, $31, 	$0F, $0F, $0F, $0F, 	$00, $0F, $00, $00
;	$00, $00, $00, $00, 	$0F, $AF, $0F, $0F, 	$32, $80, $28, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $02
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $01, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $0F, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $0A, $00
	smpsVcReleaseRate   $0C, $0C, $0C, $0C
	smpsVcTotalLevel    $00, $28, $00, $32
;   Combination of "Sine like Bell" and "Bell Synth 1"
;	Voice $24
;	$36
;	$77, $31, $52, $11, 	$1F, $1F, $59, $1C, 	$0A, $0D, $06, $0A
;	$07, $00, $02, $02, 	$AF, $5F, $5F, $5F, 	$1E, $0A, $01, $00
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $07, $03, $07
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $01, $01, $00, $00
	smpsVcAttackRate    $19, $19, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $07, $0D, $0A
	smpsVcDecayRate2    $02, $02, $00, $07
	smpsVcDecayLevel    $05, $05, $05, $0A
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $08, $0C, $1E
;   Sine Flute
;	Voice $25
;	$06
;	$01, $01, $01, $01, 	$1F, $0F, $0F, $0F, 	$0A, $0A, $08, $08
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $0F, 	$32, $94, $80, $80
	smpsVcAlgorithm     $06
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $01, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0F, $0F, $0F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $08, $08, $0A, $0A
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $14, $32
;   Nice Synth like lead (Quieter version of Voice $04)
;	Voice $26
;	$3E
;	$77, $71, $32, $31, 	$1F, $1F, $1F, $1F, 	$0D, $06, $00, $00
;	$08, $06, $00, $00, 	$15, $0A, $0A, $0A, 	$1B, $8F, $8F, $8F
	smpsVcAlgorithm     $06
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $02, $01, $07
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $06, $0D
	smpsVcDecayRate2    $00, $00, $06, $08
	smpsVcDecayLevel    $00, $00, $00, $01
	smpsVcReleaseRate   $0A, $0A, $0A, $05
	smpsVcTotalLevel    $0F, $0F, $0F, $1B
;   1103 Prototype Synth Brass
;	Voice $27
;	$3A
;	$01, $07, $31, $71, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$18, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $18
;   Plucked Synth Lead
;	Voice $28
;	$34
;	$00, $02, $01, $01, 	$1F, $1F, $1F, $1F, 	$10, $06, $06, $06
;	$01, $06, $06, $06, 	$35, $1A, $15, $1A, 	$10, $80, $18, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $07, $07
	smpsVcCoarseFreq    $01, $01, $02, $00
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $10, $06, $10
	smpsVcDecayRate2    $06, $06, $06, $01
	smpsVcDecayLevel    $01, $02, $01, $03
	smpsVcReleaseRate   $0A, $05, $0A, $05
	smpsVcTotalLevel    $00, $10, $00, $10
;   Hard Slap Bass
;	Voice $29
;	$31
;	$34, $35, $30, $31, 	$DF, $DF, $9F, $9F, 	$0C, $07, $0C, $09
;	$07, $07, $07, $08, 	$2F, $1F, $1F, $2F, 	$17, $32, $14, $80
	smpsVcAlgorithm     $01
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $00, $05, $04
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $09, $0C, $07, $0C
	smpsVcDecayRate2    $08, $07, $07, $07
	smpsVcDecayLevel    $02, $01, $01, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $14, $32, $17
;   Synth Harmonica Thing
;	Voice $2A
;	$3A
;	$51, $08, $51, $02, 	$1E, $1E, $1E, $10, 	$1F, $1F, $1F, $0F
;	$00, $00, $00, $02, 	$0F, $0F, $0F, $1F, 	$18, $24, $22, $81
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $05, $00, $05
	smpsVcCoarseFreq    $02, $01, $08, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $1E, $1E, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $1F, $1F, $1F
	smpsVcDecayRate2    $02, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $22, $24, $18
;   Quiet Horn
;	Voice $2B
;	$3A
;	$01, $07, $01, $01, 	$8E, $8E, $8D, $53, 	$0E, $0E, $0E, $03
;	$00, $00, $00, $07, 	$1F, $FF, $1F, $0F, 	$1C, $28, $27, $80
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0D, $0E, $0E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $07, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $27, $28, $1C
;   Rock Organ 2
;	Voice $2C
;	$1F
;	$66, $31, $53, $22, 	$1C, $98, $1F, $1F, 	$12, $0F, $0F, $0F
;	$00, $00, $00, $00, 	$FF, $0F, $0F, $0F, 	$8C, $8D, $8A, $8B
	smpsVcAlgorithm     $07
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $02, $05, $03, $06
	smpsVcCoarseFreq    $02, $03, $01, $06
	smpsVcRateScale     $00, $00, $02, $00
	smpsVcAttackRate    $1F, $1F, $18, $1C
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $0F, $0F, $12
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $00, $00, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $0B, $0A, $0D, $0C
; ---------------------------------------------------------------------------
	even
; ---------------------------------------------------------------------------
; Music	index
; offset is u24
; bit 7 indicates a 1up jingle
; bit 6 disables PAL song speed adjustment
; bit 5 disables muffling
; ---------------------------------------------------------------------------
musdef macro flags,loc
	dc.l (flags)<<24|(loc-SMPS_MusicIndex)&$FFFFFF
	endm
SMPS_MusicIndex:
	musdef 0,BgmGHZ
	musdef 0,BgmS1SS
	musdef 0,BgmEHZ2P
	musdef 0,BgmMCZ2P
	musdef 0,BgmMTZ
	musdef 0,BgmLRZ1
	musdef 1<<7,BgmExtraLife
	musdef 1<<7,BgmExtraLife3
	musdef 1<<7,BgmExtraLifeK
	musdef 1<<6|1<<5,BgmDrown
	musdef 0,BgmSoccer
	musdef 0,BgmS3Credits
;	musdef 0,BgmS3CreditsP
	even
; ---------------------------------------------------------------------------
; Sound	effect index
; offset is u16
; sfx priority, zero bypasses the priority system entirely, otherwise higher numbers take priority
; - 1 is lowest, $3F is highest
; continuous sfx, loops if constantly queued
; background sfx, takes lower priority over standard sfxs on a driver level
; - if FM4 has both a bsfx and sfx, the bsfx will not play, but persists and will continue to play
;   after the sfx is done
; ---------------------------------------------------------------------------
sfxdef macro prio,bsfx,csfx,loc
	dc.b  bsfx<<7|csfx<<6|(prio)&$F
	dc.w  loc-SMPS_SoundIndex
	endm
SMPS_SoundIndex:
	sfxdef 0,0,0,SoundA0
	sfxdef 0,0,0,SoundA1
	sfxdef 0,0,0,SoundA3
	sfxdef 0,0,0,SoundA4
	sfxdef 0,0,0,SoundA6
	sfxdef 0,0,0,SoundA7
	sfxdef 0,0,0,SoundA8
	sfxdef 0,0,0,SoundA9
	sfxdef 0,0,0,SoundAA
	sfxdef 0,0,0,SoundAC
	sfxdef 0,0,0,SoundAD
	sfxdef 0,0,0,SoundAE
	sfxdef 0,0,0,SoundAF
	sfxdef 0,0,0,SoundB0
	sfxdef 0,0,0,SoundB1
	sfxdef 0,0,0,SoundB2
	sfxdef 0,0,0,SoundB3
	sfxdef 0,0,0,SoundB4
	sfxdef 0,0,0,SoundB5
	sfxdef 0,0,0,SoundB6
	sfxdef 0,0,0,SoundB7
	sfxdef 0,0,0,SoundB9
	sfxdef 0,0,0,SoundBA
	sfxdef 0,0,0,SoundBB
	sfxdef 0,0,0,SoundBC
	sfxdef 0,0,0,SoundBD
	sfxdef 0,0,0,SoundBE
	sfxdef 0,0,0,SoundBF
	sfxdef 0,0,0,SoundC0
	sfxdef 0,0,0,SoundC1
	sfxdef 0,0,0,SoundC2
	sfxdef 0,0,0,SoundC3
	sfxdef 0,0,0,SoundC4
	sfxdef 0,0,0,SoundC5
	sfxdef 0,0,0,SoundC6
	sfxdef 0,0,0,SoundC7
	sfxdef 0,0,0,SoundC8
	sfxdef 0,0,0,SoundC9
	sfxdef 0,0,0,SoundCA
	sfxdef 0,0,0,SoundCB
	sfxdef 0,0,0,SoundCC
	sfxdef 0,0,0,SoundCD
	sfxdef 0,0,0,SoundCE
	sfxdef 0,0,0,SoundCF
	sfxdef 0,0,0,SfxRevUp
	sfxdef 0,0,0,SfxRevRel
	sfxdef 0,1,0,SsfxWaterfall
	sfxdef 0,1,0,SsfxFmTest
	sfxdef 0,0,1,CsfxWindQuiet
	sfxdef 0,0,0,SfxTest
	even
; ---------------------------------------------------------------------------
; Sound effect data
; ---------------------------------------------------------------------------
CsfxWindQuiet:	include "sfx/Cont-WindQuiet.asm"
		even
SfxRevUp:	include "sfx/Spin Dash Rev.asm"
		even
SfxRevRel:	include "sfx/Spin Dash Release.asm"
		even
SfxTest:	include "sfx/TestSfx.asm"
		even
SoundA0:	include "sfx/SndA0 - Jump.asm"
		even
SoundA1:	include "sfx/SndA1 - Lamppost.asm"
		even
SoundA3:	include "sfx/SndA3 - Death.asm"
		even
SoundA4:	include "sfx/SndA4 - Skid.asm"
		even
SoundA6:	include "sfx/SndA6 - Hit Spikes.asm"
		even
SoundA7:	include "sfx/SndA7 - Push Block.asm"
		even
SoundA8:	include "sfx/SndA8 - SS Goal.asm"
		even
SoundA9:	include "sfx/SndA9 - SS Item.asm"
		even
SoundAA:	include "sfx/SndAA - Splash.asm"
		even
SoundAC:	include "sfx/SndAC - Hit Boss.asm"
		even
SoundAD:	include "sfx/SndAD - Get Bubble.asm"
		even
SoundAE:	include "sfx/SndAE - Fireball.asm"
		even
SoundAF:	include "sfx/SndAF - Shield.asm"
		even
SoundB0:	include "sfx/SndB0 - Saw.asm"
		even
SoundB1:	include "sfx/SndB1 - Electric.asm"
		even
SoundB2:	include "sfx/SndB2 - Drown Death.asm"
		even
SoundB3:	include "sfx/SndB3 - Flamethrower.asm"
		even
SoundB4:	include "sfx/SndB4 - Bumper.asm"
		even
SoundB5:	include "sfx/SndB5 - Ring.asm"
		even
SoundB6:	include "sfx/SndB6 - Spikes Move.asm"
		even
SoundB7:	include "sfx/SndB7 - Rumbling.asm"
		even
SoundB9:	include "sfx/SndB9 - Collapse.asm"
		even
SoundBA:	include "sfx/SndBA - SS Glass.asm"
		even
SoundBB:	include "sfx/SndBB - Door.asm"
		even
SoundBC:	include "sfx/SndBC - Teleport.asm"
		even
SoundBD:	include "sfx/SndBD - ChainStomp.asm"
		even
SoundBE:	include "sfx/SndBE - Roll.asm"
		even
SoundBF:	include "sfx/SndBF - Get Continue.asm"
		even
SoundC0:	include "sfx/SndC0 - Basaran Flap.asm"
		even
SoundC1:	include "sfx/SndC1 - Break Item.asm"
		even
SoundC2:	include "sfx/SndC2 - Drown Warning.asm"
		even
SoundC3:	include "sfx/SndC3 - Giant Ring.asm"
		even
SoundC4:	include "sfx/SndC4 - Bomb.asm"
		even
SoundC5:	include "sfx/SndC5 - Cash Register.asm"
		even
SoundC6:	include "sfx/SndC6 - Ring Loss.asm"
		even
SoundC7:	include "sfx/SndC7 - Chain Rising.asm"
		even
SoundC8:	include "sfx/SndC8 - Burning.asm"
		even
SoundC9:	include "sfx/SndC9 - Hidden Bonus.asm"
		even
SoundCA:	include "sfx/SndCA - Enter SS.asm"
		even
SoundCB:	include "sfx/SndCB - Wall Smash.asm"
		even
SoundCC:	include "sfx/SndCC - Spring.asm"
		even
SoundCD:	include "sfx/SndCD - Switch.asm"
		even
SoundCE:	include "sfx/SndCE - Ring Left Speaker.asm"
		even
SoundCF:	include "sfx/SndCF - Signpost.asm"
		even
; ---------------------------------------------------------------------------
; Special sound effect data
; ---------------------------------------------------------------------------
SsfxWaterfall:	include "sfx/SndD0 - Waterfall.asm"
		even
SsfxFmTest:	include "sfx/SSFX-TestFM.asm"
		even
; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------
BgmGHZ:		include "bgm/S1-GHZ.asm"
		even
BgmSYZ:		include "bgm/S1-SYZ.asm"
		even
BgmS1SS:	include "bgm/S1-SS.asm"
		even
BgmEHZ2P:	include "bgm/S2-EHZ2P.asm"
		even
BgmMCZ2P:	include "bgm/S2-MCZ2P.asm"
		even
BgmMTZ:		include "bgm/S2-MTZ.asm"
		even
BgmLRZ1:	include "bgm/SK-LRZ1.asm"
		even
BgmExtraLife:	include "bgm/S1-ExtraLife.asm"
		even
BgmExtraLife3:	include "bgm/S3-ExtraLife.asm"
		even
BgmExtraLifeK:	include "bgm/SK-ExtraLife.asm"
		even
BgmSoccer:	include "bgm/MDSoccer-Title.asm"
		even
BgmDrown:	include "bgm/S3-Drowning.asm"
		even
BgmS3Credits:	include "bgm/S3-Credits.asm"
		even
; ---------------------------------------------------------------------------
; PCM Samples
; ---------------------------------------------------------------------------
SMPS_SampleTable:
	;		type		pointer		Hz	Additional commands
	dcSample	TYPE_DPCM, 	Kick, 		8000
	dcSample	TYPE_PCM,	Snare,		24000
	dcSample	TYPE_DPCM, 	Clap,	 	17000
	dcSample	TYPE_DPCM,	Scratch,	15000
	dcSample	TYPE_DPCM, 	Timpani, 	7250
	dcSample	TYPE_PCM,	Tom,		14000
	dcSample	TYPE_DPCM,	Bongo,		7500
	dcSample	TYPE_DPCM, 	Timpani, 	9750
	dcSample	TYPE_DPCM, 	Timpani, 	8750
	dcSample	TYPE_DPCM, 	Timpani, 	7150
	dcSample	TYPE_DPCM, 	Timpani, 	7000
	dcSample	TYPE_PCM,	Tom,		23000
	dcSample	TYPE_PCM,	Tom,		18000
	dcSample	TYPE_PCM,	Tom,		15000
	dcSample	TYPE_DPCM,	Bongo,		15000
	dcSample	TYPE_DPCM,	Bongo,		13000
	dcSample	TYPE_DPCM,	Bongo,		9750
; S3
	dcSample	TYPE_DPCM,	SnareS3,	19000
	dcSample	TYPE_DPCM,	KickS3,		19000
	dcSample	TYPE_DPCM,	CrashCymbalS3,	17000
	dcSample	TYPE_DPCM,	ElectricTomS3,	20500
	dcSample	TYPE_DPCM,	ElectricTomS3,	16000
	dcSample	TYPE_DPCM,	ElectricTomS3,	13500
	dcSample	TYPE_DPCM,	ElectricTomS3,	11500
	dcSample	TYPE_DPCM,	PitchSnareS3,	13500	; dMidpitchSnare
; SFX
	dcSample	TYPE_PCM,	SegaPCM,	16000,	FLAGS_SFX
	; NOTE: sample rate is auto-detected from WAV file
	dc.w	-1	; end marker
; ---------------------------------------------------------------
	incdacStart
	incdac	Kick, "pcm/Kick.dpcm"
	incdac	Snare, "pcm/Snare.pcm"
	incdac	Timpani, "pcm/Timpani.dpcm"
	incdac	Clap, "pcm/Clap.dpcm"
	incdac	Scratch, "pcm/Scratch.dpcm"
	incdac	Bongo, "pcm/Bongo.dpcm"
	incdac	Tom, "pcm/Tom.pcm"

	incdac	KickS3, "pcm/KickS3.dpcm"
	incdac	SnareS3, "pcm/SnareS3.dpcm"
	incdac	CrashCymbalS3, "pcm/CrashCymbalS3.dpcm"
	incdac	ElectricTomS3, "pcm/ElectricTomS3.dpcm"
	incdac	PitchSnareS3, "pcm/PitchSnareS3.dpcm"

	incdac	SegaPCM, "pcm/Sega.pcm"
	incdacEnd
	even