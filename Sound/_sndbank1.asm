; ---------------------------------------------------------------------------
; SMPS-Dusted driver data
; ---------------------------------------------------------------------------
SMPS_Start:
	if MOMPASS=1
.s:	dc.w 0,0,0
	else
.s:	dc.w mus__Last-mus__First,sfx__Last-sfx__First,dac__Last-dac__First
	endif
	dc.w __smpsDataVer
	dc.w SMPS_MusicIndex-.s
	dc.w SMPS_SoundIndex-.s
	dc.w SMPS_UVB_FM-.s
	dc.w SMPS_VolEnvIndex-.s
	dc.w SMPS_ModEnvIndex-.s
	dc.l SMPS_SampleTable-.s
; ---------------------------------------------------------------------------
	cmddef smpsramsize,	v_endofram
	cmddef cmd__First,	$F000
;	cmddef cmd_FadeoutBGM,	$F000
	cmddef mus_FadeOut,	$F100
;	cmddef cmd_Fadein,	$F200
	cmddef mus_Stop,	$F300
;	cmddef cmd_StopBGM,	$F301
;	cmddef cmd_StopSFX,	$F302
;	cmddef cmd_StopBSFX,	$F304
;	cmddef cmd_StopPSFX,	$F308
	cmddef mus_Slowdown,	$F400
	cmddef mus_Speedup,	$F401
;	cmddef cmd_PanStereo,	$F402
;	cmddef cmd_PanMono,	$F403
;	cmddef cmd_SsgOn,	$F404
;	cmddef cmd_SsgOff,	$F405
;	cmddef cmd_MuffleOn,	$F406
;	cmddef cmd_MuffleOff,	$F407
	cmddef cmd__Last,	$F500
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
SMPS_VolEnvIndex_s07:	smpsEnvVolPsg $01,$0C,$03,$0F,$02,$07,$03,$0F,RESET
SMPS_VolEnvIndex_s08:	smpsEnvVolPsg $00,$00,$00,$02,$03,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0F,HOLD
SMPS_VolEnvIndex_s09:	smpsEnvVolPsg $03,$02,$01,$01,$00,$00,$01,$02,$03,$04,HOLD
SMPS_VolEnvIndex_s0A:	smpsEnvVolPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04,$04,$04,$05,$05,HOLD
SMPS_VolEnvIndex_s0B:	smpsEnvVol    $10,$20,$30,$40,$30,$20,$10,$00,$7F,RESET	; ...,-$10,RESET
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
			smpsEnvVol    $10,$20,$30,$40,$30,$20,$10,$00,RESET
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
; index start: "START" keyword, first song id
; song index: jingle flag, PAL speed adjustment disable, water muffle disable, song data pointer, song data id
; index end: "END" keyword, last song id
; ---------------------------------------------------------------------------
SMPS_MusicIndex:
	musdef START,mus__First

	musdef	0,0,0,MusData_DEZ1,		mus_DEZ1
	musdef	0,0,0,MusData_MidBoss,		mus_MidBoss
	musdef	0,0,0,MusData_ZoneBoss,		mus_ZoneBoss
	musdef	0,0,0,MusData_Invincible,	mus_Invincible 
	musdef	0,1,0,MusData_GotThrough,	mus_GotThrough
	musdef	0,1,1,MusData_Drowning,		mus_Drowning
	musdef	0,1,0,MusData_GameOver,		mus_GameOver
	musdef	1,0,0,MusData_ExtraLife,	mus_ExtraLife
	musdef	0,1,0,MusData_Continue,		mus_Continue

	musdef END,mus__Last
SMPS_MusicIndex_Exit:
	even
; ---------------------------------------------------------------------------
; Sound	effect index
; index start: "START" keyword, first sound id, last song id
; song index: sound priority (0 to ignore, 1 is lowest, $FF is highest), csfx flag, bsfx flag, water muffle disable, sound data pointer, sound data id
; index end: "END" keyword, last sound id
; ---------------------------------------------------------------------------
SMPS_SoundIndex:
	sfxdef START,sfx__First,mus__Last

	sfxdef	$00,0,0,0,SfxData_RingRight,		sfx_RingRight
	sfxdef	$00,0,0,0,SfxData_RingLeft,		sfx_RingLeft
	sfxdef	$00,0,0,0,SfxData_RingLoss,		sfx_RingLoss
	sfxdef	$00,0,0,0,SfxData_Jump,			sfx_Jump
	sfxdef	$00,0,0,0,SfxData_Roll,			sfx_Roll
	sfxdef	$00,0,0,0,SfxData_Skid,			sfx_Skid
	sfxdef	$00,0,0,0,SfxData_Death,		sfx_Death
	sfxdef	$00,0,0,0,SfxData_SpinDash,		sfx_SpinDash
	sfxdef	$00,0,0,0,SfxData_Splash,		sfx_Splash
	sfxdef	$00,0,0,0,SfxData_InstaAttack,		sfx_InstaAttack
	sfxdef	$00,0,0,0,SfxData_FireShield,		sfx_FireShield
	sfxdef	$00,0,0,0,SfxData_BubbleShield,		sfx_BubbleShield
	sfxdef	$00,0,0,0,SfxData_LightningShield,	sfx_LightningShield
	sfxdef	$00,0,0,0,SfxData_FireAttack,		sfx_FireAttack
	sfxdef	$00,0,0,0,SfxData_BubbleAttack,		sfx_BubbleAttack
	sfxdef	$00,0,0,0,SfxData_ElectricAttack,	sfx_ElectricAttack 
	sfxdef	$00,0,0,0,SfxData_SpikeHit,		sfx_SpikeHit
	sfxdef	$00,0,0,0,SfxData_SpikeMove,		sfx_SpikeMove
	sfxdef	$00,0,0,0,SfxData_Drown,		sfx_Drown
	sfxdef	$00,0,0,0,SfxData_StarPost,		sfx_StarPost
	sfxdef	$00,0,0,0,SfxData_Spring,		sfx_Spring
	sfxdef	$00,0,0,0,SfxData_Dash,			sfx_Dash
	sfxdef	$00,0,0,0,SfxData_Break,		sfx_Break
	sfxdef	$00,0,0,0,SfxData_BossHit,		sfx_BossHit
	sfxdef	$00,0,0,0,SfxData_AirDing,		sfx_AirDing
	sfxdef	$00,0,0,0,SfxData_Bubble,		sfx_Bubble
	sfxdef	$00,0,0,0,SfxData_Explode,		sfx_Explode
	sfxdef	$00,0,0,0,SfxData_Signpost,		sfx_Signpost
	sfxdef	$00,0,0,0,SfxData_Switch,		sfx_Switch
	sfxdef	$00,0,0,0,SfxData_Register,		sfx_Register
	sfxdef	$00,0,0,0,SfxData_Grab,			sfx_Grab
	sfxdef	$00,0,0,0,SfxData_Flying,		sfx_Flying
	sfxdef	$00,0,0,0,SfxData_FlyTired,		sfx_FlyTired
	sfxdef	$00,0,0,0,SfxData_GlideLand,		sfx_GlideLand
	sfxdef	$00,0,0,0,SfxData_GroundSlide,		sfx_GroundSlide
	sfxdef	$00,0,0,0,SfxData_Laser,		sfx_Laser
	sfxdef	$00,0,0,0,SfxData_SuperTransform,	sfx_SuperTransform 
	sfxdef	$00,0,0,0,SfxData_Thump,		sfx_Thump

	sfxdef END,sfx__Last
SMPS_SoundIndex_Exit:
	even
; ---------------------------------------------------------------------------
; PCM Samples
; ---------------------------------------------------------------------------
SMPS_SampleTable:
; ============= type	expected driver		sequence id start	queue id start			queue id start label
	pcmdef	START,	MegaPCM2,		$81,			sfx__Last,			dac__First
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
	pcmdef	END,	MegaPCM2,		d__Last,		dac__Last

; ---------------------------------------------------------------------------
; Sound effect data
; ---------------------------------------------------------------------------
SfxData_RingLeft:	include "_SFX/Snd - Ring Left Speaker.asm"	; shares FM patch with Ring
			even
SfxData_RingLoss:	include "_SFX/Snd - Ring Loss.asm"		; shares FM patch with Ring
			even
SfxData_RingRight:	include "_SFX/Snd - Ring.asm"
			even
SfxData_Jump:		include "_SFX/Snd - Jump.asm"
			even
SfxData_Roll:		include "_SFX/Snd - Roll.asm"
			even
SfxData_Skid:		include "_SFX/Snd - Skid.asm"
			even
SfxData_Death:		include "_SFX/Snd - Death.asm"
			even
SfxData_SpinDash:	include "_SFX/Snd - SpinDash.asm"
			even
SfxData_Splash:		include "_SFX/Snd - Splash.asm"
			even
SfxData_InstaAttack:	include "_SFX/Snd - Insta Attack.asm"
			even
SfxData_LightningShield:include "_SFX/Snd - Lightning Shield.asm"	; shares sequence with FireShield
			even
SfxData_BubbleShield:	include "_SFX/Snd - Bubble Shield.asm"		; shares sequence with FireShield
			even
SfxData_FireShield:	include "_SFX/Snd - Fire Shield.asm"
			even
SfxData_FireAttack:	include "_SFX/Snd - Fire Attack.asm"
			even
SfxData_BubbleAttack:	include "_SFX/Snd - Bubble Attack.asm"
			even
SfxData_ElectricAttack:	include "_SFX/Snd - Electric Attack.asm"
			even
SfxData_SpikeHit:	include "_SFX/Snd - Spike Hit.asm"
			even
SfxData_SpikeMove:	include "_SFX/Snd - Spike Move.asm"
			even
SfxData_Drown:		include "_SFX/Snd - Drown.asm"
			even
SfxData_StarPost:	include "_SFX/Snd - StarPost.asm"
			even
SfxData_Spring:		include "_SFX/Snd - Spring.asm"
			even
SfxData_Dash:		include "_SFX/Snd - Dash.asm"
			even
SfxData_Break:		include "_SFX/Snd - Break.asm"
			even
SfxData_BossHit:	include "_SFX/Snd - Boss Hit.asm"
			even
SfxData_AirDing:	include "_SFX/Snd - Air Ding.asm"
			even
SfxData_Bubble:		include "_SFX/Snd - Bubble.asm"
			even
SfxData_Explode:	include "_SFX/Snd - Explode.asm"
			even
SfxData_Signpost:	include "_SFX/Snd - Signpost.asm"
			even
SfxData_Switch:		include "_SFX/Snd - Switch.asm"
			even
SfxData_Register:	include "_SFX/Snd - Register.asm"
			even
SfxData_Grab:		include "_SFX/Snd - Grab.asm"
			even
SfxData_FlyTired:	include "_SFX/Snd - FlyTired.asm"		; shares FM patch with Flying
			even
SfxData_Flying:		include "_SFX/Snd - Flying.asm"
			even
SfxData_GlideLand:	include "_SFX/Snd - GlideLand.asm"
			even
SfxData_GroundSlide:	include "_SFX/Snd - GroundSlide.asm"
			even
SfxData_Laser:		include "_SFX/Snd - Laser.asm"
			even
SfxData_SuperTransform:	include "_SFX/Snd - Super Transform.asm"
			even
SfxData_Thump:		include "_SFX/Snd - Thump.asm"
			even

; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------
MusData_DEZ1:		include "_Music/Mus - DEZ1.asm"
			even
MusData_MidBoss:	include "_Music/Mus - Miniboss.asm"
			even
MusData_ZoneBoss:	include "_Music/Mus - Zone Boss.asm"
			even
MusData_Invincible:	include "_Music/Mus - Invincibility.asm"
			even
MusData_GotThrough:	include "_Music/Mus - Sonic Got Through.asm"
			even
MusData_Drowning:	include "_Music/Mus - Drowning.asm"
			even
MusData_GameOver:	include "_Music/Mus - Game Over.asm"
			even
MusData_ExtraLife:	include "_Music/Mus - Extra Life.asm"
			even
MusData_Continue:	include "_Music/Mus - Continue.asm"
			even

; ---------------------------------------------------------------
; PCM data
; ---------------------------------------------------------------
	pcminc START
	pcminc Kick,			"_DAC/sonic2/Kick.dpcm"
	pcminc Snare,			"_DAC/sonic2/Snare.pcm"
	pcminc Timpani,			"_DAC/sonic2/Timpani.dpcm"
	pcminc Clap,			"_DAC/sonic2/Clap.dpcm"
	pcminc Tom,			"_DAC/sonic2/Tom.pcm"
	pcminc Scratch,			"_DAC/sonic2/Scratch.dpcm"
	pcminc Bongo,			"_DAC/sonic2/Bongo.dpcm"
	pcminc SnareS3,			"_DAC/sonic3/SnareS3.dpcm"
	pcminc TomS3,			"_DAC/sonic3/TomS3.dpcm"
	pcminc KickS3,			"_DAC/sonic3/KickS3.dpcm"
	pcminc MuffledSnare,		"_DAC/sonic3/MuffledSnare.dpcm"
	pcminc CrashCymbalS3,		"_DAC/sonic3/CrashCymbalS3.dpcm"
	pcminc RideCymbal,		"_DAC/sonic3/RideCymbal.dpcm"
	pcminc MetalHit,		"_DAC/sonic3/MetalHit.dpcm"
	pcminc HighMetalHit,		"_DAC/sonic3/HighMetalHit.dpcm"
	pcminc HigherMetalHit,		"_DAC/sonic3/HigherMetalHit.dpcm"
	pcminc ClapS3,			"_DAC/sonic3/ClapS3.dpcm"
	pcminc ElectricTomS3,		"_DAC/sonic3/ElectricTomS3.dpcm"
	pcminc PitchSnareS3,		"_DAC/sonic3/PitchSnareS3.dpcm"
	pcminc TimpaniS3,		"_DAC/sonic3/TimpaniS3.dpcm"
	pcminc QuickLooseSnare,		"_DAC/sonic3/QuickLooseSnare.dpcm"
	pcminc Click,			"_DAC/sonic3/Click.dpcm"
	pcminc PowerKick,		"_DAC/sonic3/PowerKick.dpcm"
	pcminc QuickGlassCrash,		"_DAC/sonic3/QuickGlassCrash.dpcm"
	pcminc GlassCrashSnare,		"_DAC/sonic3/GlassCrashSnare.dpcm"
	pcminc GlassCrash,		"_DAC/sonic3/GlassCrash.dpcm"
	pcminc GlassCrashKick,		"_DAC/sonic3/GlassCrashKick.dpcm"
	pcminc QuietGlassCrash,		"_DAC/sonic3/QuietGlassCrash.dpcm"
	pcminc OddSnareKick,		"_DAC/sonic3/OddSnareKick.dpcm"
	pcminc KickExtraBass,		"_DAC/sonic3/KickExtraBass.dpcm"
	pcminc ComeOn,			"_DAC/sonic3/ComeOn.dpcm"
	pcminc DanceSnare,		"_DAC/sonic3/DanceSnare.dpcm"
	pcminc LooseKick,		"_DAC/sonic3/LooseKick.dpcm"
	pcminc ModLooseKick,		"_DAC/sonic3/ModLooseKick.dpcm"
	pcminc Woo,			"_DAC/sonic3/Woo.dpcm"
	pcminc Go,			"_DAC/sonic3/Go.dpcm"
	pcminc SnareGo,			"_DAC/sonic3/SnareGo.dpcm"
	pcminc PowerTom,		"_DAC/sonic3/PowerTom.dpcm"
	pcminc WoodBlock,		"_DAC/sonic3/WoodBlock.dpcm"
	pcminc HitDrum,			"_DAC/sonic3/HitDrum.dpcm"
	pcminc MetalCrashHit,		"_DAC/sonic3/MetalCrashHit.dpcm"
	pcminc EchoedClapHitSK,		"_DAC/sonic3/EchoedClapHitSK.dpcm"
	pcminc EchoedClapHitS3,		"_DAC/sonic3/EchoedClapHitS3.dpcm"
	pcminc PowerKickHit,		"_DAC/sonic3/PowerKickHit.dpcm"
	pcminc HipHopHitPowerKick,	"_DAC/sonic3/HipHopHitPowerKick.dpcm"
	pcminc BassHey,			"_DAC/sonic3/BassHey.dpcm"
	pcminc DanceStyleKick,		"_DAC/sonic3/DanceStyleKick.dpcm"
	pcminc HipHopHitKick,		"_DAC/sonic3/HipHopHitKick.dpcm"
	pcminc ReverseFadingWind,	"_DAC/sonic3/ReverseFadingWind.dpcm"
	pcminc ScratchS3,		"_DAC/sonic3/ScratchS3.dpcm"
	pcminc LooseSnareNoise,		"_DAC/sonic3/LooseSnareNoise.dpcm"
	pcminc PowerKick2,		"_DAC/sonic3/PowerKick2.dpcm"
	pcminc CrashingNoiseWoo,	"_DAC/sonic3/CrashingNoiseWoo.dpcm"
	pcminc QuickHit,		"_DAC/sonic3/QuickHit.dpcm"
	pcminc KickHey,			"_DAC/sonic3/KickHey.dpcm"
	pcminc IntroKick,		"_DAC/sonic3d/IntroKick.dpcm"
	pcminc FinalFightMetalCrash,	"_DAC/sonic3d/FinalFightMetalCrash.dpcm"
	pcminc SegaPCM,			"_DAC/Sega.pcm"
	pcminc END
; ---------------------------------------------------------------
	even