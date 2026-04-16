; ---------------------------------------------------------------------------
; SMPS-Dusted driver data
; ---------------------------------------------------------------------------
SMPS_Start:
.s:	dc.w bgm__Last-bgm__First
	dc.w sfx__Last-sfx__First
	dc.w pcm__Last-pcm__First
	dc.w __smpsDataVer
	dc.w SMPS_MusicIndex-.s
	dc.w SMPS_SoundIndex-.s
	dc.w SMPS_UVB_FM-.s
	dc.w SMPS_VolEnvIndex-.s
	dc.w SMPS_ModEnvIndex-.s
	dc.w SMPS_SampleTable-.s
	dc.w SMPS_FmDrumTable-.s
	dc.w SMPS_PsgDrumTable-.s
	dc.w SMPS_PcmDrumTable-.s
; ---------------------------------------------------------------------------
; Universal Modulation Envelopes
; ---------------------------------------------------------------------------
SourceSMPS2ASM := 1
SourceDriver := 1
SMPS_ModEnvIndex:
	smpsEnvTable START
	smpsEnvTable SMPS_ModEnvIndex_m01,mEnv_01
	smpsEnvTable SMPS_ModEnvIndex_m02,mEnv_02
	smpsEnvTable SMPS_ModEnvIndex_m03,mEnv_03
	smpsEnvTable SMPS_ModEnvIndex_m04,mEnv_04
	smpsEnvTable SMPS_ModEnvIndex_m05,mEnv_05
	smpsEnvTable SMPS_ModEnvIndex_m06,mEnv_06
	smpsEnvTable SMPS_ModEnvIndex_m07,mEnv_07
	smpsEnvTable SMPS_ModEnvIndex_m08,mEnv_08
	smpsEnvTable END
SMPS_ModEnvIndex_m02:	smpsEnvMod $00
SMPS_ModEnvIndex_m01:	smpsEnvMod $01,$02,$01,$00,-$01,-$02,-$03,-$04,-$03,-$02,-$01,REST
SMPS_ModEnvIndex_m03:	smpsEnvMod $00,$00,$00,$00,$13,$26,$39,$4C,$5F,$72,$7F,$72,REST
SMPS_ModEnvIndex_m04:	smpsEnvMod $01,$02,$03,$02,$01,$00,-$01,-$02,-$03,-$02,-$01,$00,INDEX,0
SMPS_ModEnvIndex_m05:	smpsEnvMod $00,$00,$01,$03,$01,$00,-$01,-$03,-$01,$00,INDEX,2
SMPS_ModEnvIndex_m06:	smpsEnvMod $00,$00,$00,$00,  0, 10, 20, 30,  20,  10,   0, -10, -20, -30, -20, -10,INDEX,4
SMPS_ModEnvIndex_m07:	smpsEnvMod $00,$00,$00,$00, 22, 44, 66, 44,  22,   0, -22, -44, -66, -44, -22,INDEX,3
SMPS_ModEnvIndex_m08:	smpsEnvMod $01,$02,$03,$04,$03,$02,$01,$00,-$01,-$02,-$03,-$04,-$03,-$02,-$01,$00,INDEX,1
; ---------------------------------------------------------------------------
; Universal Volume Envelopes
; ---------------------------------------------------------------------------
SourceSMPS2ASM := 1
SourceDriver := 1
SMPS_VolEnvIndex:
	smpsEnvTable START
	smpsEnvTable SMPS_VolEnvIndex_f01,fTone_01
	smpsEnvTable SMPS_VolEnvIndex_f02,fTone_02
	smpsEnvTable SMPS_VolEnvIndex_f03,fTone_03
	smpsEnvTable SMPS_VolEnvIndex_f04,fTone_04
	smpsEnvTable SMPS_VolEnvIndex_f05,fTone_05
	smpsEnvTable SMPS_VolEnvIndex_f06,fTone_06
	smpsEnvTable SMPS_VolEnvIndex_f07,fTone_07
	smpsEnvTable SMPS_VolEnvIndex_f08,fTone_08
	smpsEnvTable SMPS_VolEnvIndex_f09,fTone_09
	smpsEnvTable SMPS_VolEnvIndex_f0A,fTone_0A
	smpsEnvTable SMPS_VolEnvIndex_f0B,fTone_0B
	smpsEnvTable SMPS_VolEnvIndex_f0C,fTone_0C
	smpsEnvTable SMPS_VolEnvIndex_f0D,fTone_0D
	smpsEnvTable SMPS_VolEnvIndex_s01,sTone_01
	smpsEnvTable SMPS_VolEnvIndex_s02,sTone_02
	smpsEnvTable SMPS_VolEnvIndex_s03,sTone_03
	smpsEnvTable SMPS_VolEnvIndex_s04,sTone_04
	smpsEnvTable SMPS_VolEnvIndex_s05,sTone_05
	smpsEnvTable SMPS_VolEnvIndex_s06,sTone_06
	smpsEnvTable SMPS_VolEnvIndex_s07,sTone_07
	smpsEnvTable SMPS_VolEnvIndex_s08,sTone_08
	smpsEnvTable SMPS_VolEnvIndex_s09,sTone_09
	smpsEnvTable SMPS_VolEnvIndex_s0A,sTone_0A
	smpsEnvTable SMPS_VolEnvIndex_s0B,sTone_0B
	smpsEnvTable SMPS_VolEnvIndex_s0C,sTone_0C
	smpsEnvTable SMPS_VolEnvIndex_s0D,sTone_0D
	smpsEnvTable SMPS_VolEnvIndex_s0E,sTone_0E
	smpsEnvTable SMPS_VolEnvIndex_s0F,sTone_0F
	smpsEnvTable SMPS_VolEnvIndex_s10,sTone_10
	smpsEnvTable SMPS_VolEnvIndex_s11,sTone_11
	smpsEnvTable SMPS_VolEnvIndex_s12,sTone_12
	smpsEnvTable SMPS_VolEnvIndex_s13,sTone_13
	smpsEnvTable SMPS_VolEnvIndex_s14,sTone_14
	smpsEnvTable SMPS_VolEnvIndex_s15,sTone_15
	smpsEnvTable SMPS_VolEnvIndex_s16,sTone_16
	smpsEnvTable SMPS_VolEnvIndex_s17,sTone_17
	smpsEnvTable SMPS_VolEnvIndex_s18,sTone_18
	smpsEnvTable SMPS_VolEnvIndex_s19,sTone_19
	smpsEnvTable SMPS_VolEnvIndex_s1A,sTone_1A
	smpsEnvTable SMPS_VolEnvIndex_s1B,sTone_1B
	smpsEnvTable SMPS_VolEnvIndex_s1C,sTone_1C
	smpsEnvTable SMPS_VolEnvIndex_s1D,sTone_1D
	smpsEnvTable SMPS_VolEnvIndex_s1E,sTone_1E
	smpsEnvTable SMPS_VolEnvIndex_s1F,sTone_1F
	smpsEnvTable SMPS_VolEnvIndex_s20,sTone_20
	smpsEnvTable SMPS_VolEnvIndex_s21,sTone_21
	smpsEnvTable SMPS_VolEnvIndex_s22,sTone_22
	smpsEnvTable SMPS_VolEnvIndex_s23,sTone_23
	smpsEnvTable SMPS_VolEnvIndex_s24,sTone_24
	smpsEnvTable SMPS_VolEnvIndex_s25,sTone_25
	smpsEnvTable SMPS_VolEnvIndex_s26,sTone_26
	smpsEnvTable SMPS_VolEnvIndex_s27,sTone_27
	smpsEnvTable END
SMPS_VolEnvIndex_f01:	smpsEnvVolPsg $00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$06,$06,$07,HOLD
SMPS_VolEnvIndex_f02:	smpsEnvVolPsg $00,$02,$04,$06,$08,$10,HOLD
SMPS_VolEnvIndex_f03:	smpsEnvVolPsg $00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$07,HOLD
SMPS_VolEnvIndex_f04:	smpsEnvVolPsg $00,$00,$02,$03,$04,$04,$05,$05,$05,$06,HOLD
SMPS_VolEnvIndex_f05:	smpsEnvVolPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02
			smpsEnvVolPsg $03,$03,$03,$03,$03,$03,$03,$03,$04,HOLD
SMPS_VolEnvIndex_f06:	smpsEnvVolPsg $03,$03,$03,$02,$02,$02,$02,$01,$01,$01,$00,$00,$00,$00,HOLD
SMPS_VolEnvIndex_f07:	smpsEnvVolPsg $00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02
			smpsEnvVolPsg $03,$03,$03,$04,$04,$04,$05,$05,$05,$06,$07,HOLD
SMPS_VolEnvIndex_f08:	smpsEnvVolPsg $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02
			smpsEnvVolPsg $03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$06
			smpsEnvVolPsg $06,$06,$06,$06,$07,$07,$07,HOLD
SMPS_VolEnvIndex_f09:	smpsEnvVolPsg $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,HOLD
SMPS_VolEnvIndex_f0A:	smpsEnvVolPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02
			smpsEnvVolPsg $02,$02,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$04,HOLD
SMPS_VolEnvIndex_f0B:	smpsEnvVolPsg $04,$04,$04,$03,$03,$03,$02,$02,$02,$01,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$04,HOLD
SMPS_VolEnvIndex_f0C:	smpsEnvVolPsg $04,$04,$03,$03,$02,$02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$02
			smpsEnvVolPsg $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03
			smpsEnvVolPsg $03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03,$03
			smpsEnvVolPsg $03,$03,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
			smpsEnvVolPsg $04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05
			smpsEnvVolPsg $05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06
			smpsEnvVolPsg $06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$06,$07,HOLD
SMPS_VolEnvIndex_f0D:	smpsEnvVolPsg $0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00,HOLD

SMPS_VolEnvIndex_s01:	smpsEnvVolPsg $02,REST
SMPS_VolEnvIndex_s02:	smpsEnvVolPsg $00,$02,$04,$06,$08,$10,REST
SMPS_VolEnvIndex_s03:	smpsEnvVolPsg $02,$01,$00,$00,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,HOLD
SMPS_VolEnvIndex_s04:	smpsEnvVolPsg $00,$00,$02,$03,$04,$04,$05,$05,$05,$06,$06,HOLD
SMPS_VolEnvIndex_s05:	smpsEnvVolPsg $03,$00,$01,$01,$01,$02,$03,$04,$04,$05,HOLD
SMPS_VolEnvIndex_s06:	smpsEnvVolPsg $00,$00,$01,$01,$02,$03,$04,$05,$05,$06,$08,$07,$07,$06,HOLD
SMPS_VolEnvIndex_s07:	smpsEnvVolPsg $01,$0C,$03,$0F,$02,$07,$03,$0F,REPEAT
SMPS_VolEnvIndex_s08:	smpsEnvVolPsg $00,$00,$00,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0F,HOLD
SMPS_VolEnvIndex_s09:	smpsEnvVolPsg $03,$02,$01,$01,$00,$00,$01,$02,$03,$04,HOLD
SMPS_VolEnvIndex_s0A:	smpsEnvVolPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,HOLD
SMPS_VolEnvIndex_s0B:	smpsEnvVol    $10,$20,$30,$40,$30,$20,$10,$00,$7F,REPEAT	; ...,-$10,REPEAT
SMPS_VolEnvIndex_s0C:	smpsEnvVolPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
SMPS_VolEnvIndex_s0D:	smpsEnvVolPsg $00,HOLD
SMPS_VolEnvIndex_s0E:	smpsEnvVolPsg $02,REST
SMPS_VolEnvIndex_s0F:	smpsEnvVolPsg $00,$02,$04,$06,$08,$7F,REST
SMPS_VolEnvIndex_s10:	smpsEnvVolPsg $09,$09,$09,$08,$08,$08,$07,$07,$07,$06,$06,$06,$05,$05,$05,$04
			smpsEnvVolPsg $04,$04,$03,$03,$03,$02,$02,$02,$01,$01,$01,$00,$00,$00,HOLD
SMPS_VolEnvIndex_s11:	smpsEnvVolPsg $01,$01,$01,$00,$00,$00,HOLD
SMPS_VolEnvIndex_s12:	smpsEnvVolPsg $03,$00,$01,$01,$01,$02,$03,$04,$04,$05,HOLD
SMPS_VolEnvIndex_s13:	smpsEnvVolPsg $00,$00,$01,$01,$02,$03,$04,$05,$05,$06,$08,$07,$07,$06,HOLD
SMPS_VolEnvIndex_s14:	smpsEnvVolPsg $0A,$05,$00,$04,$08,REST
SMPS_VolEnvIndex_s15:	smpsEnvVolPsg $00,$00,$00,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0F,REST
SMPS_VolEnvIndex_s16:	smpsEnvVolPsg $03,$02,$01,$01,$00,$00,$01,$02,$03,$04,HOLD
SMPS_VolEnvIndex_s17:	smpsEnvVolPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04
			smpsEnvVolPsg $04,$04,$05,$05,HOLD
SMPS_VolEnvIndex_s18:	smpsEnvVol    $10,$20,$30,$40,$30,$20,$10,$00,$10,$20,$30,$40,$30,$20,$10,$00
			smpsEnvVol    $10,$20,$30,$40,$30,$20,$10,$00,REPEAT
SMPS_VolEnvIndex_s19:	smpsEnvVolPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
SMPS_VolEnvIndex_s1A:	smpsEnvVol    $00,$02,$04,$06,$08,$16,REST
SMPS_VolEnvIndex_s1B:	smpsEnvVolPsg $00,$00,$01,$01,$03,$03,$04,$05,REST
SMPS_VolEnvIndex_s1C:	smpsEnvVolPsg $04,$04,$04,$04,$03,$03,$03,$03,$02,$02,$02,$02,$01,$01,$01,$01,REST
SMPS_VolEnvIndex_s1D:	smpsEnvVolPsg $00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$03
			smpsEnvVolPsg $04,$04,$04,$04,$05,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$07
			smpsEnvVolPsg $08,$08,$08,$08,$09,$09,$09,$09,$0A,$0A,$0A,$0A,HOLD
SMPS_VolEnvIndex_s1E:	smpsEnvVolPsg $00,$0A,REST
SMPS_VolEnvIndex_s1F:	smpsEnvVolPsg $00,$02,$04,HOLD
SMPS_VolEnvIndex_s20:	smpsEnvVol    $30,$20,$10,$00,$00,$00,$00,$00,$08,$10,$20,$30, HOLD
SMPS_VolEnvIndex_s21:	smpsEnvVolPsg $00,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$06,$06,$06,$08,$08
			smpsEnvVolPsg $0A,REST
SMPS_VolEnvIndex_s22:	smpsEnvVolPsg $00,$02,$03,$04,$06,$07,HOLD
SMPS_VolEnvIndex_s23:	smpsEnvVolPsg $02,$01,$00,$00,$00,$02,$04,$07,HOLD
SMPS_VolEnvIndex_s24:	smpsEnvVolPsg $0F,$01,$05,REST
SMPS_VolEnvIndex_s25:	smpsEnvVolPsg $08,$06,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$10,REST
SMPS_VolEnvIndex_s26:	smpsEnvVolPsg $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01
			smpsEnvVolPsg $01,$01,$01,$01,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$03,$03
			smpsEnvVolPsg $03,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04,$04,$04,$04,$04
			smpsEnvVolPsg $04,$04,$05,$05,$05,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06
			smpsEnvVolPsg $06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07
			smpsEnvVolPsg $08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09
;			smpsEnvVolPsg $09,$09		; S3A has these two extra ticks
			smpsEnvVolPsg $09,$09,REST
SMPS_VolEnvIndex_s27:	smpsEnvVolPsg $00,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$05,REST
; ---------------------------------------------------------------------------
; FM Universal Voice Bank
; ---------------------------------------------------------------------------
SourceSMPS2ASM := 1
SourceDriver := 3
SMPS_UVB_FM:
;	Voice 00h - Synth Bass 2
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBass2,pS3kSynthBass2
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
	smpsVcTotalLevel    $80, $07, $80, $1A
;	Voice 01h - Trumpet 1
	smpsVcIdentifier    SMPS_UVB_FM,pTrumpet1
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
	smpsVcTotalLevel    $80, $80, $80, $15
;	Voice 02h - Slap Bass 2
	smpsVcIdentifier    SMPS_UVB_FM,pSlapBass2
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
	smpsVcTotalLevel    $80, $15, $16, $13
;	Voice 03h - Synth Bass 1
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBass1
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
	smpsVcTotalLevel    $83, $18, $83, $10
;	Voice 04h - Bell Synth 1
	smpsVcIdentifier    SMPS_UVB_FM,pBellSynth1
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
	smpsVcTotalLevel    $80, $80, $80, $1B
;	Voice 05h - Bell Synth 2
	smpsVcIdentifier    SMPS_UVB_FM,pBellSynth2
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
	smpsVcTotalLevel    $87, $29, $80, $23
;	Voice 06h - Synth Brass 1
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBrass1
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
	smpsVcTotalLevel    $80, $27, $28, $18
;	Voice 07h - Synth like Bassoon
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBassoon
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
	smpsVcTotalLevel    $80, $0C, $80, $1E
;	Voice 08h - Bell Horn type thing
	smpsVcIdentifier    SMPS_UVB_FM,pBellHorn
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
	smpsVcTotalLevel    $87, $1D, $80, $15
;	Voice 09h - Synth Bass 3
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBass3
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
;	Voice 0Ah - Synth Trumpet
	smpsVcIdentifier    SMPS_UVB_FM,pSynthTrumper
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
	smpsVcTotalLevel    $80, $18, $22, $18
;	Voice 0Bh - Wood Block
	smpsVcIdentifier    SMPS_UVB_FM,pWoodBlock
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
	smpsVcTotalLevel    $80, $1A, $80, $33
;	Voice 0Ch - Tubular Bell
	smpsVcIdentifier    SMPS_UVB_FM,pTubularBell
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
	smpsVcTotalLevel    $97, $29, $90, $23
;	Voice 0Dh - Strike Bass
	smpsVcIdentifier    SMPS_UVB_FM,pStrikeBass
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
	smpsVcTotalLevel    $80, $1A, $19, $1A
;	Voice 0Eh - Elec Piano
	smpsVcIdentifier    SMPS_UVB_FM,pElecPiano
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
	smpsVcTotalLevel    $80, $1F, $27, $29
;	Voice 0Fh - Bright Piano
	smpsVcIdentifier    SMPS_UVB_FM,pBrightPiano
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
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $23, $80, $23
;	Voice 10h - Church Bell
	smpsVcIdentifier    SMPS_UVB_FM,pChurchBell
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
	smpsVcTotalLevel    $80, $14, $80, $1E
;	Voice 11h - Synth Brass 2
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBrass2
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
	smpsVcTotalLevel    $80, $82, $80, $1C
;	Voice 12h - Bell Piano
	smpsVcIdentifier    SMPS_UVB_FM,pBellPiano
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
	smpsVcTotalLevel    $80, $19, $80, $1E
;	Voice 13h - Wet Wood Bass
	smpsVcIdentifier    SMPS_UVB_FM,pWetWoodBass
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
	smpsVcTotalLevel    $80, $1E, $1E, $1E
;	Voice 14h - Silent Bass
	smpsVcIdentifier    SMPS_UVB_FM,pSilentBass
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
	smpsVcTotalLevel    $80, $28, $12, $21
;	Voice 15h - Picked Bass
	smpsVcIdentifier    SMPS_UVB_FM,pPickedBass
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
	smpsVcTotalLevel    $80, $1E, $14, $0E
;	Voice 16h - Xylophone
	smpsVcIdentifier    SMPS_UVB_FM,pXylophone
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
	smpsVcTotalLevel    $80, $A3, $80, $28
;	Voice 17h - Sine Flute
	smpsVcIdentifier    SMPS_UVB_FM,pSineFlute
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
	smpsVcTotalLevel    $80, $28, $32, $1B
;	Voice 18h - Pipe Organ
	smpsVcIdentifier    SMPS_UVB_FM,p
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
	smpsVcTotalLevel    $80, $80, $8A, $8A
;	Voice 19h - Synth Brass 3
	smpsVcIdentifier    SMPS_UVB_FM,pSynthBrass3
	smpsVcAlgorithm     $02
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $01, $01, $07, $01
	smpsVcRateScale     $01, $02, $02, $02
	smpsVcAttackRate    $13, $0E, $0D, $0D
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $03, $0E, $0E, $0E
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $00, $01, $0F, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $26, $28, $17
;	Voice 1Ah - Harpsichord
	smpsVcIdentifier    SMPS_UVB_FM,pHarpsichord
	smpsVcAlgorithm     $03
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $07, $03, $03
	smpsVcCoarseFreq    $04, $01, $01, $0A
	smpsVcRateScale     $03, $00, $00, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $0A, $0A, $00
	smpsVcDecayRate2    $03, $05, $05, $00
	smpsVcDecayLevel    $05, $01, $05, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $80, $0F, $1E, $32
;	Voice 1Bh - Metallic Bass
	smpsVcIdentifier    SMPS_UVB_FM,pMetallicBass1
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
	smpsVcTotalLevel    $8C, $84, $90, $16
;	Voice 1Ch - Alternate Metallic Bass
	smpsVcIdentifier    SMPS_UVB_FM,pMetallicBass2
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
	smpsVcTotalLevel    $80, $17, $80, $16
;	Voice 1Dh - Backdropped Metallic Bass
	smpsVcIdentifier    SMPS_UVB_FM,pBackdropMetallicBass
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
	smpsVcTotalLevel    $8F, $27, $28, $18
;	Voice 1Eh - Sine like Bell
	smpsVcIdentifier    SMPS_UVB_FM,pSineBell
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
	smpsVcTotalLevel    $80, $81, $8B, $1E
;	Voice 1Fh - Synth like Metallic with Small Bell
	smpsVcIdentifier    SMPS_UVB_FM,pMetallicSynthWithBell
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
	smpsVcTotalLevel    $8A, $1D, $85, $15
;	Voice 20h - Nice Synth like lead
	smpsVcIdentifier    SMPS_UVB_FM,pNiceSynthLead
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
	smpsVcTotalLevel    $8F, $8F, $8F, $1B
;	Voice 21h - Rock Organ
	smpsVcIdentifier    SMPS_UVB_FM,pRockOrgan
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
	smpsVcTotalLevel    $8A, $8A, $8A, $8A
;	Voice 22h - Strike like Slap Bass
	smpsVcIdentifier    SMPS_UVB_FM,pStrikeSlapBass
	smpsVcAlgorithm		$00
	smpsVcFeedback		$04
	smpsVcUnusedBits	$00
	smpsVcDetune		$03, $03, $03, $03
	smpsVcCoarseFreq	$01, $00, $05, $06
	smpsVcRateScale		$02, $02, $03, $03
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$06, $09, $06, $07
	smpsVcDecayRate2	$08, $06, $06, $07
	smpsVcDecayLevel	$0F, $01, $01, $02
	smpsVcReleaseRate	$08, $00, $00, $00
	smpsVcTotalLevel	$80, $13, $37, $19
; ---------------------------------------------------------------------------
; PCM Drums
; ---------------------------------------------------------------------------
SMPS_PcmDrumTable:
; ---------------------------------------------------------------------------
; FM Drums
; ---------------------------------------------------------------------------
SMPS_FmDrumTable:
; ---------------------------------------------------------------------------
; PSG Drums
; ---------------------------------------------------------------------------
; vibr,enve,noisetype
SMPS_PsgDrumTable:
	smpsEnvTable START
	smpsEnvTable SMPS_PsgDrumTable_01
	smpsEnvTable SMPS_PsgDrumTable_02
	smpsEnvTable SMPS_PsgDrumTable_03
	smpsEnvTable SMPS_PsgDrumTable_04
	smpsEnvTable SMPS_PsgDrumTable_05
	smpsEnvTable END
SMPS_PsgDrumTable_01:	dc.b  1<<3,fTone_02,$E5
SMPS_PsgDrumTable_02:	dc.b  1<<3,fTone_03,$E4
SMPS_PsgDrumTable_03:	dc.b  1<<3,fTone_02,$E4
SMPS_PsgDrumTable_04:	dc.b  2<<3,fTone_01,$E4
SMPS_PsgDrumTable_05:	dc.b  2<<3,fTone_02,$E4
; ---------------------------------------------------------------------------
; Music	index
; index start: "START" keyword, first song id
; song index: jingle flag, PAL speed adjustment disable, water muffle disable, song data pointer, song data id
; index end: "END" keyword, last song id
; ---------------------------------------------------------------------------
	even
SMPS_MusicIndex:
	musdef START,bgm__First
	musdef 0,0,0,BgmTest,bgm_Test
	musdef 0,0,0,BgmSoccer,bgm_Soccer
	musdef 0,0,0,BgmSCDTimeTravel,bgm_SCDTimeTravel

	musdef 0,0,0,BgmS1Title,bgm_S1Title
	musdef 0,0,0,BgmS1GHZ,bgm_S1GHZ
	musdef 0,0,0,BgmS1LZ,bgm_S1LZ
	musdef 0,0,0,BgmS1MZ,bgm_S1MZ
	musdef 0,0,0,BgmS1SLZ,bgm_S1SLZ
	musdef 0,0,0,BgmS1SYZ,bgm_S1SYZ
	musdef 0,0,0,BgmS1SBZ,bgm_S1SBZ
	musdef 0,0,0,BgmS1FZ,bgm_S1FZ
	musdef 0,0,0,BgmS1Boss,bgm_S1Boss
	musdef 0,0,0,BgmS1Special,bgm_S1Special
	musdef 0,0,0,BgmS1ActClear,bgm_S1ActClear
	musdef 0,0,0,BgmS1Invinc,bgm_S1Invinc
	musdef 1,0,0,BgmS1ExtraLife,bgm_S1ExtraLife
	musdef 1,0,0,BgmS1Continue,bgm_S1Continue
	musdef 1,0,0,BgmS1Emerald,bgm_S1Emerald
	musdef 0,1,1,BgmS1Drowning,bgm_S1Drowning
	musdef 0,1,1,BgmS1GameOver,bgm_S1GameOver
	musdef 0,0,0,BgmS1Ending,bgm_S1Ending
	musdef 0,1,1,BgmS1Credits,bgm_S1Credits

	musdef 0,0,0,BgmS2Title,bgm_S2Title
	musdef 0,0,0,BgmS2EHZ,bgm_S2EHZ
	musdef 0,0,0,BgmS2EHZ2P,bgm_S2EHZ2P
	musdef 0,0,0,BgmS2CPZ,bgm_S2CPZ
	musdef 0,0,0,BgmS2ARZ,bgm_S2ARZ
	musdef 0,0,0,BgmS2CNZ,bgm_S2CNZ
	musdef 0,0,0,BgmS2CNZ2P,bgm_S2CNZ2P
	musdef 0,0,0,BgmS2HTZ,bgm_S2HTZ
	musdef 0,0,0,BgmS2MCZ,bgm_S2MCZ
	musdef 0,0,0,BgmS2MCZ2P,bgm_S2MCZ2P
	musdef 0,0,0,BgmS2OOZ,bgm_S2OOZ
	musdef 0,0,0,BgmS2MTZ,bgm_S2MTZ
	musdef 0,0,0,BgmS2SCZ,bgm_S2SCZ
	musdef 0,0,0,BgmS2WFZ,bgm_S2WFZ
	musdef 0,0,0,BgmS2DEZ,bgm_S2DEZ
	musdef 0,0,0,BgmS2Special,bgm_S2Special
	musdef 0,0,0,BgmS2Boss,bgm_S2Boss
	musdef 0,0,0,BgmS2FinalBoss,bgm_S2FinalBoss
	musdef 0,0,0,BgmS2Invinc,bgm_S2Invinc
	musdef 0,0,0,BgmS2Super,bgm_S2Super
	musdef 0,0,0,BgmS2Ending,bgm_S2Ending
	musdef 0,0,1,BgmS2Credits,bgm_S2Credits
	musdef 0,0,0,BgmS2Options,bgm_S2Options
	musdef 0,0,0,BgmS2Menu2P,bgm_S2Menu2P

	musdef 0,0,0,BgmS2BTitle,bgm_S2BTitle
	musdef 0,0,0,BgmS2BGHZ,bgm_S2BGHZ
	musdef 0,0,0,BgmS2BCPZ,bgm_S2BCPZ
	musdef 0,0,0,BgmS2BNGHZ,bgm_S2BNGHZ
	musdef 0,0,0,BgmS2BCNZ,bgm_S2BCNZ
	musdef 0,0,0,BgmS2BHTZ,bgm_S2BHTZ
	musdef 0,0,0,BgmS2BDHZ,bgm_S2BDHZ
	musdef 0,0,0,BgmS2BOOZ,bgm_S2BOOZ
	musdef 0,0,0,BgmS2BMTZ,bgm_S2BMTZ
	musdef 0,0,0,BgmS2BSSZ,bgm_S2BSSZ
	musdef 0,0,0,BgmS2BRWZ,bgm_S2BRWZ
	musdef 0,0,0,BgmS2BDEZ,bgm_S2BDEZ
	musdef 0,0,0,BgmS2BBOZ,bgm_S2BBOZ
	musdef 0,0,0,BgmS2BWFZ,bgm_S2BWFZ
	musdef 0,0,0,BgmS2BHPZ,bgm_S2BHPZ
	musdef 0,0,0,BgmS2BSpecial,bgm_S2BSpecial
	musdef 0,0,0,BgmS2BBoss,bgm_S2BBoss
	musdef 0,0,0,BgmS2BFinalBoss,bgm_S2BFinalBoss
	musdef 0,0,0,BgmS2BLevelSelect,bgm_S2BLevelSelect
	musdef 0,0,0,BgmS2BMenu2P,bgm_S2BMenu2P

	musdef 0,0,0,BgmS3Title,bgm_S3Title
	musdef 0,0,0,BgmSKitle,bgm_SKitle
	musdef 0,0,0,BgmS3AIZ1,bgm_S3AIZ1
	musdef 0,0,0,BgmS3AIZ2,bgm_S3AIZ2
	musdef 0,0,0,BgmS3HCZ1,bgm_S3HCZ1
	musdef 0,0,0,BgmS3HCZ2,bgm_S3HCZ2
	musdef 0,0,0,BgmS3MGZ1,bgm_S3MGZ1
	musdef 0,0,0,BgmS3MZZ2,bgm_S3MZZ2
	musdef 0,0,0,BgmS3CNZ1,bgm_S3CNZ1
	musdef 0,0,0,BgmS3CNZ2,bgm_S3CNZ2
	musdef 0,0,0,BgmS3ICZ1,bgm_S3ICZ1
	musdef 0,0,0,BgmS3ICZ2,bgm_S3ICZ2
	musdef 0,0,0,BgmS3LBZ1,bgm_S3LBZ1
	musdef 0,0,0,BgmS3LBZ2,bgm_S3LBZ2
	musdef 0,0,0,BgmSKMHZ1,bgm_SKMHZ1
	musdef 0,0,0,BgmSKMHZ2,bgm_SKMHZ2
	musdef 0,0,0,BgmSKFBZ1,bgm_SKFBZ1
	musdef 0,0,0,BgmSKFBZ2,bgm_SKFBZ2
	musdef 0,0,0,BgmSKSOZ1,bgm_SKSOZ1
	musdef 0,0,0,BgmSKSOZ2,bgm_SKSOZ2
	musdef 0,0,0,BgmSKLRZ1,bgm_SKLRZ1
	musdef 0,0,0,BgmSKLRZ2,bgm_SKLRZ2
	musdef 0,0,0,BgmSKSSZ,bgm_SKSSZ
	musdef 0,0,0,BgmSKDEZ1,bgm_SKDEZ1
	musdef 0,0,0,BgmSKDEZ2,bgm_SKDEZ2
	musdef 0,0,0,BgmSKDDZ,bgm_SKDDZ
	musdef 0,0,0,BgmS3Gumball,bgm_S3Gumball
	musdef 0,0,0,BgmSKPachinko,bgm_SKPachinko
	musdef 0,0,0,BgmSKSlots,bgm_SKSlots
	musdef 0,0,0,BgmS3Special,bgm_S3Special
	musdef 0,0,0,BgmS3MiniBoss,bgm_S3MiniBoss
	musdef 0,0,0,BgmSKMiniBoss,bgm_SKMiniBoss
	musdef 0,0,0,BgmS3ZoneBoss,bgm_S3ZoneBoss
	musdef 0,0,0,BgmS3FinalBoss,bgm_S3FinalBoss
	musdef 0,0,0,BgmS3Knuckles,bgm_S3Knuckles
	musdef 0,0,0,BgmSKKnuckles,bgm_SKKnuckles
	musdef 0,0,0,BgmS3Invinc,bgm_S3Invinc
	musdef 0,0,0,BgmSKInvinc,bgm_SKInvinc
	musdef 1,0,0,BgmS3ExtraLife,bgm_S3ExtraLife
	musdef 1,0,0,BgmSKExtraLife,bgm_SKExtraLife
	musdef 0,0,0,BgmS3ActClear,bgm_S3ActClear
	musdef 0,0,1,BgmS3Drowning,bgm_S3Drowning
	musdef 0,0,1,BgmS3GameOver,bgm_S3GameOver
	musdef 0,0,0,BgmS3Continue,bgm_S3Continue
	musdef 0,0,0,BgmS3CompMenu,bgm_S3CompMenu
	musdef 0,0,0,BgmS3ALZ,bgm_S3ALZ
	musdef 0,0,0,BgmS3BPZ,bgm_S3BPZ
	musdef 0,0,0,BgmS3CGZ,bgm_S3CGZ
	musdef 0,0,0,BgmS3DPZ,bgm_S3DPZ
	musdef 0,0,0,BgmS3EMZ,bgm_S3EMZ
	musdef 0,0,0,BgmS3Complete,bgm_S3Complete
	musdef 0,0,0,BgmSKComplete,bgm_SKComplete
	musdef 0,0,1,BgmS3Credits,bgm_S3Credits
	musdef 0,0,1,BgmSKCredits,bgm_SKCredits

	musdef 0,0,0,BgmS3BCNZ1,bgm_S3BCNZ1
	musdef 0,0,0,BgmS3BCNZ2,bgm_S3BCNZ2
	musdef 0,0,0,BgmS3BICZ1,bgm_S3BICZ1
	musdef 0,0,0,BgmS3BICZ2,bgm_S3BICZ2
	musdef 0,0,0,BgmS3BLBZ1,bgm_S3BLBZ1
	musdef 0,0,0,BgmS3BLBZ2,bgm_S3BLBZ2
	musdef 0,0,0,BgmS3BKnuckles,bgm_S3BKnuckles
	musdef 0,0,1,BgmS3BCompMenu,bgm_S3BCompMenu
	musdef 0,0,1,BgmS3BCredits,bgm_S3BCredits
	musdef 0,0,1,BgmS3BUnused,bgm_S3BUnused

	musdef 0,0,0,BgmS3DIntro,bgm_S3DIntro
	musdef 0,0,0,BgmS3DMenu,bgm_S3DMenu
	musdef 0,0,0,BgmS3DGrGZ1,bgm_S3DGrGZ1
	musdef 0,0,0,BgmS3DGrGZ2,bgm_S3DGrGZ2
	musdef 0,0,0,BgmS3DRRZ1,bgm_S3DRRZ1
	musdef 0,0,0,BgmS3DRRZ2,bgm_S3DRRZ2
	musdef 0,0,0,BgmS3DSSZ1,bgm_S3DSSZ1
	musdef 0,0,0,BgmS3DSSZ2,bgm_S3DSSZ2
	musdef 0,0,0,BgmS3DDDZ1,bgm_S3DDDZ1
	musdef 0,0,0,BgmS3DDDZ2,bgm_S3DDDZ2
	musdef 0,0,0,BgmS3VVDZ1,bgm_S3VVDZ1
	musdef 0,0,0,BgmS3VVDZ2,bgm_S3VVDZ2
	musdef 0,0,0,BgmS3DGeGZ1,bgm_S3DGeGZ1
	musdef 0,0,0,BgmS3DGeGZ2,bgm_S3DGeGZ2
	musdef 0,0,0,BgmS3PPDZ1,bgm_S3PPDZ1
	musdef 0,0,0,BgmS3PPDZ2,bgm_S3PPDZ2
	musdef 0,0,0,BgmS3DSpecial,bgm_S3DSpecial
	musdef 0,0,0,BgmS3DInvinc,bgm_S3DInvinc
	musdef 0,0,0,BgmS3DBoss1,bgm_S3DBoss1
	musdef 0,0,0,BgmS3DBoss2,bgm_S3DBoss2
	musdef 0,0,0,BgmS3DBoss3,bgm_S3DBoss3
	musdef 0,0,0,BgmS3DFinalBoss,bgm_S3DFinalBoss
	musdef 0,0,0,BgmS3DEnding,bgm_S3DEnding
	musdef 0,0,1,BgmS3DCredits,bgm_S3DCredits

	musdef END,bgm__Last
SMPS_MusicIndex_Exit:
; ---------------------------------------------------------------------------
; Sound	effect index
; index start: "START" keyword, first sound id, last song id
; song index: sound priority (0 to ignore, 1 is lowest, $FF is highest), csfx flag, bsfx flag, water muffle disable, sound data pointer, sound data id
; index end: "END" keyword, last sound id
; ---------------------------------------------------------------------------
	even
SMPS_SoundIndex:
	sfxdef START,sfx__First,bgm__Last
	sfxdef $00,0,0,0,SfxTest,sfx_Test
	sfxdef $00,1,0,0,SfxFlicky,sfx_Flicky
	sfxdef $00,0,0,0,SfxFlickyGrab,sfx_FlickyGrab
	sfxdef $00,0,0,0,SfxSpindash,sfx_Spindash
	sfxdef $00,0,0,0,SfxSpikeMove,sfx_SpikeMove
	sfxdef $00,0,0,0,SfxSkidPSG,sfx_SkidPSG
	sfxdef $00,0,0,0,SfxSkidFM,sfx_SkidFM

	sfxdef $00,0,0,0,SfxS1A0,sfx_S1Jump
	sfxdef $70,0,0,0,SfxS1A1,sfx_S1Lamppost
	sfxdef $70,0,0,0,SfxS1A2,sfx_S1UnkA2
	sfxdef $70,0,0,0,SfxS1A3,sfx_S1Death
	sfxdef $70,0,0,0,SfxS1A4,sfx_S1Skid
	sfxdef $70,0,0,0,SfxS1A5,sfx_S1UnkA5
	sfxdef $70,0,0,0,SfxS1A6,sfx_S1HitSpikes
	sfxdef $70,0,0,0,SfxS1A7,sfx_S1Push
	sfxdef $70,0,0,0,SfxS1A8,sfx_S1SSGoal
	sfxdef $70,0,0,0,SfxS1A9,sfx_S1SSItem
	sfxdef $68,0,0,0,SfxS1AA,sfx_S1Splash
	sfxdef $70,0,0,0,SfxS1AB,sfx_S1UnkAB
	sfxdef $70,0,0,0,SfxS1AC,sfx_S1HitBoss
	sfxdef $70,0,0,1,SfxS1AD,sfx_S1Bubble
	sfxdef $60,0,0,0,SfxS1AE,sfx_S1Fireball
	sfxdef $70,0,0,0,SfxS1AF,sfx_S1Shield
	sfxdef $70,0,0,0,SfxS1B0,sfx_S1Saw
	sfxdef $60,0,0,0,SfxS1B1,sfx_S1Electric
	sfxdef $70,0,0,1,SfxS1B2,sfx_S1Drown
	sfxdef $60,0,0,0,SfxS1B3,sfx_S1Flamethrower
	sfxdef $70,0,0,0,SfxS1B4,sfx_S1Bumper
	sfxdef $70,0,0,0,SfxS1B5,sfx_S1Ring
	sfxdef $70,0,0,0,SfxS1B6,sfx_S1SpikesMove
	sfxdef $70,0,0,0,SfxS1B7,sfx_S1Rumbling
	sfxdef $70,0,0,0,SfxS1B8,sfx_S1UnkB8
	sfxdef $70,0,0,0,SfxS1B9,sfx_S1Collapse
	sfxdef $70,0,0,0,SfxS1BA,sfx_S1SSGlass
	sfxdef $70,0,0,0,SfxS1BB,sfx_S1Door
	sfxdef $70,0,0,0,SfxS1BC,sfx_S1Teleport
	sfxdef $70,0,0,0,SfxS1BD,sfx_S1ChainStomp
	sfxdef $70,0,0,0,SfxS1BE,sfx_S1Roll
	sfxdef $7F,0,0,0,SfxS1BF,sfx_S1Continue
	sfxdef $60,0,0,0,SfxS1C0,sfx_S1Basaran
	sfxdef $70,0,0,0,SfxS1C1,sfx_S1BreakItem
	sfxdef $70,0,0,1,SfxS1C2,sfx_S1Warning
	sfxdef $70,0,0,0,SfxS1C3,sfx_S1GiantRing
	sfxdef $70,0,0,0,SfxS1C4,sfx_S1Bomb
	sfxdef $70,0,0,0,SfxS1C5,sfx_S1Cash
	sfxdef $70,0,0,0,SfxS1C6,sfx_S1RingLoss
	sfxdef $70,0,0,0,SfxS1C7,sfx_S1ChainRise
	sfxdef $70,0,0,0,SfxS1C8,sfx_S1Burning
	sfxdef $70,0,0,0,SfxS1C9,sfx_S1Bonus
	sfxdef $70,0,0,0,SfxS1CA,sfx_S1EnterSS
	sfxdef $70,0,0,0,SfxS1CB,sfx_S1WallSmash
	sfxdef $70,0,0,0,SfxS1CC,sfx_S1Spring
	sfxdef $70,0,0,0,SfxS1CD,sfx_S1Switch
	sfxdef $70,0,0,0,SfxS1CE,sfx_S1RingLeft
	sfxdef $70,0,0,0,SfxS1CF,sfx_S1Signpost
	sfxdef $00,0,0,0,BfxS1D0,bfx_S1Waterfall

	sfxdef $00,0,0,0,SfxS2A0,sfx_S2A0
	sfxdef $70,0,0,0,SfxS2A1,sfx_S2A1
	sfxdef $70,0,0,0,SfxS2A2,sfx_S2A2
	sfxdef $70,0,0,0,SfxS2A3,sfx_S2A3
	sfxdef $70,0,0,0,SfxS2A4,sfx_S2A4
	sfxdef $70,0,0,0,SfxS2A5,sfx_S2A5
	sfxdef $70,0,0,0,SfxS2A6,sfx_S2A6
	sfxdef $70,0,0,0,SfxS2A7,sfx_S2A7
	sfxdef $70,0,0,0,SfxS2A8,sfx_S2A8
	sfxdef $70,0,0,0,SfxS2A9,sfx_S2A9
	sfxdef $68,0,0,0,SfxS2AA,sfx_S2AA
	sfxdef $70,0,0,0,SfxS2AB,sfx_S2AB
	sfxdef $70,0,0,0,SfxS2AC,sfx_S2AC
	sfxdef $70,0,0,0,SfxS2AD,sfx_S2AD
	sfxdef $60,0,0,0,SfxS2AE,sfx_S2AE
	sfxdef $70,0,0,0,SfxS2AF,sfx_S2AF
	sfxdef $70,0,0,0,SfxS2B0,sfx_S2B0
	sfxdef $60,0,0,0,SfxS2B1,sfx_S2B1
	sfxdef $70,0,0,0,SfxS2B2,sfx_S2B2
	sfxdef $60,0,0,0,SfxS2B3,sfx_S2B3
	sfxdef $70,0,0,0,SfxS2B4,sfx_S2B4
	sfxdef $70,0,0,0,SfxS2B5,sfx_S2B5
	sfxdef $70,0,0,0,SfxS2B6,sfx_S2B6
	sfxdef $70,0,0,0,SfxS2B7,sfx_S2B7
	sfxdef $70,0,0,0,SfxS2B8,sfx_S2B8
	sfxdef $70,0,0,0,SfxS2B9,sfx_S2B9
	sfxdef $70,0,0,0,SfxS2BA,sfx_S2BA
	sfxdef $70,0,0,0,SfxS2BB,sfx_S2BB
	sfxdef $70,0,0,0,SfxS2BC,sfx_S2BC
	sfxdef $70,0,0,0,SfxS2BD,sfx_S2BD
	sfxdef $70,0,0,0,SfxS2BE,sfx_S2BE
	sfxdef $7F,0,0,0,SfxS2BF,sfx_S2BF
	sfxdef $6F,0,0,0,SfxS2C0,sfx_S2C0
	sfxdef $70,0,0,0,SfxS2C1,sfx_S2C1
	sfxdef $70,0,0,0,SfxS2C2,sfx_S2C2
	sfxdef $70,0,0,0,SfxS2C3,sfx_S2C3
	sfxdef $70,0,0,0,SfxS2C4,sfx_S2C4
	sfxdef $70,0,0,0,SfxS2C5,sfx_S2C5
	sfxdef $70,0,0,0,SfxS2C6,sfx_S2C6
	sfxdef $70,0,0,0,SfxS2C7,sfx_S2C7
	sfxdef $70,0,0,0,SfxS2C8,sfx_S2C8
	sfxdef $70,0,0,0,SfxS2C9,sfx_S2C9
	sfxdef $70,0,0,0,SfxS2CA,sfx_S2CA
	sfxdef $70,0,0,0,SfxS2CB,sfx_S2CB
	sfxdef $70,0,0,0,SfxS2CC,sfx_S2CC
	sfxdef $6F,0,0,0,SfxS2CD,sfx_S2CD
	sfxdef $70,0,0,0,SfxS2CE,sfx_S2CE
	sfxdef $70,0,0,0,SfxS2CF,sfx_S2CF
	sfxdef $70,0,0,0,SfxS2D0,sfx_S2D0
	sfxdef $60,0,0,0,SfxS2D1,sfx_S2D1
	sfxdef $60,0,0,0,SfxS2D2,sfx_S2D2
	sfxdef $70,0,0,0,SfxS2D3,sfx_S2D3
	sfxdef $70,0,0,0,SfxS2D4,sfx_S2D4
	sfxdef $70,0,0,0,SfxS2D5,sfx_S2D5
	sfxdef $70,0,0,0,SfxS2D6,sfx_S2D6
	sfxdef $70,0,0,0,SfxS2D7,sfx_S2D7
	sfxdef $70,0,0,0,SfxS2D8,sfx_S2D8
	sfxdef $70,0,0,0,SfxS2D9,sfx_S2D9
	sfxdef $60,0,0,0,SfxS2DA,sfx_S2DA
	sfxdef $62,0,0,0,SfxS2DB,sfx_S2DB
	sfxdef $60,0,0,0,SfxS2DC,sfx_S2DC
	sfxdef $60,0,0,0,SfxS2DD,sfx_S2DD
	sfxdef $60,0,0,0,SfxS2DE,sfx_S2DE
	sfxdef $70,0,0,0,SfxS2DF,sfx_S2DF
	sfxdef $70,0,0,0,SfxS2E0,sfx_S2E0
	sfxdef $70,0,0,0,SfxS2E1,sfx_S2E1
	sfxdef $70,0,0,0,SfxS2E2,sfx_S2E2
	sfxdef $70,0,0,0,SfxS2E3,sfx_S2E3
	sfxdef $60,0,0,0,SfxS2E4,sfx_S2E4
	sfxdef $60,0,0,0,SfxS2E5,sfx_S2E5
	sfxdef $60,0,0,0,SfxS2E6,sfx_S2E6
	sfxdef $6F,0,0,0,SfxS2E7,sfx_S2E7
	sfxdef $70,0,0,0,SfxS2E8,sfx_S2E8
	sfxdef $70,0,0,0,SfxS2E9,sfx_S2E9
	sfxdef $6F,0,0,0,SfxS2EA,sfx_S2EA
	sfxdef $6F,0,0,0,SfxS2EB,sfx_S2EB
	sfxdef $70,0,0,0,SfxS2EC,sfx_S2EC
	sfxdef $71,0,0,0,SfxS2ED,sfx_S2ED
	sfxdef $70,0,0,0,SfxS2EE,sfx_S2EE
	sfxdef $70,0,0,0,SfxS2EF,sfx_S2EF
	sfxdef $6F,0,0,0,SfxS2F0,sfx_S2F0

	sfxdef $00,0,0,0,SfxS2BD0,sfx_S2BD0
	sfxdef $00,0,0,0,SfxS2BD1,sfx_S2BD1
	sfxdef $00,0,0,0,SfxS2BD2,sfx_S2BD2
	sfxdef $00,0,0,0,SfxS2BD3,sfx_S2BD3
	sfxdef $00,0,0,0,SfxS2BD4,sfx_S2BD4
	sfxdef $00,0,0,0,SfxS2BD5,sfx_S2BD5
	sfxdef $00,0,0,0,SfxS2BD6,sfx_S2BD6
	sfxdef $00,0,0,0,SfxS2BD7,sfx_S2BD7
	sfxdef $00,0,0,0,SfxS2BD8,sfx_S2BD8
	sfxdef $00,0,0,0,SfxS2BD9,sfx_S2BD9
	sfxdef $00,0,0,0,SfxS2BDA,sfx_S2BDA
	sfxdef $00,0,0,0,SfxS2BDB,sfx_S2BDB
	sfxdef $00,0,0,0,SfxS2BDC,sfx_S2BDC
	sfxdef $00,0,0,0,SfxS2BDD,sfx_S2BDD
	sfxdef $00,0,0,0,SfxS2BDE,sfx_S2BDE
	sfxdef $00,0,0,0,SfxS2BDF,sfx_S2BDF
	sfxdef $00,0,0,0,SfxS2BE0,sfx_S2BE0

	sfxdef $7A,0,0,0,SfxCdSKID,	sfx_CdSKID
	sfxdef $7A,0,0,0,SfxCd91,	sfx_Cd91
	sfxdef $7A,0,0,0,SfxCdJUMP,	sfx_CdJUMP
	sfxdef $7D,0,0,0,SfxCdHURT,	sfx_CdHURT
	sfxdef $7D,0,0,0,SfxCdRINGLOSS,	sfx_CdRINGLOSS
	sfxdef $70,0,0,0,SfxCdRING,	sfx_CdRING
	sfxdef $70,0,0,0,SfxCdDESTROY,	sfx_CdDESTROY
	sfxdef $7A,0,0,0,SfxCdSHIELD,	sfx_CdSHIELD
	sfxdef $70,0,0,0,SfxCdSPRING,	sfx_CdSPRING
	sfxdef $6D,0,0,0,SfxCd99,	sfx_Cd99
	sfxdef $7D,0,0,0,SfxCdKACHING,	sfx_CdKACHING
	sfxdef $7A,0,0,0,SfxCd9B,	sfx_Cd9B
	sfxdef $7A,0,0,0,SfxCd9C,	sfx_Cd9C
	sfxdef $70,0,0,0,SfxCdSIGNPOST,	sfx_CdSIGNPOST
	sfxdef $7A,0,0,0,SfxCdEXPLODE,	sfx_CdEXPLODE
	sfxdef $6D,0,0,0,SfxCd9F,	sfx_Cd9F
	sfxdef $70,0,0,0,SfxCdA0,	sfx_CdA0
	sfxdef $6D,0,0,0,SfxCdA1,	sfx_CdA1
	sfxdef $70,0,0,0,SfxCdA2,	sfx_CdA2
	sfxdef $70,0,0,0,SfxCdA3,	sfx_CdA3
	sfxdef $6D,0,0,0,SfxCdA4,	sfx_CdA4
	sfxdef $6D,0,0,0,SfxCdA5,	sfx_CdA5
	sfxdef $6D,0,0,0,SfxCdA6,	sfx_CdA6
	sfxdef $70,0,0,0,SfxCdA7,	sfx_CdA7
	sfxdef $70,0,0,0,SfxCdRINGL,	sfx_CdRINGL
	sfxdef $7D,0,0,0,SfxCdA9,	sfx_CdA9
	sfxdef $70,0,0,0,SfxCdAA,	sfx_CdAA
	sfxdef $7D,0,0,0,SfxCdCHARGESTOP,sfx_CdCHARGESTOP
	sfxdef $70,0,0,0,SfxCdAC,	sfx_CdAC
	sfxdef $7D,0,0,0,SfxCdAD,	sfx_CdAD
	sfxdef $7A,0,0,0,SfxCdCHECKPOINT,sfx_CdCHECKPOINT
	sfxdef $7A,0,0,0,SfxCdBIGRING,	sfx_CdBIGRING
	sfxdef $70,0,0,0,SfxCdB0,	sfx_CdB0
	sfxdef $70,0,0,0,SfxCdB1,	sfx_CdB1
	sfxdef $70,0,0,0,SfxCdB2,	sfx_CdB2
	sfxdef $6D,0,0,0,SfxCdB3,	sfx_CdB3
	sfxdef $70,0,0,0,SfxCdB4,	sfx_CdB4
	sfxdef $70,0,0,0,SfxCdB5,	sfx_CdB5
	sfxdef $7A,0,0,0,SfxCdB6,	sfx_CdB6
	sfxdef $70,0,0,0,SfxCdB7,	sfx_CdB7
	sfxdef $7D,0,0,0,SfxCdB8,	sfx_CdB8
	sfxdef $7D,0,0,0,SfxCdB9,	sfx_CdB9
	sfxdef $6A,0,0,0,SfxCdBA,	sfx_CdBA
	sfxdef $6D,0,0,0,SfxCdBB,	sfx_CdBB
	sfxdef $7D,0,0,0,SfxCdBC,	sfx_CdBC
	sfxdef $6D,0,0,0,SfxCdTALLY,	sfx_CdTALLY
	sfxdef $6D,0,0,0,SfxCdBE,	sfx_CdBE
	sfxdef $6D,0,0,0,SfxCdBF,	sfx_CdBF
	sfxdef $70,0,0,0,SfxCdC0,	sfx_CdC0
	sfxdef $70,0,0,0,SfxCdC1,	sfx_CdC1
	sfxdef $70,0,0,0,SfxCdC2,	sfx_CdC2
	sfxdef $7A,0,0,0,SfxCdC3,	sfx_CdC3
	sfxdef $70,0,0,0,SfxCdC4,	sfx_CdC4
	sfxdef $70,0,0,0,SfxCdC5,	sfx_CdC5
	sfxdef $70,0,0,0,SfxCdC6,	sfx_CdC6
	sfxdef $70,0,0,0,SfxCdC7,	sfx_CdC7
	sfxdef $7D,0,0,0,SfxCdSSWARP,	sfx_CdSSWARP
	sfxdef $70,0,0,0,SfxCdC9,	sfx_CdC9
	sfxdef $70,0,0,0,SfxCdCA,	sfx_CdCA
	sfxdef $6D,0,0,0,SfxCdCB,	sfx_CdCB
	sfxdef $6D,0,0,0,SfxCdCC,	sfx_CdCC
	sfxdef $70,0,0,0,SfxCdCD,	sfx_CdCD
	sfxdef $7A,0,0,0,SfxCdCE,	sfx_CdCE
	sfxdef $70,0,0,0,SfxCdCF,	sfx_CdCF
	sfxdef $6D,0,0,0,SfxCdD0,	sfx_CdD0
	sfxdef $6D,0,0,0,SfxCdD1,	sfx_CdD1
	sfxdef $7A,0,0,0,SfxCdD2,	sfx_CdD2
	sfxdef $70,0,0,0,SfxCdD3,	sfx_CdD3
	sfxdef $70,0,0,0,SfxCdD4,	sfx_CdD4
	sfxdef $6D,0,0,0,SfxCdD5,	sfx_CdD5
	sfxdef $6A,0,0,0,SfxCdD6,	sfx_CdD6
	sfxdef $6D,0,0,0,SfxCdD7,	sfx_CdD7
	sfxdef $70,0,0,0,SfxCdD9,	sfx_CdD9
	sfxdef $70,0,0,0,SfxCdDA,	sfx_CdDA
	sfxdef $70,0,0,0,SfxCdDB,	sfx_CdDB
	sfxdef $70,0,0,0,SfxCdDC,	sfx_CdDC
	sfxdef $70,0,0,0,SfxCdDD,	sfx_CdDD
	sfxdef $70,0,0,0,SfxCdDE,	sfx_CdDE
	sfxdef $00,0,0,0,SfxCdDF,	sfx_CdDF

	sfxdef $00,0,0,0,SfxS333, sfxS3_RingRight
	sfxdef $00,0,0,0,SfxS334, sfxS3_RingLeft
	sfxdef $00,0,0,0,SfxS335, sfxS3_Death
	sfxdef $00,0,0,0,SfxS336, sfxS3_Skid
	sfxdef $00,0,0,0,SfxS337, sfxS3_SpikeHit
	sfxdef $00,0,0,0,SfxS338, sfxS3_Bubble
	sfxdef $00,0,0,0,SfxS339, sfxS3_Splash
	sfxdef $00,0,0,0,SfxS33A, sfxS3_Shield
	sfxdef $00,0,0,0,SfxS33B, sfxS3_Drown
	sfxdef $00,0,0,0,SfxS33C, sfxS3_Roll
	sfxdef $00,0,0,0,SfxS33D, sfxS3_Break
	sfxdef $00,0,0,0,SfxS33E, sfxS3_FireShield
	sfxdef $00,0,0,0,SfxS33F, sfxS3_BubbleShield
	sfxdef $00,0,0,0,SfxS340, sfxS3_UnknownShield
	sfxdef $00,0,0,0,SfxS341, sfxS3_LightningShield
	sfxdef $00,0,0,0,SfxS342, sfxS3_InstaAttack
	sfxdef $00,0,0,0,SfxS343, sfxS3_FireAttack
	sfxdef $00,0,0,0,SfxS344, sfxS3_BubbleAttack
	sfxdef $00,0,0,0,SfxS345, sfxS3_ElectricAttack
	sfxdef $00,0,0,0,SfxS346, sfxS3_Whistle
	sfxdef $00,0,0,0,SfxS347, sfxS3_SandwallRise
	sfxdef $00,0,0,0,SfxS348, sfxS3_Blast
	sfxdef $00,0,0,0,SfxS349, sfxS3_Thump
	sfxdef $00,0,0,0,SfxS34A, sfxS3_Grab
	sfxdef $00,0,0,0,SfxS34B, sfxS3_WaterfallSplash
	sfxdef $00,0,0,0,SfxS34C, sfxS3_GlideLand
	sfxdef $00,0,0,0,SfxS34D, sfxS3_Projectile
	sfxdef $00,0,0,0,SfxS34E, sfxS3_MissileExplode
	sfxdef $00,0,0,0,SfxS34F, sfxS3_FlamethrowerQuiet
	sfxdef $00,0,0,0,SfxS350, sfxS3_BossActivate
	sfxdef $00,0,0,0,SfxS351, sfxS3_MissileThrow
	sfxdef $00,0,0,0,SfxS352, sfxS3_SpikeMove
	sfxdef $00,0,0,0,SfxS353, sfxS3_Charging
	sfxdef $00,0,0,0,SfxS354, sfxS3_BossLaser
	sfxdef $00,0,0,0,SfxS355, sfxS3_BlockConveyor
	sfxdef $00,0,0,0,SfxS356, sfxS3_FlipBridge
	sfxdef $00,0,0,0,SfxS357, sfxS3_Geyser
	sfxdef $00,0,0,0,SfxS358, sfxS3_FanLatch
	sfxdef $00,0,0,0,SfxS359, sfxS3_Collapse
	sfxdef $00,0,0,0,SfxS35A, sfxS3_UnknownCharge
	sfxdef $00,0,0,0,SfxS35B, sfxS3_Switch
	sfxdef $00,0,0,0,SfxS35C, sfxS3_MechaSpark
	sfxdef $00,0,0,0,SfxS35D, sfxS3_FloorThump
	sfxdef $00,0,0,0,SfxS35E, sfxS3_Laser
	sfxdef $00,0,0,0,SfxS35F, sfxS3_Crash
	sfxdef $00,0,0,0,SfxS360, sfxS3_BossZoom
	sfxdef $00,0,0,0,SfxS361, sfxS3_BossHitFloor
	sfxdef $00,0,0,0,SfxS362, sfxS3_Jump
	sfxdef $00,0,0,0,SfxS363, sfxS3_Starpost
	sfxdef $00,0,0,0,SfxS364, sfxS3_PulleyGrab
	sfxdef $00,0,0,0,SfxS365, sfxS3_BlueSphere
	sfxdef $00,0,0,0,SfxS366, sfxS3_AllSpheres
	sfxdef $00,0,0,0,SfxS367, sfxS3_LevelProjectile
	sfxdef $00,0,0,0,SfxS368, sfxS3_Perfect
	sfxdef $00,0,0,0,SfxS369, sfxS3_PushBlock
	sfxdef $00,0,0,0,SfxS36A, sfxS3_Goal
	sfxdef $00,0,0,0,SfxS36B, sfxS3_ActionBlock
	sfxdef $00,0,0,0,SfxS36C, sfxS3_Splash2
	sfxdef $00,0,0,0,SfxS36D, sfxS3_UnknownShift
	sfxdef $00,0,0,0,SfxS36E, sfxS3_BossHit
	sfxdef $00,0,0,0,SfxS36F, sfxS3_Rumble2
	sfxdef $00,0,0,0,SfxS370, sfxS3_LavaBall
	sfxdef $00,0,0,0,SfxS371, sfxS3_Shield2
	sfxdef $00,0,0,0,SfxS372, sfxS3_Hoverpad
	sfxdef $00,0,0,0,SfxS373, sfxS3_Transporter
	sfxdef $00,0,0,0,SfxS374, sfxS3_TunnelBooster
	sfxdef $00,0,0,0,SfxS375, sfxS3_BalloonPlatform
	sfxdef $00,0,0,0,SfxS376, sfxS3_TrapDoor
	sfxdef $00,0,0,0,SfxS377, sfxS3_Balloon
	sfxdef $00,0,0,0,SfxS378, sfxS3_GravityMachine
	sfxdef $00,0,0,0,SfxS379, sfxS3_Lightning
	sfxdef $00,0,0,0,SfxS37A, sfxS3_BossMagma
	sfxdef $00,0,0,0,SfxS37B, sfxS3_SmallBumpers
	sfxdef $00,0,0,0,SfxS37C, sfxS3_ChainTension
	sfxdef $00,0,0,0,SfxS37D, sfxS3_UnknownPump
	sfxdef $00,0,0,0,SfxS37E, sfxS3_GroundSlide
	sfxdef $00,0,0,0,SfxS37F, sfxS3_FrostPuff
	sfxdef $00,0,0,0,SfxS380, sfxS3_IceSpikes
	sfxdef $00,0,0,0,SfxS381, sfxS3_TubeLauncher
	sfxdef $00,0,0,0,SfxS382, sfxS3_SandSplash
	sfxdef $00,0,0,0,SfxS383, sfxS3_BridgeCollapse
	sfxdef $00,0,0,0,SfxS384, sfxS3_UnknownPowerUp
	sfxdef $00,0,0,0,SfxS385, sfxS3_UnknownPowerDown
	sfxdef $00,0,0,0,SfxS386, sfxS3_Alarm
	sfxdef $00,0,0,0,SfxS387, sfxS3_MushroomBounce
	sfxdef $00,0,0,0,SfxS388, sfxS3_PulleyMove
	sfxdef $00,0,0,0,SfxS389, sfxS3_WeatherMachine
	sfxdef $00,0,0,0,SfxS38A, sfxS3_Bouncy
	sfxdef $00,0,0,0,SfxS38B, sfxS3_ChopTree
	sfxdef $00,0,0,0,SfxS38C, sfxS3_ChopStuck
	sfxdef $00,0,0,0,SfxS38D, sfxS3_UnknownFlutter
	sfxdef $00,0,0,0,SfxS38E, sfxS3_UnknownRevving
	sfxdef $00,0,0,0,SfxS38F, sfxS3_DoorOpen
	sfxdef $00,0,0,0,SfxS390, sfxS3_DoorMove
	sfxdef $00,0,0,0,SfxS391, sfxS3_DoorClose
	sfxdef $00,0,0,0,SfxS392, sfxS3_GhostAppear
	sfxdef $00,0,0,0,SfxS393, sfxS3_BossRecovery
	sfxdef $00,0,0,0,SfxS394, sfxS3_ChainTick
	sfxdef $00,0,0,0,SfxS395, sfxS3_BossHand
	sfxdef $00,0,0,0,SfxS396, sfxS3_MechaLand
	sfxdef $00,0,0,0,SfxS397, sfxS3_EnemyBreath
	sfxdef $00,0,0,0,SfxS398, sfxS3_BossProjectile
	sfxdef $00,0,0,0,SfxS399, sfxS3_UnknownPlink
	sfxdef $00,0,0,0,SfxS39A, sfxS3_SpringLatch
	sfxdef $00,0,0,0,SfxS39B, sfxS3_ThumpBoss
	sfxdef $00,0,0,0,SfxSK9B, sfxSK_ThumpBoss
	sfxdef $00,0,0,0,SfxS39C, sfxS3_SuperEmerald
	sfxdef $00,0,0,0,SfxS39D, sfxS3_Targeting
	sfxdef $00,0,0,0,SfxS39E, sfxS3_Clank
	sfxdef $00,0,0,0,SfxS39F, sfxS3_SuperTransform
	sfxdef $00,0,0,0,SfxS3A0, sfxS3_MissileShoot
	sfxdef $00,0,0,0,SfxS3A1, sfxS3_UnknownOminous
	sfxdef $00,0,0,0,SfxS3A2, sfxS3_FloorLauncher
	sfxdef $00,0,0,0,SfxS3A3, sfxS3_GravityLift
	sfxdef $00,0,0,0,SfxS3A4, sfxS3_MechaTransform
	sfxdef $00,0,0,0,SfxS3A5, sfxS3_UnknownRise
	sfxdef $00,0,0,0,SfxS3A6, sfxS3_LaunchGrab
	sfxdef $00,0,0,0,SfxS3A7, sfxS3_LaunchReady
	sfxdef $00,0,0,0,SfxS3A8, sfxS3_EnergyZap
	sfxdef $00,0,0,0,SfxS3A9, sfxS3_AirDing
	sfxdef $00,0,0,0,SfxS3AA, sfxS3_Bumper
	sfxdef $00,0,0,0,SfxS3AB, sfxS3_Spindash
	sfxdef $00,0,0,0,SfxS3AC, sfxS3_Continue
	sfxdef $00,0,0,0,SfxS3AD, sfxS3_LaunchGo
	sfxdef $00,0,0,0,SfxS3AE, sfxS3_Flipper
	sfxdef $00,0,0,0,SfxS3AF, sfxS3_EnterSS
	sfxdef $00,0,0,0,SfxS3B0, sfxS3_Register
	sfxdef $00,0,0,0,SfxS3B1, sfxS3_Spring
	sfxdef $00,0,0,0,SfxS3B2, sfxS3_Error
	sfxdef $00,0,0,0,SfxS3B3, sfxS3_BigRing
	sfxdef $00,0,0,0,SfxS3B4, sfxS3_Explode
	sfxdef $00,0,0,0,SfxS3B5, sfxS3_Diamonds
	sfxdef $00,0,0,0,SfxS3B6, sfxS3_Dash
	sfxdef $00,0,0,0,SfxS3B7, sfxS3_SlotMachine
	sfxdef $00,0,0,0,SfxS3B8, sfxS3_Signpost
	sfxdef $00,0,0,0,SfxS3B9, sfxS3_RingLoss
	sfxdef $00,0,0,0,SfxS3BA, sfxS3_Flying
	sfxdef $00,0,0,0,SfxS3BB, sfxS3_FlyTired
	sfxdef $00,0,1,0,CsfxS3BC,csfxS3_SlideSkidLoud
	sfxdef $00,0,1,0,CsfxS3BD,csfxS3_LargeShip
	sfxdef $00,0,1,0,CsfxS3BE,csfxS3_RobotnikSiren
	sfxdef $00,0,1,0,CsfxS3BF,csfxS3_BossRotate
	sfxdef $00,0,1,0,CsfxS3C0,csfxS3_FanBig
	sfxdef $00,0,1,0,CsfxS3C1,csfxS3_FanSmall
	sfxdef $00,0,1,0,CsfxS3C2,csfxS3_FlamethrowerLoud
	sfxdef $00,0,1,0,CsfxS3C3,csfxS3_GravityTunnel
	sfxdef $00,0,1,0,CsfxS3C4,csfxS3_BossPanic
	sfxdef $00,0,1,0,CsfxS3C5,csfxS3_UnknownSpin
	sfxdef $00,0,1,0,CsfxS3C6,csfxS3_WaveHover
	sfxdef $00,0,1,0,CsfxS3C7,csfxS3_CannonTurn
	sfxdef $00,0,1,0,CsfxS3C8,csfxS3_SlideSkidQuiet
	sfxdef $00,0,1,0,CsfxS3C9,csfxS3_SpikeBalls
	sfxdef $00,0,1,0,CsfxS3CA,csfxS3_LightTunnel
	sfxdef $00,0,1,0,CsfxS3CB,csfxS3_Rumble
	sfxdef $00,0,1,0,CsfxS3CC,csfxS3_BigRumble
	sfxdef $00,0,1,0,CsfxS3CD,csfxS3_DeathEggRiseLoud
	sfxdef $00,0,1,0,CsfxS3CE,csfxS3_WindQuiet
	sfxdef $00,0,1,0,CsfxS3CF,csfxS3_WindLoud
	sfxdef $00,0,1,0,CsfxS3D0,csfxS3_Rising
	sfxdef $00,0,1,0,CsfxS3D1,csfxS3_UnknownFlutter2
	sfxdef $00,0,1,0,CsfxS3D2,csfxS3_GumballTab
	sfxdef $00,0,1,0,CsfxS3D3,csfxS3_DeathEggRiseQuiet
	sfxdef $00,0,1,0,CsfxS3D4,csfxS3_TurbineHum
	sfxdef $00,0,1,0,CsfxS3D5,csfxS3_LavaFall
	sfxdef $00,0,1,0,CsfxS3D6,csfxS3_UnknownZap
	sfxdef $00,0,1,0,CsfxS3D7,csfxS3_ConveyorPlatform
	sfxdef $00,0,1,0,CsfxS3D8,csfxS3_UnknownSaw
	sfxdef $00,0,1,0,CsfxS3D9,csfxS3_MagneticSpike
	sfxdef $00,0,1,0,CsfxS3DA,csfxS3_LeafBlower
	sfxdef $00,0,1,0,CsfxS3DB,csfxS3_WaterSkid

	sfxdef END,sfx__Last
SMPS_SoundIndex_Exit:
; ---------------------------------------------------------------------------
; PCM Samples
; ---------------------------------------------------------------------------
	even
SMPS_SampleTable:
; ============= type	expected driver		sequence id start	queue id start			queue id start label
	pcmdef	START,	MegaPCM2,		$81,			sfx__Last,			pcm__First
; ============= type	pointer			sequence id		queue id			Hz	Additional commands
; S1/2
	pcmdef	DPCM,	Kick,			dKick,			pcm_Kick,			8000
	pcmdef	PCM,	Snare,			dSnare,			pcm_Snare,			24000
	pcmdef	DPCM,	Clap,			dClap,			pcm_Clap,			17000
	pcmdef	DPCM,	Scratch,		dScratch,		pcm_Scratch,			15000
	pcmdef	DPCM,	Timpani,		dTimpani,		pcm_Timpani,			7250
	pcmdef	PCM,	Tom,			dHiTom,			pcm_HiTom,			14000
	pcmdef	DPCM,	Bongo,			dVLowClap,		pcm_VLowClap,			7500
	pcmdef	DPCM,	Timpani,		dHiTimpani,		pcm_HiTimpani,			9750
	pcmdef	DPCM,	Timpani,		dMidTimpani,		pcm_MidTimpani,			8750
	pcmdef	DPCM,	Timpani,		dLowTimpani,		pcm_LowTimpani,			7150
	pcmdef	DPCM,	Timpani,		dVLowTimpani,		pcm_VLowTimpani,		7000
	pcmdef	PCM,	Tom,			dMidTom,		pcm_MidTom,			23000
	pcmdef	PCM,	Tom,			dLowTom,		pcm_LowTom,			18000
	pcmdef	PCM,	Tom,			dFloorTom,		pcm_FloorTom,			15000
	pcmdef	DPCM,	Bongo,			dHiClap,		pcm_HiClap,			15000
	pcmdef	DPCM,	Bongo,			dMidClap,		pcm_MidClap,			13000
	pcmdef	DPCM,	Bongo,			dLowClap,		pcm_LowClap,			9750
; S3/K/D ; god I hate the naming inconsistencies
	pcmdef	DPCM,	SnareS3,		dSnareS3,		pcm_SnareS3,			19000
	pcmdef	DPCM,	TomS3,			dHighTom,		pcm_HighTom,			11500
	pcmdef	DPCM,	TomS3,			dMidTomS3,		pcm_MidTomS3,			9000
	pcmdef	DPCM,	TomS3,			dLowTomS3,		pcm_LowTomS3,			7500
	pcmdef	DPCM,	TomS3,			dFloorTomS3,		pcm_FloorTomS3,			6500
	pcmdef	DPCM,	KickS3,			dKickS3,		pcm_KickS3,			19000
	pcmdef	DPCM,	MuffledSnare,		dMuffledSnare,		pcm_MuffledSnare,		19000
	pcmdef	DPCM,	CrashCymbalS3,		dCrashCymbal,		pcm_CrashCymbal,		17000
	pcmdef	DPCM,	RideCymbal,		dRideCymbal,		pcm_RideCymbal,			13500
	pcmdef	DPCM,	MetalHit,		dLowMetalHit,		pcm_LowMetalHit,		9000
	pcmdef	DPCM,	MetalHit,		dMetalHit,		pcm_MetalHit,			7375
	pcmdef	DPCM,	HighMetalHit,		dHighMetalHit,		pcm_HighMetalHit,		15000
	pcmdef	DPCM,	HigherMetalHit,		dHigherMetalHit,	pcm_HigherMetalHit,		13000
	pcmdef	DPCM,	HigherMetalHit,		dMidMetalHit,		pcm_MidMetalHit,		10000
	pcmdef	DPCM,	ClapS3,			dClapS3,		pcm_ClapS3,			15000
	pcmdef	DPCM,	ElectricTomS3,		dElectricHighTom,	pcm_ElectricHighTom,		20500
	pcmdef	DPCM,	ElectricTomS3,		dElectricMidTom,	pcm_ElectricMidTom,		16000
	pcmdef	DPCM,	ElectricTomS3,		dElectricLowTom,	pcm_ElectricLowTom,		13500
	pcmdef	DPCM,	ElectricTomS3,		dElectricFloorTom,	pcm_ElectricFloorTom,		11500
	pcmdef	DPCM,	PitchSnareS3,		dTightSnare,		pcm_TightSnare,			17000
	pcmdef	DPCM,	PitchSnareS3,		dMidpitchSnare,		pcm_MidpitchSnare,		13500
	pcmdef	DPCM,	PitchSnareS3,		dLooseSnare,		pcm_LooseSnare,			12000
	pcmdef	DPCM,	PitchSnareS3,		dLooserSnare,		pcm_LooserSnare,		9750
	pcmdef	DPCM,	TimpaniS3,		dHiTimpaniS3,		pcm_HiTimpaniS3,		13000
	pcmdef	DPCM,	TimpaniS3,		dLowTimpaniS3,		pcm_LowTimpaniS3,		9250
	pcmdef	DPCM,	TimpaniS3,		dMidTimpaniS3,		pcm_MidTimpaniS3,		8500	; uhh
	pcmdef	DPCM,	QuickLooseSnare,	dQuickLooseSnare,	pcm_QuickLooseSnare,		12500
	pcmdef	DPCM,	Click,			dClick,			pcm_Click,			13500
	pcmdef	DPCM,	PowerKick,		dPowerKick,		pcm_PowerKick,			8000
	pcmdef	DPCM,	QuickGlassCrash,	dQuickGlassCrash,	pcm_QuickGlassCrash,		8000
	pcmdef	DPCM,	GlassCrashSnare,	dGlassCrashSnare,	pcm_GlassCrashSnare,		12500
	pcmdef	DPCM,	GlassCrash,		dGlassCrash,		pcm_GlassCrash,			12500
	pcmdef	DPCM,	GlassCrashKick,		dGlassCrashKick,	pcm_GlassCrashKick,		13500
	pcmdef	DPCM,	QuietGlassCrash,	dQuietGlassCrash,	pcm_QuietGlassCrash,		13500
	pcmdef	DPCM,	OddSnareKick,		dOddSnareKick,		pcm_OddSnareKick,		8000
	pcmdef	DPCM,	KickExtraBass,		dKickExtraBass,		pcm_KickExtraBass,		8000
	pcmdef	DPCM,	ComeOn,			dComeOn,		pcm_ComeOn,			12500
	pcmdef	DPCM,	DanceSnare,		dDanceSnare,		pcm_DanceSnare,			14000
	pcmdef	DPCM,	LooseKick,		dLooseKick,		pcm_LooseKick,			8000
	pcmdef	DPCM,	ModLooseKick,		dModLooseKick,		pcm_ModLooseKick,		8000
	pcmdef	DPCM,	Woo,			dWoo,			pcm_Woo,			12500
	pcmdef	DPCM,	Go,			dGo,			pcm_Go,				13500
	pcmdef	DPCM,	SnareGo,		dSnareGo,		pcm_SnareGo,			12000
	pcmdef	DPCM,	PowerTom,		dPowerTom,		pcm_PowerTom,			17000
	pcmdef	DPCM,	WoodBlock,		dHiWoodBlock,		pcm_HiWoodBlock,		10500
	pcmdef	DPCM,	WoodBlock,		dLowWoodBlock,		pcm_LowWoodBlock,		8000
	pcmdef	DPCM,	HitDrum,		dHiHitDrum,		pcm_HiHitDrum,			14000
	pcmdef	DPCM,	HitDrum,		dLowHitDrum,		pcm_LowHitDrum,			9750
	pcmdef	DPCM,	MetalCrashHit,		dMetalCrashHit,		pcm_MetalCrashHit,		8000
	pcmdef	DPCM,	EchoedClapHitSK,	dEchoedClapHit,		pcm_EchoedClapHit,		8500
	pcmdef	DPCM,	EchoedClapHitSK,	dLowerEchoedClapHit,	pcm_LowerEchoedClapHit,		6500
	pcmdef	DPCM,	EchoedClapHitS3,	dEchoedClapHitS3,	pcm_EchoedClapHitS3,		8500
	pcmdef	DPCM,	EchoedClapHitS3,	dLowerEchoedClapHitS3,	pcm_LowerEchoedClapHitS3,	6500
	pcmdef	DPCM,	PowerKickHit,		dHipHopHitKick,		pcm_HipHopHitKick,		12500
	pcmdef	DPCM,	HipHopHitPowerKick,	dHipHopHitPowerKick,	pcm_HipHopHitPowerKick,		12500
	pcmdef	DPCM,	BassHey,		dBassHey,		pcm_BassHey,			12500
	pcmdef	DPCM,	DanceStyleKick,		dDanceStyleKick,	pcm_DanceStyleKick,		8000
	pcmdef	DPCM,	HipHopHitKick,		dHipHopHitKick2,	pcm_HipHopHitKick2,		12500
	pcmdef	DPCM,	HipHopHitKick,		dHipHopHitKick3,	pcm_HipHopHitKick3,		12500
	pcmdef	DPCM,	ReverseFadingWind,	dReverseFadingWind,	pcm_ReverseFadingWind,		8000
	pcmdef	DPCM,	ScratchS3,		dScratchS3,		pcm_ScratchS3,			8000
	pcmdef	DPCM,	LooseSnareNoise,	dLooseSnareNoise,	pcm_LooseSnareNoise,		8000
	pcmdef	DPCM,	PowerKick2,		dPowerKick2,		pcm_PowerKick2,			12500
	pcmdef	DPCM,	CrashingNoiseWoo,	dCrashingNoiseWoo,	pcm_CrashingNoiseWoo,		12500
	pcmdef	DPCM,	QuickHit,		dQuickHit,		pcm_QuickHit,			7250
	pcmdef	DPCM,	KickHey,		dKickHey,		pcm_KickHey,			13000
	pcmdef	DPCM,	PowerKickHit,		dPowerKickHit,		pcm_PowerKickHit,		11000
	pcmdef	DPCM,	PowerKickHit,		dLowPowerKickHit,	pcm_LowPowerKickHit,		10000
	pcmdef	DPCM,	PowerKickHit,		dLowerPowerKickHit,	pcm_LowerPowerKickHit,		9750
	pcmdef	DPCM,	PowerKickHit,		dLowestPowerKickHit,	pcm_LowestPowerKickHit,		13000
; S3D
	pcmdef	DPCM,	FinalFightMetalCrash,	dFinalFightMetalCrash,	pcm_FinalFightMetalCrash,	14000	; TODO: pretty sure it's the wrong HZ rate
	pcmdef	DPCM,	IntroKick,		dIntroKick,		pcm_IntroKick,			9750
; Extra
	pcmdef	PCM,	SegaPCM,		dSegaChant,		pcm_SegaChant,			16000
;	pcmdef	PCM,	Rizzmas,		dRizzmas,		pcm_Rizzmas
; ============= type	expected pcm		sequence id end label	queue id end label
	pcmdef	END,	MegaPCM2,		d__Last,		pcm__Last

; ---------------------------------------------------------------------------
; Sound effect data
; ---------------------------------------------------------------------------
SfxTest:	include "res/sfx/_tester.asm"
		even
SfxFlicky:	include "res/sfx/Flicky Tweet.asm"
		even
SfxFlickyGrab:	include "res/sfx/Flicky Grab Jingle.asm"
		even
SfxSpindash:	include "res/sfx/Spin Dash Rev.asm"
		even
SfxSpikeMove:	include "res/sfx/Spike Move.asm"
		even
SfxSkidPSG:	include "res/sfx/Skid PSG.asm"
		even
SfxSkidFM:	include "res/sfx/Skid FM.asm"
		even

SfxS1A0:	include "res/sfx/sonic1/SndA0 - Jump.asm"
		even
SfxS1A1:	include "res/sfx/sonic1/SndA1 - Lamppost.asm"
		even
SfxS1A2:	include "res/sfx/sonic1/SndA2.asm"
		even
SfxS1A3:	include "res/sfx/sonic1/SndA3 - Death.asm"
		even
SfxS1A4:	include "res/sfx/sonic1/SndA4 - Skid.asm"
		even
SfxS1A5:	include "res/sfx/sonic1/SndA5.asm"
		even
SfxS1A6:	include "res/sfx/sonic1/SndA6 - Hit Spikes.asm"
		even
SfxS1A7:	include "res/sfx/sonic1/SndA7 - Push Block.asm"
		even
SfxS1A8:	include "res/sfx/sonic1/SndA8 - SS Goal.asm"
		even
SfxS1A9:	include "res/sfx/sonic1/SndA9 - SS Item.asm"
		even
SfxS1AA:	include "res/sfx/sonic1/SndAA - Splash.asm"
		even
SfxS1AB:	include "res/sfx/sonic1/SndAB.asm"
		even
SfxS1AC:	include "res/sfx/sonic1/SndAC - Hit Boss.asm"
		even
SfxS1AD:	include "res/sfx/sonic1/SndAD - Get Bubble.asm"
		even
SfxS1AE:	include "res/sfx/sonic1/SndAE - Fireball.asm"
		even
SfxS1AF:	include "res/sfx/sonic1/SndAF - Shield.asm"
		even
SfxS1B0:	include "res/sfx/sonic1/SndB0 - Saw.asm"
		even
SfxS1B1:	include "res/sfx/sonic1/SndB1 - Electric.asm"
		even
SfxS1B2:	include "res/sfx/sonic1/SndB2 - Drown Death.asm"
		even
SfxS1B3:	include "res/sfx/sonic1/SndB3 - Flamethrower.asm"
		even
SfxS1B4:	include "res/sfx/sonic1/SndB4 - Bumper.asm"
		even
SfxS1B5:	include "res/sfx/sonic1/SndB5 - Ring.asm"
		even
SfxS1B6:	include "res/sfx/sonic1/SndB6 - Spikes Move.asm"
		even
SfxS1B7:	include "res/sfx/sonic1/SndB7 - Rumbling.asm"
		even
SfxS1B8:	include "res/sfx/sonic1/SndB8.asm"
		even
SfxS1B9:	include "res/sfx/sonic1/SndB9 - Collapse.asm"
		even
SfxS1BA:	include "res/sfx/sonic1/SndBA - SS Glass.asm"
		even
SfxS1BB:	include "res/sfx/sonic1/SndBB - Door.asm"
		even
SfxS1BC:	include "res/sfx/sonic1/SndBC - Teleport.asm"
		even
SfxS1BD:	include "res/sfx/sonic1/SndBD - ChainStomp.asm"
		even
SfxS1BE:	include "res/sfx/sonic1/SndBE - Roll.asm"
		even
SfxS1BF:	include "res/sfx/sonic1/SndBF - Get Continue.asm"
		even
SfxS1C0:	include "res/sfx/sonic1/SndC0 - Basaran Flap.asm"
		even
SfxS1C1:	include "res/sfx/sonic1/SndC1 - Break Item.asm"
		even
SfxS1C2:	include "res/sfx/sonic1/SndC2 - Drown Warning.asm"
		even
SfxS1C3:	include "res/sfx/sonic1/SndC3 - Giant Ring.asm"
		even
SfxS1C4:	include "res/sfx/sonic1/SndC4 - Bomb.asm"
		even
SfxS1C5:	include "res/sfx/sonic1/SndC5 - Cash Register.asm"
		even
SfxS1C6:	include "res/sfx/sonic1/SndC6 - Ring Loss.asm"
		even
SfxS1C7:	include "res/sfx/sonic1/SndC7 - Chain Rising.asm"
		even
SfxS1C8:	include "res/sfx/sonic1/SndC8 - Burning.asm"
		even
SfxS1C9:	include "res/sfx/sonic1/SndC9 - Hidden Bonus.asm"
		even
SfxS1CA:	include "res/sfx/sonic1/SndCA - Enter SS.asm"
		even
SfxS1CB:	include "res/sfx/sonic1/SndCB - Wall Smash.asm"
		even
SfxS1CC:	include "res/sfx/sonic1/SndCC - Spring.asm"
		even
SfxS1CD:	include "res/sfx/sonic1/SndCD - Switch.asm"
		even
SfxS1CE:	include "res/sfx/sonic1/SndCE - Ring Left Speaker.asm"
		even
SfxS1CF:	include "res/sfx/sonic1/SndCF - Signpost.asm"
		even
BfxS1D0:	include "res/sfx/sonic1/SndD0 - Waterfall.asm"
		even

SfxS2A0:	include "res/sfx/sonic2/A0 - Jump.asm"
		even
SfxS2A1:	include "res/sfx/sonic2/A1 - Checkpoint.asm"
		even
SfxS2A2:	include "res/sfx/sonic2/A2 - Spike Switch.asm"
		even
SfxS2A3:	include "res/sfx/sonic2/A3 - Hurt.asm"
		even
SfxS2A4:	include "res/sfx/sonic2/A4 - Skidding.asm"
		even
SfxS2A5:	include "res/sfx/sonic2/A5 - Block Push.asm"
		even
SfxS2A6:	include "res/sfx/sonic2/A6 - Hurt by Spikes.asm"
		even
SfxS2A7:	include "res/sfx/sonic2/A7 - Sparkle.asm"
		even
SfxS2A8:	include "res/sfx/sonic2/A8 - Beep.asm"
		even
SfxS2A9:	include "res/sfx/sonic2/A9 - Special Stage Item (Unused).asm"
		even
SfxS2AA:	include "res/sfx/sonic2/AA - Splash.asm"
		even
SfxS2AB:	include "res/sfx/sonic2/AB - Swish.asm"
		even
SfxS2B9:	include "res/sfx/sonic2/B9 - Smash.asm"		; shares FM instrument with Boss Hit
		even
SfxS2CB:	include "res/sfx/sonic2/CB - Slow Smash.asm"	; shares FM instrument with Boss Hit
		even
SfxS2AC:	include "res/sfx/sonic2/AC - Boss Hit.asm"
		even
SfxS2AD:	include "res/sfx/sonic2/AD - Inhaling Bubble.asm"
		even
SfxS2B3:	include "res/sfx/sonic2/B3 - Fire Burn.asm"		; shares FM instrument with Lava Ball
		even
SfxS2AE:	include "res/sfx/sonic2/AE - Lava Ball.asm"
		even
SfxS2AF:	include "res/sfx/sonic2/AF - Shield.asm"
		even
SfxS2B0:	include "res/sfx/sonic2/B0 - Laser Beam.asm"
		even
SfxS2B1:	include "res/sfx/sonic2/B1 - Electricity (Unused).asm"
		even
SfxS2B2:	include "res/sfx/sonic2/B2 - Drown.asm"
		even
SfxS2B4:	include "res/sfx/sonic2/B4 - Bumper.asm"
		even
SfxS2C6:	include "res/sfx/sonic2/C6 - Ring Spill.asm"	; shares FM instrument with Ring
		even
SfxS2CE:	include "res/sfx/sonic2/CE - Ring Left Speaker.asm"	; shares FM instrument with Ring
		even
SfxS2B5:	include "res/sfx/sonic2/B5 - Ring.asm"
		even
SfxS2B6:	include "res/sfx/sonic2/B6 - Spikes Move.asm"
		even
SfxS2B7:	include "res/sfx/sonic2/B7 - Rumbling.asm"
		even
SfxS2B8:	include "res/sfx/sonic2/B8 - Unknown (Unused).asm"
		even
SfxS2BA:	include "res/sfx/sonic2/BA - Special Stage Glass (Unused).asm"
		even
SfxS2BB:	include "res/sfx/sonic2/BB - Door Slam.asm"
		even
SfxS2BC:	include "res/sfx/sonic2/BC - Spin Dash Release.asm"
		even
SfxS2BD:	include "res/sfx/sonic2/BD - Hammer.asm"
		even
SfxS2BE:	include "res/sfx/sonic2/BE - Roll.asm"
		even
SfxS2C0:	include "res/sfx/sonic2/C0 - Casino Bonus.asm"	; shares FM instrument with Continue jingle
		even
SfxS2C2:	include "res/sfx/sonic2/C2 - Water Warning.asm"	; shares FM instrument with Continue jingle
		even
SfxS2BF:	include "res/sfx/sonic2/BF - Continue Jingle.asm"
		even
SfxS2C1:	include "res/sfx/sonic2/C1 - Explosion.asm"
		even
SfxS2C3:	include "res/sfx/sonic2/C3 - Enter Giant Ring (Unused).asm"
		even
SfxS2C4:	include "res/sfx/sonic2/C4 - Boss Explosion.asm"
		even
SfxS2C5:	include "res/sfx/sonic2/C5 - Tally End.asm"
		even
SfxS2C7:	include "res/sfx/sonic2/C7 - Chain Rise (Unused).asm"
		even
SfxS2C8:	include "res/sfx/sonic2/C8 - Flamethrower.asm"
		even
SfxS2C9:	include "res/sfx/sonic2/C9 - Hidden Bonus (Unused).asm"
		even
SfxS2CA:	include "res/sfx/sonic2/CA - Special Stage Entry.asm"
		even
SfxS2CC:	include "res/sfx/sonic2/CC - Spring.asm"
		even
SfxS2CD:	include "res/sfx/sonic2/CD - Switch.asm"
		even
SfxS2CF:	include "res/sfx/sonic2/CF - Signpost.asm"
		even
SfxS2D0:	include "res/sfx/sonic2/D0 - CNZ Boss Zap.asm"
		even
SfxS2D1:	include "res/sfx/sonic2/D1 - Unknown (Unused).asm"
		even
SfxS2D2:	include "res/sfx/sonic2/D2 - Unknown (Unused).asm"
		even
SfxS2D3:	include "res/sfx/sonic2/D3 - Signpost 2P.asm"
		even
SfxS2D4:	include "res/sfx/sonic2/D4 - OOZ Lid Pop.asm"
		even
SfxS2D5:	include "res/sfx/sonic2/D5 - Sliding Spike.asm"
		even
SfxS2D6:	include "res/sfx/sonic2/D6 - CNZ Elevator.asm"
		even
SfxS2D7:	include "res/sfx/sonic2/D7 - Platform Knock.asm"
		even
SfxS2D8:	include "res/sfx/sonic2/D8 - Bonus Bumper.asm"
		even
SfxS2D9:	include "res/sfx/sonic2/D9 - Large Bumper.asm"
		even
SfxS2DA:	include "res/sfx/sonic2/DA - Gloop.asm"
		even
SfxS2DB:	include "res/sfx/sonic2/DB - Pre-Arrow Firing.asm"
		even
SfxS2DC:	include "res/sfx/sonic2/DC - Fire.asm"
		even
SfxS2DD:	include "res/sfx/sonic2/DD - Arrow Stick.asm"
		even
SfxS2DE:	include "res/sfx/sonic2/DE - Helicopter.asm"
		even
SfxS2EC:	include "res/sfx/sonic2/EC - Teleport.asm"		; shares PSG sequences with super transform
		even
SfxS2DF:	include "res/sfx/sonic2/DF - Super Transform.asm"
		even
SfxS2E0:	include "res/sfx/sonic2/E0 - Spin Dash Rev.asm"
		even
SfxS2E1:	include "res/sfx/sonic2/E1 - Rumbling 2.asm"
		even
SfxS2E2:	include "res/sfx/sonic2/E2 - CNZ Launch.asm"
		even
SfxS2E3:	include "res/sfx/sonic2/E3 - Flipper.asm"
		even
SfxS2E4:	include "res/sfx/sonic2/E4 - HTZ Lift Click.asm"
		even
SfxS2E5:	include "res/sfx/sonic2/E5 - Leaves.asm"
		even
SfxS2E6:	include "res/sfx/sonic2/E6 - Mega Mack Drop.asm"
		even
SfxS2E7:	include "res/sfx/sonic2/E7 - Drawbridge Move.asm"
		even
SfxS2E8:	include "res/sfx/sonic2/E8 - Quick Door Slam.asm"
		even
SfxS2E9:	include "res/sfx/sonic2/E9 - Drawbridge Down.asm"
		even
SfxS2EF:	include "res/sfx/sonic2/EF - Large Laser.asm"	; shares FM instrument with Laser Burst
		even
SfxS2EA:	include "res/sfx/sonic2/EA - Laser Burst.asm"
		even
SfxS2EB:	include "res/sfx/sonic2/EB - Scatter.asm"
		even
SfxS2ED:	include "res/sfx/sonic2/ED - Error.asm"
		even
SfxS2EE:	include "res/sfx/sonic2/EE - Mecha Sonic Buzz.asm"
		even
SfxS2F0:	include "res/sfx/sonic2/F0 - Oil Slide.asm"
		even

SfxS2BD0:	include "res/sfx/sonic2-wai/D0 - CNZ Boss Zap.asm"
		even
SfxS2BD1:	include "res/sfx/sonic2-wai/D1 - Unknown (Unused).asm"
		even
SfxS2BD2:	include "res/sfx/sonic2-wai/D2 - Unknown (Unused).asm"
		even
SfxS2BD3:	include "res/sfx/sonic2-wai/D3 - Signpost 2P.asm"
		even
SfxS2BD4:	include "res/sfx/sonic2-wai/D4 - OOZ Lid Pop.asm"
		even
SfxS2BD5:	include "res/sfx/sonic2-wai/D5 - Sliding Spike.asm"
		even
SfxS2BD6:	include "res/sfx/sonic2-wai/D6 - CNZ Elevator.asm"
		even
SfxS2BD7:	include "res/sfx/sonic2-wai/D7 - Platform Knock.asm"
		even
SfxS2BD8:	include "res/sfx/sonic2-wai/D8 - Bonus Bumper.asm"
		even
SfxS2BD9:	include "res/sfx/sonic2-wai/D9 - Large Bumper.asm"
		even
SfxS2BDA:	include "res/sfx/sonic2-wai/DA - Gloop.asm"
		even
SfxS2BDB:	include "res/sfx/sonic2-wai/DB - Pre-Arrow Firing.asm"
		even
SfxS2BDC:	include "res/sfx/sonic2-wai/DC - Fire.asm"
		even
SfxS2BDD:	include "res/sfx/sonic2-wai/DD - Arrow Stick.asm"
		even
SfxS2BDE:	include "res/sfx/sonic2-wai/DE - Helicopter.asm"
		even
SfxS2BDF:	include "res/sfx/sonic2-wai/DF - Super Transform.asm"
		even
SfxS2BE0:	include "res/sfx/sonic2-wai/E0 - Spin Dash Rev.asm"
		even

SfxCdSKID:	include "res/sfx/soniccd/90 - Skid.asm"
		even
SfxCd91:	include "res/sfx/soniccd/91.asm"
		even
SfxCdJUMP:	include "res/sfx/soniccd/92 - Jump.asm"
		even
SfxCdHURT:	include "res/sfx/soniccd/93 - Hurt.asm"
		even
SfxCdRINGLOSS:	include "res/sfx/soniccd/94 - Ring Loss.asm"
		even
SfxCdRING:	include "res/sfx/soniccd/95 - Ring Right.asm"
		even
SfxCdDESTROY:	include "res/sfx/soniccd/96 - Destroy.asm"
		even
SfxCdSHIELD:	include "res/sfx/soniccd/97 - Shield.asm"
		even
SfxCdSPRING:	include "res/sfx/soniccd/98 - Spring.asm"
		even
SfxCd99:	include "res/sfx/soniccd/99.asm"
		even
SfxCdKACHING:	include "res/sfx/soniccd/9A - Kaching.asm"
		even
SfxCd9B:	include "res/sfx/soniccd/9B.asm"
		even
SfxCd9C:	include "res/sfx/soniccd/9C.asm"
		even
SfxCdSIGNPOST:	include "res/sfx/soniccd/9D - Signpost.asm"
		even
SfxCdEXPLODE:	include "res/sfx/soniccd/9E - Explode.asm"
		even
SfxCd9F:	include "res/sfx/soniccd/9F.asm"
		even
SfxCdA0:	include "res/sfx/soniccd/A0.asm"
		even
SfxCdA1:	include "res/sfx/soniccd/A1.asm"
		even
SfxCdA2:	include "res/sfx/soniccd/A2.asm"
		even
SfxCdA3:	include "res/sfx/soniccd/A3.asm"
		even
SfxCdA4:	include "res/sfx/soniccd/A4.asm"
		even
SfxCdA5:	include "res/sfx/soniccd/A5.asm"
		even
SfxCdA6:	include "res/sfx/soniccd/A6.asm"
		even
SfxCdA7:	include "res/sfx/soniccd/A7.asm"
		even
SfxCdRINGL:	include "res/sfx/soniccd/A8 - Ring Left.asm"
		even
SfxCdA9:	include "res/sfx/soniccd/A9 - Null.asm"
		even
SfxCdCHARGESTOP:include "res/sfx/soniccd/AB - Charge Stop.asm"	; shares patch with AA
		even
SfxCdAA:	include "res/sfx/soniccd/AA.asm"
		even
SfxCdAC:	include "res/sfx/soniccd/AC.asm"
		even
SfxCdAD:	include "res/sfx/soniccd/AD.asm"
		even
SfxCdCHECKPOINT:include "res/sfx/soniccd/AE - Checkpoint.asm"
		even
SfxCdBIGRING:	include "res/sfx/soniccd/AF - Big Ring.asm"
		even
SfxCdB0:	include "res/sfx/soniccd/B0.asm"
		even
SfxCdB1:	include "res/sfx/soniccd/B1.asm"
		even
SfxCdB2:	include "res/sfx/soniccd/B2.asm"
		even
SfxCdB3:	include "res/sfx/soniccd/B3.asm"
		even
SfxCdB4:	include "res/sfx/soniccd/B4.asm"
		even
SfxCdB5:	include "res/sfx/soniccd/B5.asm"
		even
SfxCdB6:	include "res/sfx/soniccd/B6.asm"
		even
SfxCdB7:	include "res/sfx/soniccd/B7.asm"
		even
SfxCdB8:	include "res/sfx/soniccd/B8.asm"
		even
SfxCdB9:	include "res/sfx/soniccd/B9.asm"
		even
SfxCdBA:	include "res/sfx/soniccd/BA.asm"
		even
SfxCdBB:	include "res/sfx/soniccd/BB.asm"
		even
SfxCdBC:	include "res/sfx/soniccd/BC.asm"
		even
SfxCdTALLY:	include "res/sfx/soniccd/BD - Tally.asm"
		even
SfxCdBE:	include "res/sfx/soniccd/BE.asm"
		even
SfxCdBF:	include "res/sfx/soniccd/BF.asm"
		even
SfxCdC0:	include "res/sfx/soniccd/C0.asm"
		even
SfxCdC1:	include "res/sfx/soniccd/C1.asm"
		even
SfxCdC2:	include "res/sfx/soniccd/C2.asm"
		even
SfxCdC3:	include "res/sfx/soniccd/C3.asm"
		even
SfxCdC4:	include "res/sfx/soniccd/C4.asm"
		even
SfxCdC5:	include "res/sfx/soniccd/C5.asm"
		even
SfxCdC6:	include "res/sfx/soniccd/C6.asm"
		even
SfxCdC7:	include "res/sfx/soniccd/C7.asm"
		even
SfxCdSSWARP:	include "res/sfx/soniccd/C8 - SS Warp.asm"
		even
SfxCdC9:	include "res/sfx/soniccd/C9.asm"
		even
SfxCdCA:	include "res/sfx/soniccd/CA.asm"
		even
SfxCdCB:	include "res/sfx/soniccd/CB.asm"
		even
SfxCdCC:	include "res/sfx/soniccd/CC.asm"
		even
SfxCdCD:	include "res/sfx/soniccd/CD.asm"
		even
SfxCdCE:	include "res/sfx/soniccd/CE.asm"
		even
SfxCdCF:	include "res/sfx/soniccd/CF.asm"
		even
SfxCdD0:	include "res/sfx/soniccd/D0.asm"
		even
SfxCdD1:	include "res/sfx/soniccd/D1.asm"
		even
SfxCdD2:	include "res/sfx/soniccd/D2.asm"
		even
SfxCdD3:	include "res/sfx/soniccd/D3.asm"
		even
SfxCdD4:	include "res/sfx/soniccd/D4.asm"
		even
SfxCdD5:	include "res/sfx/soniccd/D5.asm"
		even
SfxCdD6:	include "res/sfx/soniccd/D6.asm"
		even
SfxCdD7:	include "res/sfx/soniccd/D7.asm"
		even
SfxCdD9:	include "res/sfx/soniccd/D9.asm"
		even
SfxCdDA:	include "res/sfx/soniccd/DA.asm"
		even
SfxCdDB:	include "res/sfx/soniccd/DB.asm"
		even
SfxCdDC:	include "res/sfx/soniccd/DC.asm"
		even
SfxCdDD:	include "res/sfx/soniccd/DD.asm"
		even
SfxCdDE:	include "res/sfx/soniccd/DE.asm"
		even
SfxCdDF:	include "res/sfx/soniccd/DF.asm"
		even

SfxS3B9:	include "res/sfx/sonic3/B9.asm"	; shares patch with 33
		even
SfxS334:	include "res/sfx/sonic3/34.asm"	; shares patch with 33
		even
SfxS333:	include "res/sfx/sonic3/33.asm"
		even
SfxS335:	include "res/sfx/sonic3/35.asm"
		even
SfxS336:	include "res/sfx/sonic3/36.asm"
		even
SfxS337:	include "res/sfx/sonic3/37.asm"
		even
SfxS338:	include "res/sfx/sonic3/38.asm"
		even
SfxS357:	include "res/sfx/sonic3/57.asm"	; shares patch with 39
		even
SfxS36C:	include "res/sfx/sonic3/6C.asm"	; shares patch with 39
		even
SfxS339:	include "res/sfx/sonic3/39.asm"
		even
SfxS371:	include "res/sfx/sonic3/71.asm"	; shares patch with 3A
		even
SfxS33A:	include "res/sfx/sonic3/3A.asm"
		even
SfxS33B:	include "res/sfx/sonic3/3B.asm"
		even
SfxS33C:	include "res/sfx/sonic3/3C.asm"
		even
SfxS33D:	include "res/sfx/sonic3/3D.asm"
		even
SfxS33F:	include "res/sfx/sonic3/3F.asm"	; shares patch with 3E
		even
SfxS340:	include "res/sfx/sonic3/40.asm"	; shares patch with 3E
		even
SfxS341:	include "res/sfx/sonic3/41.asm"	; shares patch with 3E
		even
SfxS33E:	include "res/sfx/sonic3/3E.asm"
		even
SfxS342:	include "res/sfx/sonic3/42.asm"
		even
SfxS343:	include "res/sfx/sonic3/43.asm"
		even
SfxS344:	include "res/sfx/sonic3/44.asm"
		even
SfxS345:	include "res/sfx/sonic3/45.asm"
		even
SfxS346:	include "res/sfx/sonic3/46.asm"
		even
SfxS347:	include "res/sfx/sonic3/47.asm"
		even
SfxS348:	include "res/sfx/sonic3/48.asm"
		even
SfxS349:	include "res/sfx/sonic3/49.asm"
		even
SfxS34A:	include "res/sfx/sonic3/4A.asm"
		even
SfxS34B:	include "res/sfx/sonic3/4B.asm"
		even
SfxS356:	include "res/sfx/sonic3/56.asm"	; shares patch with 4C
		even
SfxS34C:	include "res/sfx/sonic3/4C.asm"
		even
SfxS34D:	include "res/sfx/sonic3/4D.asm"
		even
SfxS34E:	include "res/sfx/sonic3/4E.asm"
		even
SfxS34F:	include "res/sfx/sonic3/4F.asm"
		even
SfxS350:	include "res/sfx/sonic3/50.asm"
		even
SfxS351:	include "res/sfx/sonic3/51.asm"
		even
SfxS352:	include "res/sfx/sonic3/52.asm"
		even
SfxS353:	include "res/sfx/sonic3/53.asm"
		even
SfxS354:	include "res/sfx/sonic3/54.asm"
		even
SfxS355:	include "res/sfx/sonic3/55.asm"
		even
SfxS358:	include "res/sfx/sonic3/58.asm"
		even
SfxS359:	include "res/sfx/sonic3/59.asm"
		even
SfxS35A:	include "res/sfx/sonic3/5A.asm"
		even
SfxS35B:	include "res/sfx/sonic3/5B.asm"
		even
SfxS35C:	include "res/sfx/sonic3/5C.asm"
		even
SfxS35D:	include "res/sfx/sonic3/5D.asm"
		even
SfxS35E:	include "res/sfx/sonic3/5E.asm"
		even
SfxS35F:	include "res/sfx/sonic3/5F.asm"
		even
SfxS360:	include "res/sfx/sonic3/60.asm"
		even
SfxS361:	include "res/sfx/sonic3/61.asm"
		even
SfxS362:	include "res/sfx/sonic3/62.asm"
		even
SfxS363:	include "res/sfx/sonic3/63.asm"
		even
SfxS364:	include "res/sfx/sonic3/64.asm"
		even
SfxS365:	include "res/sfx/sonic3/65.asm"
		even
SfxS366:	include "res/sfx/sonic3/66.asm"
		even
SfxS367:	include "res/sfx/sonic3/67.asm"
		even
SfxS368:	include "res/sfx/sonic3/68.asm"
		even
SfxS369:	include "res/sfx/sonic3/69.asm"
		even
SfxS36A:	include "res/sfx/sonic3/6A.asm"
		even
SfxS36B:	include "res/sfx/sonic3/6B.asm"
		even
SfxS36D:	include "res/sfx/sonic3/6D.asm"
		even
SfxS36E:	include "res/sfx/sonic3/6E.asm"
		even
SfxS36F:	include "res/sfx/sonic3/6F.asm"	; shares sequence with CB
		even
CsfxS3CB:	include "res/sfx/sonic3/CB.asm"
		even
SfxS370:	include "res/sfx/sonic3/70.asm"
		even
SfxS372:	include "res/sfx/sonic3/72.asm"
		even
SfxS373:	include "res/sfx/sonic3/73.asm"
		even
SfxS374:	include "res/sfx/sonic3/74.asm"
		even
SfxS375:	include "res/sfx/sonic3/75.asm"
		even
SfxS376:	include "res/sfx/sonic3/76.asm"
		even
SfxS377:	include "res/sfx/sonic3/77.asm"
		even
SfxS378:	include "res/sfx/sonic3/78.asm"
		even
SfxS379:	include "res/sfx/sonic3/79.asm"
		even
SfxS37A:	include "res/sfx/sonic3/7A.asm"
		even
SfxS37B:	include "res/sfx/sonic3/7B.asm"
		even
SfxS37C:	include "res/sfx/sonic3/7C.asm"
		even
SfxS37D:	include "res/sfx/sonic3/7D.asm"
		even
SfxS37E:	include "res/sfx/sonic3/7E.asm"
		even
SfxS37F:	include "res/sfx/sonic3/7F.asm"
		even
SfxS380:	include "res/sfx/sonic3/80.asm"
		even
SfxS381:	include "res/sfx/sonic3/81.asm"
		even
SfxS382:	include "res/sfx/sonic3/82.asm"
		even
SfxS383:	include "res/sfx/sonic3/83.asm"
		even
SfxS384:	include "res/sfx/sonic3/84.asm"
		even
SfxS385:	include "res/sfx/sonic3/85.asm"
		even
SfxS386:	include "res/sfx/sonic3/86.asm"
		even
SfxS387:	include "res/sfx/sonic3/87.asm"
		even
SfxS388:	include "res/sfx/sonic3/88.asm"
		even
SfxS389:	include "res/sfx/sonic3/89.asm"
		even
SfxS38A:	include "res/sfx/sonic3/8A.asm"
		even
SfxS38B:	include "res/sfx/sonic3/8B.asm"
		even
SfxS38C:	include "res/sfx/sonic3/8C.asm"
		even
SfxS38D:	include "res/sfx/sonic3/8D.asm"
		even
SfxS38E:	include "res/sfx/sonic3/8E.asm"
		even
SfxS38F:	include "res/sfx/sonic3/8F.asm"
		even
SfxS390:	include "res/sfx/sonic3/90.asm"
		even
SfxS391:	include "res/sfx/sonic3/91.asm"
		even
SfxS392:	include "res/sfx/sonic3/92.asm"
		even
SfxS393:	include "res/sfx/sonic3/93.asm"
		even
SfxS394:	include "res/sfx/sonic3/94.asm"
		even
SfxS395:	include "res/sfx/sonic3/95.asm"
		even
SfxS396:	include "res/sfx/sonic3/96.asm"
		even
SfxS397:	include "res/sfx/sonic3/97.asm"
		even
SfxS398:	include "res/sfx/sonic3/98.asm"
		even
SfxS399:	include "res/sfx/sonic3/99.asm"
		even
SfxS39A:	include "res/sfx/sonic3/9A.asm"
		even
SfxS39B:	include "res/sfx/sonic3/9B (Sonic 3).asm"
		even
SfxSK9B:	include "res/sfx/sonic3/9B (Sonic & Knuckles).asm"
		even
SfxS39C:	include "res/sfx/sonic3/9C.asm"
		even
SfxS39D:	include "res/sfx/sonic3/9D.asm"
		even
SfxS39E:	include "res/sfx/sonic3/9E.asm"
		even
SfxS39F:	include "res/sfx/sonic3/9F.asm"
		even
SfxS3A0:	include "res/sfx/sonic3/A0.asm"
		even
SfxS3A1:	include "res/sfx/sonic3/A1.asm"
		even
SfxS3A2:	include "res/sfx/sonic3/A2.asm"
		even
SfxS3A3:	include "res/sfx/sonic3/A3.asm"
		even
SfxS3A4:	include "res/sfx/sonic3/A4.asm"
		even
SfxS3A5:	include "res/sfx/sonic3/A5.asm"
		even
SfxS3A6:	include "res/sfx/sonic3/A6.asm"
		even
SfxS3AD:	include "res/sfx/sonic3/AD (Sonic & Knuckles).asm"	; shares patch with A7
		even
SfxS3A7:	include "res/sfx/sonic3/A7.asm"
		even
SfxS3A8:	include "res/sfx/sonic3/A8.asm"
		even
SfxS3A9:	include "res/sfx/sonic3/A9.asm"
		even
SfxS3AA:	include "res/sfx/sonic3/AA.asm"
		even
SfxS3AB:	include "res/sfx/sonic3/AB.asm"
		even
SfxS3AC:	include "res/sfx/sonic3/AC.asm"
		even
SfxS3AE:	include "res/sfx/sonic3/AE.asm"
		even
SfxS3AF:	include "res/sfx/sonic3/AF.asm"
		even
SfxS3B0:	include "res/sfx/sonic3/B0.asm"
		even
SfxS3B1:	include "res/sfx/sonic3/B1.asm"
		even
SfxS3B2:	include "res/sfx/sonic3/B2.asm"
		even
SfxS3B3:	include "res/sfx/sonic3/B3.asm"
		even
SfxS3B4:	include "res/sfx/sonic3/B4.asm"
		even
SfxS3B5:	include "res/sfx/sonic3/B5.asm"
		even
SfxS3B6:	include "res/sfx/sonic3/B6.asm"
		even
SfxS3B7:	include "res/sfx/sonic3/B7.asm"
		even
SfxS3B8:	include "res/sfx/sonic3/B8.asm"
		even
SfxS3BB:	include "res/sfx/sonic3/BB.asm"	; shares patch with BA
		even
SfxS3BA:	include "res/sfx/sonic3/BA.asm"
		even

CsfxS3C8:	include "res/sfx/sonic3/C8.asm"	; shares patch with BC
		even
CsfxS3BC:	include "res/sfx/sonic3/BC.asm"
		even
CsfxS3BD:	include "res/sfx/sonic3/BD.asm"
		even
CsfxS3BE:	include "res/sfx/sonic3/BE.asm"
		even
CsfxS3BF:	include "res/sfx/sonic3/BF.asm"
		even
CsfxS3C0:	include "res/sfx/sonic3/C0.asm"
		even
CsfxS3C1:	include "res/sfx/sonic3/C1.asm"
		even
CsfxS3C2:	include "res/sfx/sonic3/C2.asm"
		even
CsfxS3C3:	include "res/sfx/sonic3/C3.asm"
		even
CsfxS3C4:	include "res/sfx/sonic3/C4.asm"
		even
CsfxS3C5:	include "res/sfx/sonic3/C5.asm"
		even
CsfxS3C6:	include "res/sfx/sonic3/C6.asm"
		even
CsfxS3C7:	include "res/sfx/sonic3/C7.asm"
		even
CsfxS3C9:	include "res/sfx/sonic3/C9.asm"
		even
CsfxS3CA:	include "res/sfx/sonic3/CA.asm"
		even
CsfxS3CC:	include "res/sfx/sonic3/CC.asm"
		even
CsfxS3CD:	include "res/sfx/sonic3/CD.asm"
		even
CsfxS3CF:	include "res/sfx/sonic3/CF.asm"	; shares patch with CE
		even
CsfxS3CE:	include "res/sfx/sonic3/CE.asm"
		even
CsfxS3D0:	include "res/sfx/sonic3/D0.asm"
		even
CsfxS3D1:	include "res/sfx/sonic3/D1.asm"
		even
CsfxS3D2:	include "res/sfx/sonic3/D2.asm"
		even
CsfxS3D3:	include "res/sfx/sonic3/D3.asm"
		even
CsfxS3D4:	include "res/sfx/sonic3/D4.asm"
		even
CsfxS3D5:	include "res/sfx/sonic3/D5.asm"
		even
CsfxS3D6:	include "res/sfx/sonic3/D6.asm"
		even
CsfxS3D7:	include "res/sfx/sonic3/D7.asm"
		even
CsfxS3D8:	include "res/sfx/sonic3/D8.asm"
		even
CsfxS3D9:	include "res/sfx/sonic3/D9.asm"
		even
CsfxS3DA:	include "res/sfx/sonic3/DA.asm"
		even
CsfxS3DB:	include "res/sfx/sonic3/DB.asm"
		even

; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------
BgmTest:	include "res/bgm/_tester.asm"
		even
BgmSoccer:	include "res/bgm/MDSoccer-Title.asm"
		even
BgmSCDTimeTravel:	include "res/bgm/CD Time Travel.asm"
		even

BgmS1Title:	include "res/bgm/sonic1/S1-Title.asm"
		even
BgmS1GHZ:	include "res/bgm/sonic1/S1-GHZ.asm"
		even
BgmS1LZ:	include "res/bgm/sonic1/S1-LZ.asm"
		even
BgmS1MZ:	include "res/bgm/sonic1/S1-MZ.asm"
		even
BgmS1SLZ:	include "res/bgm/sonic1/S1-SLZ.asm"
		even
BgmS1SYZ:	include "res/bgm/sonic1/S1-SYZ.asm"
		even
BgmS1SBZ:	include "res/bgm/sonic1/S1-SBZ.asm"
		even
BgmS1FZ:	include "res/bgm/sonic1/S1-FZ.asm"
		even
BgmS1Boss:	include "res/bgm/sonic1/S1-Boss.asm"
		even
BgmS1Special:	include "res/bgm/sonic1/S1-SpecialStage.asm"
		even
BgmS1Invinc:	include "res/bgm/sonic1/S1-Invincibility.asm"
		even
BgmS1ActClear:	include "res/bgm/sonic1/S1-ActClear.asm"
		even
BgmS1ExtraLife:	include "res/bgm/sonic1/S1-ExtraLife.asm"
		even
BgmS1Continue:	include "res/bgm/sonic1/S1-Continue.asm"
		even
BgmS1Emerald:	include "res/bgm/sonic1/S1-Emerald.asm"
		even
BgmS1Drowning:	include "res/bgm/sonic1/S1-Drowning.asm"
		even
BgmS1GameOver:	include "res/bgm/sonic1/S1-GameOver.asm"
		even
BgmS1Ending:	include "res/bgm/sonic1/S1-Ending.asm"
		even
BgmS1Credits:	include "res/bgm/sonic1/S1-Credits.asm"
		even

BgmS2Title:	include "res/bgm/sonic2/S2-Title.asm"
		even
BgmS2EHZ:	include "res/bgm/sonic2/S2-EHZ.asm"
		even
BgmS2EHZ2P:	include "res/bgm/sonic2/S2-EHZ2P.asm"
		even
BgmS2CPZ:	include "res/bgm/sonic2/S2-CPZ.asm"
		even
BgmS2ARZ:	include "res/bgm/sonic2/S2-ARZ.asm"
		even
BgmS2CNZ:	include "res/bgm/sonic2/S2-CNZ.asm"
		even
BgmS2CNZ2P:	include "res/bgm/sonic2/S2-CNZ2P.asm"
		even
BgmS2HTZ:	include "res/bgm/sonic2/S2-HTZ.asm"
		even
BgmS2MCZ:	include "res/bgm/sonic2/S2-MCZ.asm"
		even
BgmS2MCZ2P:	include "res/bgm/sonic2/S2-MCZ2P.asm"
		even
BgmS2OOZ:	include "res/bgm/sonic2/S2-OOZ.asm"
		even
BgmS2MTZ:	include "res/bgm/sonic2/S2-MTZ.asm"
		even
BgmS2SCZ:	include "res/bgm/sonic2/S2-SCZ.asm"
		even
BgmS2WFZ:	include "res/bgm/sonic2/S2-WFZ.asm"
		even
BgmS2DEZ:	include "res/bgm/sonic2/S2-DEZ.asm"
		even
BgmS2HPZ:	include "res/bgm/sonic2/S2-HPZ.asm"
		even
BgmS2Special:	include "res/bgm/sonic2/S2-SpecialStage.asm"
		even
BgmS2Boss:	include "res/bgm/sonic2/S2-Boss.asm"
		even
BgmS2FinalBoss:	include "res/bgm/sonic2/S2-FinalBoss.asm"
		even
BgmS2ActClear:	include "res/bgm/sonic2/S2-ActClear.asm"
		even
BgmS2Invinc:	include "res/bgm/sonic2/S2-Invincibility.asm"
		even
BgmS2Super:	include "res/bgm/sonic2/S2-SuperSonic.asm"
		even
BgmS2ExtraLife:	include "res/bgm/sonic2/S2-ExtraLife.asm"
		even
BgmS2GameOver:	include "res/bgm/sonic2/S2-GameOver.asm"
		even
BgmS2Options:	include "res/bgm/sonic2/S2-Options.asm"
		even
BgmS2Menu2P:	include "res/bgm/sonic2/S2-2PMenu.asm"
		even
BgmS2Ending:	include "res/bgm/sonic2/S2-Ending.asm"
		even
BgmS2Credits:	include "res/bgm/sonic2/S2-Credits.asm"
		even

BgmS2BTitle:	include "res/bgm/sonic2-wai/Title screen.asm"
		even
BgmS2BGHZ:	include "res/bgm/sonic2-wai/GHZ.asm"
		even
BgmS2BCPZ:	include "res/bgm/sonic2-wai/CPZ.asm"
		even
BgmS2BNGHZ:	include "res/bgm/sonic2-wai/NGHZ.asm"
		even
BgmS2BCNZ:	include "res/bgm/sonic2-wai/CNZ.asm"
		even
BgmS2BHTZ:	include "res/bgm/sonic2-wai/HTZ.asm"
		even
BgmS2BDHZ:	include "res/bgm/sonic2-wai/DHZ.asm"
		even
BgmS2BOOZ:	include "res/bgm/sonic2-wai/OOZ.asm"
		even
BgmS2BMTZ:	include "res/bgm/sonic2-wai/MTZ.asm"
		even
BgmS2BSSZ:	include "res/bgm/sonic2-wai/SSZ.asm"
		even
BgmS2BRWZ:	include "res/bgm/sonic2-wai/RWZ.asm"
		even
BgmS2BDEZ:	include "res/bgm/sonic2-wai/DEZ.asm"
		even
BgmS2BBOZ:	include "res/bgm/sonic2-wai/BOZ.asm"
		even
BgmS2BHPZ:	include "res/bgm/sonic2-wai/HPZ.asm"
		even
BgmS2BLevelSelect:	include "res/bgm/sonic2-wai/Level select.asm"
		even
BgmS2BSpecial:	include "res/bgm/sonic2-wai/Special Stage.asm"
		even
BgmS2BBoss:	include "res/bgm/sonic2-wai/Boss.asm"
		even
BgmS2BFinalBoss:	include "res/bgm/sonic2-wai/Final boss.asm"
		even
BgmS2BWFZ:	include "res/bgm/sonic2-wai/Unused 1.asm"
		even
BgmS2BMenu2P:	include "res/bgm/sonic2-wai/Unused 2.asm"
		even

BgmS3Complete:	include "res/bgm/sonic3/Game Complete (Sonic 3).asm"	; shares sequence data with s3title
		even
BgmSKComplete:	include "res/bgm/sonic3/Game Complete (Sonic & Knuckles).asm"
		even
BgmS3Title:	include "res/bgm/sonic3/Title (Sonic 3).asm"
		even
BgmSKitle:	include "res/bgm/sonic3/Title (Sonic & Knuckles).asm"
		even
BgmS3AIZ1:	include "res/bgm/sonic3/AIZ1.asm"
		even
BgmS3AIZ2:	include "res/bgm/sonic3/AIZ2.asm"
		even
BgmS3HCZ1:	include "res/bgm/sonic3/HCZ1.asm"
		even
BgmS3HCZ2:	include "res/bgm/sonic3/HCZ2.asm"
		even
BgmS3MGZ1:	include "res/bgm/sonic3/MGZ1.asm"
		even
BgmS3MZZ2:	include "res/bgm/sonic3/MGZ2.asm"
		even
BgmS3CNZ1:	include "res/bgm/sonic3/CNZ1.asm"
		even
BgmS3CNZ2:	include "res/bgm/sonic3/CNZ2.asm"
		even
BgmS3ICZ2:	include "res/bgm/sonic3/ICZ2.asm"	; shares FM instruments with ICZ1
		even
BgmS3ICZ1:	include "res/bgm/sonic3/ICZ1.asm"
		even
BgmS3LBZ1:	include "res/bgm/sonic3/LBZ1.asm"
		even
BgmS3LBZ2:	include "res/bgm/sonic3/LBZ2.asm"
		even
BgmSKMHZ1:	include "res/bgm/sonic3/MHZ1.asm"
		even
BgmSKMHZ2:	include "res/bgm/sonic3/MHZ2.asm"
		even
BgmSKFBZ1:	include "res/bgm/sonic3/FBZ1 (Sonic & Knuckles).asm"
		even
BgmSKFBZ2:	include "res/bgm/sonic3/FBZ2.asm"
		even
BgmSKSOZ1:	include "res/bgm/sonic3/SOZ1.asm"
		even
BgmSKSOZ2:	include "res/bgm/sonic3/SOZ2.asm"
		even
BgmSKLRZ1:	include "res/bgm/sonic3/LRZ1.asm"
		even
BgmSKLRZ2:	include "res/bgm/sonic3/LRZ2.asm"
		even
BgmSKSSZ:	include "res/bgm/sonic3/SSZ (Sonic & Knuckles).asm"
		even
BgmSKDEZ1:	include "res/bgm/sonic3/DEZ1.asm"
		even
BgmSKDEZ2:	include "res/bgm/sonic3/DEZ2.asm"
		even
BgmSKDDZ:	include "res/bgm/sonic3/DDZ.asm"
		even
BgmS3Gumball:	include "res/bgm/sonic3/Gum Ball Machine.asm"
		even
BgmSKPachinko:	include "res/bgm/sonic3/Pachinko.asm"
		even
BgmSKSlots:	include "res/bgm/sonic3/Slots.asm"
		even
BgmS3Special:	include "res/bgm/sonic3/Special Stage.asm"
		even
BgmS3MiniBoss:	include "res/bgm/sonic3/Miniboss (Sonic 3).asm"
		even
BgmSKMiniBoss:	include "res/bgm/sonic3/Miniboss (Sonic & Knuckles).asm"
		even
BgmS3ZoneBoss:	include "res/bgm/sonic3/Zone boss.asm"
		even
BgmS3FinalBoss:	include "res/bgm/sonic3/Final boss.asm"
		even
BgmS3Knuckles:	include "res/bgm/sonic3/Knuckles (Sonic 3).asm"
		even
BgmSKKnuckles:	include "res/bgm/sonic3/Knuckles (Sonic & Knuckles).asm"
		even
BgmS3Invinc:	include "res/bgm/sonic3/Invincible (Sonic 3).asm"
		even
BgmSKInvinc:	include "res/bgm/sonic3/Invincible (Sonic & Knuckles).asm"
		even
BgmS3ExtraLife:	include "res/bgm/sonic3/1UP (Sonic 3).asm"
		even
BgmSKExtraLife:	include "res/bgm/sonic3/1UP (Sonic & Knuckles).asm"
		even
BgmS3ActClear:	include "res/bgm/sonic3/Level Outro.asm"
		even
BgmS3Drowning:	include "res/bgm/sonic3/Countdown.asm"
		even
BgmS3GameOver:	include "res/bgm/sonic3/Game Over.asm"
		even
BgmS3Continue:	include "res/bgm/sonic3/Continue (Sonic & Knuckles).asm"
		even
BgmS3CompMenu:	include "res/bgm/sonic3/Competition Menu.asm"
		even
BgmS3ALZ:	include "res/bgm/sonic3/Azure Lake.asm"
		even
BgmS3BPZ:	include "res/bgm/sonic3/Balloon Park.asm"
		even
BgmS3CGZ:	include "res/bgm/sonic3/Chrome Gadget.asm"
		even
BgmS3DPZ:	include "res/bgm/sonic3/Desert Palace.asm"
		even
BgmS3EMZ:	include "res/bgm/sonic3/Endless Mine.asm"
		even
BgmS3Credits:	include "res/bgm/sonic3/Credits (Sonic 3).asm"
		even
BgmSKCredits:	include "res/bgm/sonic3/Credits (Sonic & Knuckles).asm"
		even

BgmS3BCNZ1:	include "res/bgm/sonic3-1103/CNZ1.asm"
		even
BgmS3BCNZ2:	include "res/bgm/sonic3-1103/CNZ2.asm"
		even
BgmS3BICZ1:	include "res/bgm/sonic3-1103/ICZ1.asm"
		even
BgmS3BICZ2:	include "res/bgm/sonic3-1103/ICZ2.asm"
		even
BgmS3BLBZ1:	include "res/bgm/sonic3-1103/LBZ1.asm"
		even
BgmS3BLBZ2:	include "res/bgm/sonic3-1103/LBZ2.asm"
		even
BgmS3BKnuckles:	include "res/bgm/sonic3-1103/Knuckles.asm"
		even
BgmS3BCompMenu:	include "res/bgm/sonic3-1103/Competition Menu.asm"
		even
BgmS3BCredits:	include "res/bgm/sonic3-1103/Credits.asm"
		even
BgmS3BUnused:	include "res/bgm/sonic3-1103/Unused Theme.asm"
		even

BgmS3DIntro:	include "res/bgm/sonic3D/Intro.asm"
		even
BgmS3DMenu:	include "res/bgm/sonic3D/Menu.asm"
		even
BgmS3DGrGZ1:	include "res/bgm/sonic3D/GreenGZ1.asm"
		even
BgmS3DGrGZ2:	include "res/bgm/sonic3D/GreenGZ2.asm"
		even
BgmS3DRRZ1:	include "res/bgm/sonic3D/RRZ1.asm"
		even
BgmS3DRRZ2:	include "res/bgm/sonic3D/RRZ2.asm"
		even
BgmS3DSSZ1:	include "res/bgm/sonic3D/SSZ1.asm"
		even
BgmS3DSSZ2:	include "res/bgm/sonic3D/SSZ2.asm"
		even
BgmS3DDDZ1:	include "res/bgm/sonic3D/DDZ1.asm"
		even
BgmS3DDDZ2:	include "res/bgm/sonic3D/DDZ2.asm"
		even
BgmS3VVDZ1:	include "res/bgm/sonic3D/VVZ1.asm"
		even
BgmS3VVDZ2:	include "res/bgm/sonic3D/VVZ2.asm"
		even
BgmS3DGeGZ1:	include "res/bgm/sonic3D/GeneGZ1.asm"
		even
BgmS3DGeGZ2:	include "res/bgm/sonic3D/GeneGZ2.asm"
		even
BgmS3PPDZ1:	include "res/bgm/sonic3D/PPZ1.asm"
		even
BgmS3PPDZ2:	include "res/bgm/sonic3D/PPZ2.asm"
		even
BgmS3DSpecial:	include "res/bgm/sonic3D/Special Stage.asm"
		even
BgmS3DInvinc:	include "res/bgm/sonic3D/Invincible.asm"
		even
BgmS3DBoss1:	include "res/bgm/sonic3D/Boss1.asm"
		even
BgmS3DBoss2:	include "res/bgm/sonic3D/Boss2.asm"
		even
BgmS3DBoss3:	include "res/bgm/sonic3D/Unused boss theme.asm"
		even
BgmS3DFinalBoss:	include "res/bgm/sonic3D/The Final Fight.asm"
		even
BgmS3DEnding:	include "res/bgm/sonic3D/Ending.asm"
		even
BgmS3DCredits:	include "res/bgm/sonic3D/Credits.asm"
		even
; ---------------------------------------------------------------
; PCM data
; ---------------------------------------------------------------
	pcminc START
	pcminc Kick,			"res/pcm/sonic2/Kick.dpcm"
	pcminc Snare,			"res/pcm/sonic2/Snare.pcm"
	pcminc Timpani,			"res/pcm/sonic2/Timpani.dpcm"
	pcminc Clap,			"res/pcm/sonic2/Clap.dpcm"
	pcminc Tom,			"res/pcm/sonic2/Tom.pcm"
	pcminc Scratch,			"res/pcm/sonic2/Scratch.dpcm"
	pcminc Bongo,			"res/pcm/sonic2/Bongo.dpcm"

	pcminc SnareS3,			"res/pcm/sonic3/SnareS3.dpcm"
	pcminc TomS3,			"res/pcm/sonic3/TomS3.dpcm"
	pcminc KickS3,			"res/pcm/sonic3/KickS3.dpcm"
	pcminc MuffledSnare,		"res/pcm/sonic3/MuffledSnare.dpcm"
	pcminc CrashCymbalS3,		"res/pcm/sonic3/CrashCymbalS3.dpcm"
	pcminc RideCymbal,		"res/pcm/sonic3/RideCymbal.dpcm"
	pcminc MetalHit,		"res/pcm/sonic3/MetalHit.dpcm"
	pcminc HighMetalHit,		"res/pcm/sonic3/HighMetalHit.dpcm"
	pcminc HigherMetalHit,		"res/pcm/sonic3/HigherMetalHit.dpcm"
	pcminc ClapS3,			"res/pcm/sonic3/ClapS3.dpcm"
	pcminc ElectricTomS3,		"res/pcm/sonic3/ElectricTomS3.dpcm"
	pcminc PitchSnareS3,		"res/pcm/sonic3/PitchSnareS3.dpcm"
	pcminc TimpaniS3,		"res/pcm/sonic3/TimpaniS3.dpcm"
	pcminc QuickLooseSnare,		"res/pcm/sonic3/QuickLooseSnare.dpcm"
	pcminc Click,			"res/pcm/sonic3/Click.dpcm"
	pcminc PowerKick,		"res/pcm/sonic3/PowerKick.dpcm"
	pcminc QuickGlassCrash,		"res/pcm/sonic3/QuickGlassCrash.dpcm"
	pcminc GlassCrashSnare,		"res/pcm/sonic3/GlassCrashSnare.dpcm"
	pcminc GlassCrash,		"res/pcm/sonic3/GlassCrash.dpcm"
	pcminc GlassCrashKick,		"res/pcm/sonic3/GlassCrashKick.dpcm"
	pcminc QuietGlassCrash,		"res/pcm/sonic3/QuietGlassCrash.dpcm"
	pcminc OddSnareKick,		"res/pcm/sonic3/OddSnareKick.dpcm"
	pcminc KickExtraBass,		"res/pcm/sonic3/KickExtraBass.dpcm"
	pcminc ComeOn,			"res/pcm/sonic3/ComeOn.dpcm"
	pcminc DanceSnare,		"res/pcm/sonic3/DanceSnare.dpcm"
	pcminc LooseKick,		"res/pcm/sonic3/LooseKick.dpcm"
	pcminc ModLooseKick,		"res/pcm/sonic3/ModLooseKick.dpcm"
	pcminc Woo,			"res/pcm/sonic3/Woo.dpcm"
	pcminc Go,			"res/pcm/sonic3/Go.dpcm"
	pcminc SnareGo,			"res/pcm/sonic3/SnareGo.dpcm"
	pcminc PowerTom,		"res/pcm/sonic3/PowerTom.dpcm"
	pcminc WoodBlock,		"res/pcm/sonic3/WoodBlock.dpcm"
	pcminc HitDrum,			"res/pcm/sonic3/HitDrum.dpcm"
	pcminc MetalCrashHit,		"res/pcm/sonic3/MetalCrashHit.dpcm"
	pcminc EchoedClapHitSK,		"res/pcm/sonic3/EchoedClapHitSK.dpcm"
	pcminc EchoedClapHitS3,		"res/pcm/sonic3/EchoedClapHitS3.dpcm"
	pcminc PowerKickHit,		"res/pcm/sonic3/PowerKickHit.dpcm"
	pcminc HipHopHitPowerKick,	"res/pcm/sonic3/HipHopHitPowerKick.dpcm"
	pcminc BassHey,			"res/pcm/sonic3/BassHey.dpcm"
	pcminc DanceStyleKick,		"res/pcm/sonic3/DanceStyleKick.dpcm"
	pcminc HipHopHitKick,		"res/pcm/sonic3/HipHopHitKick.dpcm"
	pcminc ReverseFadingWind,	"res/pcm/sonic3/ReverseFadingWind.dpcm"
	pcminc ScratchS3,		"res/pcm/sonic3/ScratchS3.dpcm"
	pcminc LooseSnareNoise,		"res/pcm/sonic3/LooseSnareNoise.dpcm"
	pcminc PowerKick2,		"res/pcm/sonic3/PowerKick2.dpcm"
	pcminc CrashingNoiseWoo,	"res/pcm/sonic3/CrashingNoiseWoo.dpcm"
	pcminc QuickHit,		"res/pcm/sonic3/QuickHit.dpcm"
	pcminc KickHey,			"res/pcm/sonic3/KickHey.dpcm"

	pcminc IntroKick,		"res/pcm/sonic3d/IntroKick.dpcm"
	pcminc FinalFightMetalCrash,	"res/pcm/sonic3d/FinalFightMetalCrash.dpcm"

	pcminc SegaPCM,			"res/pcm/Sega.pcm"
;	pcminc Rizzmas,			"res/pcm/rizzmas.wav"
	pcminc END
; ---------------------------------------------------------------
	even