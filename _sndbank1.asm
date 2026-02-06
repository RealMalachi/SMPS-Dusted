; ---------------------------------------------------------------------------
; SMPS-Dusted driver data
; ---------------------------------------------------------------------------
SMPS_Start:
	if MOMPASS=1
.s:	dc.w 0,0,0
	else
.s:	dc.w bgm__Last-bgm__First,sfx__Last-sfx__First,pcm__Last-pcm__First
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
	cmddef cmd_FadeoutBGM,	$F000
	cmddef cmd_Fadeout,	$F100
	cmddef cmd_Fadein,	$F200
	cmddef cmd_StopAll,	$F300
	cmddef cmd_StopBGM,	$F301
	cmddef cmd_StopSFX,	$F302
	cmddef cmd_StopBSFX,	$F304
	cmddef cmd_StopPSFX,	$F308
	cmddef cmd_SpeedOff,	$F400
	cmddef cmd_SpeedOn,	$F401
	cmddef cmd_PanStereo,	$F402
	cmddef cmd_PanMono,	$F403
	cmddef cmd_SsgOn,	$F404
	cmddef cmd_SsgOff,	$F405
	cmddef cmd_MuffleOn,	$F406
	cmddef cmd_MuffleOff,	$F407
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
	even
; ---------------------------------------------------------------------------
; Sound	effect index
; index start: "START" keyword, first sound id, last song id
; song index: sound priority (0 to ignore, 1 is lowest, $FF is highest), csfx flag, bsfx flag, water muffle disable, sound data pointer, sound data id
; index end: "END" keyword, last sound id
; ---------------------------------------------------------------------------
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

	sfxdef END,sfx__Last
SMPS_SoundIndex_Exit:
	even
; ---------------------------------------------------------------------------
; PCM Samples
; ---------------------------------------------------------------------------
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
SfxTest:	include "sfx/_tester.asm"
		even
SfxFlicky:	include "sfx/Flicky Tweet.asm"
		even
SfxFlickyGrab:	include "sfx/Flicky Grab Jingle.asm"
		even
SfxSpindash:	include "sfx/Spin Dash Rev.asm"
		even
SfxSpikeMove:	include "sfx/Spike Move.asm"
		even
SfxSkidPSG:	include "sfx/Skid PSG.asm"
		even
SfxSkidFM:	include "sfx/Skid FM.asm"
		even

SfxS1A0:	include "sfx/sonic1/SndA0 - Jump.asm"
		even
SfxS1A1:	include "sfx/sonic1/SndA1 - Lamppost.asm"
		even
SfxS1A2:	include "sfx/sonic1/SndA2.asm"
		even
SfxS1A3:	include "sfx/sonic1/SndA3 - Death.asm"
		even
SfxS1A4:	include "sfx/sonic1/SndA4 - Skid.asm"
		even
SfxS1A5:	include "sfx/sonic1/SndA5.asm"
		even
SfxS1A6:	include "sfx/sonic1/SndA6 - Hit Spikes.asm"
		even
SfxS1A7:	include "sfx/sonic1/SndA7 - Push Block.asm"
		even
SfxS1A8:	include "sfx/sonic1/SndA8 - SS Goal.asm"
		even
SfxS1A9:	include "sfx/sonic1/SndA9 - SS Item.asm"
		even
SfxS1AA:	include "sfx/sonic1/SndAA - Splash.asm"
		even
SfxS1AB:	include "sfx/sonic1/SndAB.asm"
		even
SfxS1AC:	include "sfx/sonic1/SndAC - Hit Boss.asm"
		even
SfxS1AD:	include "sfx/sonic1/SndAD - Get Bubble.asm"
		even
SfxS1AE:	include "sfx/sonic1/SndAE - Fireball.asm"
		even
SfxS1AF:	include "sfx/sonic1/SndAF - Shield.asm"
		even
SfxS1B0:	include "sfx/sonic1/SndB0 - Saw.asm"
		even
SfxS1B1:	include "sfx/sonic1/SndB1 - Electric.asm"
		even
SfxS1B2:	include "sfx/sonic1/SndB2 - Drown Death.asm"
		even
SfxS1B3:	include "sfx/sonic1/SndB3 - Flamethrower.asm"
		even
SfxS1B4:	include "sfx/sonic1/SndB4 - Bumper.asm"
		even
SfxS1B5:	include "sfx/sonic1/SndB5 - Ring.asm"
		even
SfxS1B6:	include "sfx/sonic1/SndB6 - Spikes Move.asm"
		even
SfxS1B7:	include "sfx/sonic1/SndB7 - Rumbling.asm"
		even
SfxS1B8:	include "sfx/sonic1/SndB8.asm"
		even
SfxS1B9:	include "sfx/sonic1/SndB9 - Collapse.asm"
		even
SfxS1BA:	include "sfx/sonic1/SndBA - SS Glass.asm"
		even
SfxS1BB:	include "sfx/sonic1/SndBB - Door.asm"
		even
SfxS1BC:	include "sfx/sonic1/SndBC - Teleport.asm"
		even
SfxS1BD:	include "sfx/sonic1/SndBD - ChainStomp.asm"
		even
SfxS1BE:	include "sfx/sonic1/SndBE - Roll.asm"
		even
SfxS1BF:	include "sfx/sonic1/SndBF - Get Continue.asm"
		even
SfxS1C0:	include "sfx/sonic1/SndC0 - Basaran Flap.asm"
		even
SfxS1C1:	include "sfx/sonic1/SndC1 - Break Item.asm"
		even
SfxS1C2:	include "sfx/sonic1/SndC2 - Drown Warning.asm"
		even
SfxS1C3:	include "sfx/sonic1/SndC3 - Giant Ring.asm"
		even
SfxS1C4:	include "sfx/sonic1/SndC4 - Bomb.asm"
		even
SfxS1C5:	include "sfx/sonic1/SndC5 - Cash Register.asm"
		even
SfxS1C6:	include "sfx/sonic1/SndC6 - Ring Loss.asm"
		even
SfxS1C7:	include "sfx/sonic1/SndC7 - Chain Rising.asm"
		even
SfxS1C8:	include "sfx/sonic1/SndC8 - Burning.asm"
		even
SfxS1C9:	include "sfx/sonic1/SndC9 - Hidden Bonus.asm"
		even
SfxS1CA:	include "sfx/sonic1/SndCA - Enter SS.asm"
		even
SfxS1CB:	include "sfx/sonic1/SndCB - Wall Smash.asm"
		even
SfxS1CC:	include "sfx/sonic1/SndCC - Spring.asm"
		even
SfxS1CD:	include "sfx/sonic1/SndCD - Switch.asm"
		even
SfxS1CE:	include "sfx/sonic1/SndCE - Ring Left Speaker.asm"
		even
SfxS1CF:	include "sfx/sonic1/SndCF - Signpost.asm"
		even
BfxS1D0:	include "sfx/sonic1/SndD0 - Waterfall.asm"
		even

SfxS2A0:	include "sfx/sonic2/A0 - Jump.asm"
		even
SfxS2A1:	include "sfx/sonic2/A1 - Checkpoint.asm"
		even
SfxS2A2:	include "sfx/sonic2/A2 - Spike Switch.asm"
		even
SfxS2A3:	include "sfx/sonic2/A3 - Hurt.asm"
		even
SfxS2A4:	include "sfx/sonic2/A4 - Skidding.asm"
		even
SfxS2A5:	include "sfx/sonic2/A5 - Block Push.asm"
		even
SfxS2A6:	include "sfx/sonic2/A6 - Hurt by Spikes.asm"
		even
SfxS2A7:	include "sfx/sonic2/A7 - Sparkle.asm"
		even
SfxS2A8:	include "sfx/sonic2/A8 - Beep.asm"
		even
SfxS2A9:	include "sfx/sonic2/A9 - Special Stage Item (Unused).asm"
		even
SfxS2AA:	include "sfx/sonic2/AA - Splash.asm"
		even
SfxS2AB:	include "sfx/sonic2/AB - Swish.asm"
		even
SfxS2B9:	include "sfx/sonic2/B9 - Smash.asm"		; shares FM instrument with Boss Hit
		even
SfxS2CB:	include "sfx/sonic2/CB - Slow Smash.asm"	; shares FM instrument with Boss Hit
		even
SfxS2AC:	include "sfx/sonic2/AC - Boss Hit.asm"
		even
SfxS2AD:	include "sfx/sonic2/AD - Inhaling Bubble.asm"
		even
SfxS2B3:	include "sfx/sonic2/B3 - Fire Burn.asm"		; shares FM instrument with Lava Ball
		even
SfxS2AE:	include "sfx/sonic2/AE - Lava Ball.asm"
		even
SfxS2AF:	include "sfx/sonic2/AF - Shield.asm"
		even
SfxS2B0:	include "sfx/sonic2/B0 - Laser Beam.asm"
		even
SfxS2B1:	include "sfx/sonic2/B1 - Electricity (Unused).asm"
		even
SfxS2B2:	include "sfx/sonic2/B2 - Drown.asm"
		even
SfxS2B4:	include "sfx/sonic2/B4 - Bumper.asm"
		even
SfxS2C6:	include "sfx/sonic2/C6 - Ring Spill.asm"	; shares FM instrument with Ring
		even
SfxS2CE:	include "sfx/sonic2/CE - Ring Left Speaker.asm"	; shares FM instrument with Ring
		even
SfxS2B5:	include "sfx/sonic2/B5 - Ring.asm"
		even
SfxS2B6:	include "sfx/sonic2/B6 - Spikes Move.asm"
		even
SfxS2B7:	include "sfx/sonic2/B7 - Rumbling.asm"
		even
SfxS2B8:	include "sfx/sonic2/B8 - Unknown (Unused).asm"
		even
SfxS2BA:	include "sfx/sonic2/BA - Special Stage Glass (Unused).asm"
		even
SfxS2BB:	include "sfx/sonic2/BB - Door Slam.asm"
		even
SfxS2BC:	include "sfx/sonic2/BC - Spin Dash Release.asm"
		even
SfxS2BD:	include "sfx/sonic2/BD - Hammer.asm"
		even
SfxS2BE:	include "sfx/sonic2/BE - Roll.asm"
		even
SfxS2C0:	include "sfx/sonic2/C0 - Casino Bonus.asm"	; shares FM instrument with Continue jingle
		even
SfxS2C2:	include "sfx/sonic2/C2 - Water Warning.asm"	; shares FM instrument with Continue jingle
		even
SfxS2BF:	include "sfx/sonic2/BF - Continue Jingle.asm"
		even
SfxS2C1:	include "sfx/sonic2/C1 - Explosion.asm"
		even
SfxS2C3:	include "sfx/sonic2/C3 - Enter Giant Ring (Unused).asm"
		even
SfxS2C4:	include "sfx/sonic2/C4 - Boss Explosion.asm"
		even
SfxS2C5:	include "sfx/sonic2/C5 - Tally End.asm"
		even
SfxS2C7:	include "sfx/sonic2/C7 - Chain Rise (Unused).asm"
		even
SfxS2C8:	include "sfx/sonic2/C8 - Flamethrower.asm"
		even
SfxS2C9:	include "sfx/sonic2/C9 - Hidden Bonus (Unused).asm"
		even
SfxS2CA:	include "sfx/sonic2/CA - Special Stage Entry.asm"
		even
SfxS2CC:	include "sfx/sonic2/CC - Spring.asm"
		even
SfxS2CD:	include "sfx/sonic2/CD - Switch.asm"
		even
SfxS2CF:	include "sfx/sonic2/CF - Signpost.asm"
		even
SfxS2D0:	include "sfx/sonic2/D0 - CNZ Boss Zap.asm"
		even
SfxS2D1:	include "sfx/sonic2/D1 - Unknown (Unused).asm"
		even
SfxS2D2:	include "sfx/sonic2/D2 - Unknown (Unused).asm"
		even
SfxS2D3:	include "sfx/sonic2/D3 - Signpost 2P.asm"
		even
SfxS2D4:	include "sfx/sonic2/D4 - OOZ Lid Pop.asm"
		even
SfxS2D5:	include "sfx/sonic2/D5 - Sliding Spike.asm"
		even
SfxS2D6:	include "sfx/sonic2/D6 - CNZ Elevator.asm"
		even
SfxS2D7:	include "sfx/sonic2/D7 - Platform Knock.asm"
		even
SfxS2D8:	include "sfx/sonic2/D8 - Bonus Bumper.asm"
		even
SfxS2D9:	include "sfx/sonic2/D9 - Large Bumper.asm"
		even
SfxS2DA:	include "sfx/sonic2/DA - Gloop.asm"
		even
SfxS2DB:	include "sfx/sonic2/DB - Pre-Arrow Firing.asm"
		even
SfxS2DC:	include "sfx/sonic2/DC - Fire.asm"
		even
SfxS2DD:	include "sfx/sonic2/DD - Arrow Stick.asm"
		even
SfxS2DE:	include "sfx/sonic2/DE - Helicopter.asm"
		even
SfxS2EC:	include "sfx/sonic2/EC - Teleport.asm"		; shares PSG sequences with super transform
		even
SfxS2DF:	include "sfx/sonic2/DF - Super Transform.asm"
		even
SfxS2E0:	include "sfx/sonic2/E0 - Spin Dash Rev.asm"
		even
SfxS2E1:	include "sfx/sonic2/E1 - Rumbling 2.asm"
		even
SfxS2E2:	include "sfx/sonic2/E2 - CNZ Launch.asm"
		even
SfxS2E3:	include "sfx/sonic2/E3 - Flipper.asm"
		even
SfxS2E4:	include "sfx/sonic2/E4 - HTZ Lift Click.asm"
		even
SfxS2E5:	include "sfx/sonic2/E5 - Leaves.asm"
		even
SfxS2E6:	include "sfx/sonic2/E6 - Mega Mack Drop.asm"
		even
SfxS2E7:	include "sfx/sonic2/E7 - Drawbridge Move.asm"
		even
SfxS2E8:	include "sfx/sonic2/E8 - Quick Door Slam.asm"
		even
SfxS2E9:	include "sfx/sonic2/E9 - Drawbridge Down.asm"
		even
SfxS2EF:	include "sfx/sonic2/EF - Large Laser.asm"	; shares FM instrument with Laser Burst
		even
SfxS2EA:	include "sfx/sonic2/EA - Laser Burst.asm"
		even
SfxS2EB:	include "sfx/sonic2/EB - Scatter.asm"
		even
SfxS2ED:	include "sfx/sonic2/ED - Error.asm"
		even
SfxS2EE:	include "sfx/sonic2/EE - Mecha Sonic Buzz.asm"
		even
SfxS2F0:	include "sfx/sonic2/F0 - Oil Slide.asm"
		even

SfxS2BD0:	include "sfx/sonic2-wai/D0 - CNZ Boss Zap.asm"
		even
SfxS2BD1:	include "sfx/sonic2-wai/D1 - Unknown (Unused).asm"
		even
SfxS2BD2:	include "sfx/sonic2-wai/D2 - Unknown (Unused).asm"
		even
SfxS2BD3:	include "sfx/sonic2-wai/D3 - Signpost 2P.asm"
		even
SfxS2BD4:	include "sfx/sonic2-wai/D4 - OOZ Lid Pop.asm"
		even
SfxS2BD5:	include "sfx/sonic2-wai/D5 - Sliding Spike.asm"
		even
SfxS2BD6:	include "sfx/sonic2-wai/D6 - CNZ Elevator.asm"
		even
SfxS2BD7:	include "sfx/sonic2-wai/D7 - Platform Knock.asm"
		even
SfxS2BD8:	include "sfx/sonic2-wai/D8 - Bonus Bumper.asm"
		even
SfxS2BD9:	include "sfx/sonic2-wai/D9 - Large Bumper.asm"
		even
SfxS2BDA:	include "sfx/sonic2-wai/DA - Gloop.asm"
		even
SfxS2BDB:	include "sfx/sonic2-wai/DB - Pre-Arrow Firing.asm"
		even
SfxS2BDC:	include "sfx/sonic2-wai/DC - Fire.asm"
		even
SfxS2BDD:	include "sfx/sonic2-wai/DD - Arrow Stick.asm"
		even
SfxS2BDE:	include "sfx/sonic2-wai/DE - Helicopter.asm"
		even
SfxS2BDF:	include "sfx/sonic2-wai/DF - Super Transform.asm"
		even
SfxS2BE0:	include "sfx/sonic2-wai/E0 - Spin Dash Rev.asm"
		even

SfxCdSKID:	include "sfx/soniccd/90 - Skid.asm"
		even
SfxCd91:	include "sfx/soniccd/91.asm"
		even
SfxCdJUMP:	include "sfx/soniccd/92 - Jump.asm"
		even
SfxCdHURT:	include "sfx/soniccd/93 - Hurt.asm"
		even
SfxCdRINGLOSS:	include "sfx/soniccd/94 - Ring Loss.asm"
		even
SfxCdRING:	include "sfx/soniccd/95 - Ring Right.asm"
		even
SfxCdDESTROY:	include "sfx/soniccd/96 - Destroy.asm"
		even
SfxCdSHIELD:	include "sfx/soniccd/97 - Shield.asm"
		even
SfxCdSPRING:	include "sfx/soniccd/98 - Spring.asm"
		even
SfxCd99:	include "sfx/soniccd/99.asm"
		even
SfxCdKACHING:	include "sfx/soniccd/9A - Kaching.asm"
		even
SfxCd9B:	include "sfx/soniccd/9B.asm"
		even
SfxCd9C:	include "sfx/soniccd/9C.asm"
		even
SfxCdSIGNPOST:	include "sfx/soniccd/9D - Signpost.asm"
		even
SfxCdEXPLODE:	include "sfx/soniccd/9E - Explode.asm"
		even
SfxCd9F:	include "sfx/soniccd/9F.asm"
		even
SfxCdA0:	include "sfx/soniccd/A0.asm"
		even
SfxCdA1:	include "sfx/soniccd/A1.asm"
		even
SfxCdA2:	include "sfx/soniccd/A2.asm"
		even
SfxCdA3:	include "sfx/soniccd/A3.asm"
		even
SfxCdA4:	include "sfx/soniccd/A4.asm"
		even
SfxCdA5:	include "sfx/soniccd/A5.asm"
		even
SfxCdA6:	include "sfx/soniccd/A6.asm"
		even
SfxCdA7:	include "sfx/soniccd/A7.asm"
		even
SfxCdRINGL:	include "sfx/soniccd/A8 - Ring Left.asm"
		even
SfxCdA9:	include "sfx/soniccd/A9 - Null.asm"
		even
SfxCdCHARGESTOP:include "sfx/soniccd/AB - Charge Stop.asm"	; shares patch with AA
		even
SfxCdAA:	include "sfx/soniccd/AA.asm"
		even
SfxCdAC:	include "sfx/soniccd/AC.asm"
		even
SfxCdAD:	include "sfx/soniccd/AD.asm"
		even
SfxCdCHECKPOINT:include "sfx/soniccd/AE - Checkpoint.asm"
		even
SfxCdBIGRING:	include "sfx/soniccd/AF - Big Ring.asm"
		even
SfxCdB0:	include "sfx/soniccd/B0.asm"
		even
SfxCdB1:	include "sfx/soniccd/B1.asm"
		even
SfxCdB2:	include "sfx/soniccd/B2.asm"
		even
SfxCdB3:	include "sfx/soniccd/B3.asm"
		even
SfxCdB4:	include "sfx/soniccd/B4.asm"
		even
SfxCdB5:	include "sfx/soniccd/B5.asm"
		even
SfxCdB6:	include "sfx/soniccd/B6.asm"
		even
SfxCdB7:	include "sfx/soniccd/B7.asm"
		even
SfxCdB8:	include "sfx/soniccd/B8.asm"
		even
SfxCdB9:	include "sfx/soniccd/B9.asm"
		even
SfxCdBA:	include "sfx/soniccd/BA.asm"
		even
SfxCdBB:	include "sfx/soniccd/BB.asm"
		even
SfxCdBC:	include "sfx/soniccd/BC.asm"
		even
SfxCdTALLY:	include "sfx/soniccd/BD - Tally.asm"
		even
SfxCdBE:	include "sfx/soniccd/BE.asm"
		even
SfxCdBF:	include "sfx/soniccd/BF.asm"
		even
SfxCdC0:	include "sfx/soniccd/C0.asm"
		even
SfxCdC1:	include "sfx/soniccd/C1.asm"
		even
SfxCdC2:	include "sfx/soniccd/C2.asm"
		even
SfxCdC3:	include "sfx/soniccd/C3.asm"
		even
SfxCdC4:	include "sfx/soniccd/C4.asm"
		even
SfxCdC5:	include "sfx/soniccd/C5.asm"
		even
SfxCdC6:	include "sfx/soniccd/C6.asm"
		even
SfxCdC7:	include "sfx/soniccd/C7.asm"
		even
SfxCdSSWARP:	include "sfx/soniccd/C8 - SS Warp.asm"
		even
SfxCdC9:	include "sfx/soniccd/C9.asm"
		even
SfxCdCA:	include "sfx/soniccd/CA.asm"
		even
SfxCdCB:	include "sfx/soniccd/CB.asm"
		even
SfxCdCC:	include "sfx/soniccd/CC.asm"
		even
SfxCdCD:	include "sfx/soniccd/CD.asm"
		even
SfxCdCE:	include "sfx/soniccd/CE.asm"
		even
SfxCdCF:	include "sfx/soniccd/CF.asm"
		even
SfxCdD0:	include "sfx/soniccd/D0.asm"
		even
SfxCdD1:	include "sfx/soniccd/D1.asm"
		even
SfxCdD2:	include "sfx/soniccd/D2.asm"
		even
SfxCdD3:	include "sfx/soniccd/D3.asm"
		even
SfxCdD4:	include "sfx/soniccd/D4.asm"
		even
SfxCdD5:	include "sfx/soniccd/D5.asm"
		even
SfxCdD6:	include "sfx/soniccd/D6.asm"
		even
SfxCdD7:	include "sfx/soniccd/D7.asm"
		even
SfxCdD9:	include "sfx/soniccd/D9.asm"
		even
SfxCdDA:	include "sfx/soniccd/DA.asm"
		even
SfxCdDB:	include "sfx/soniccd/DB.asm"
		even
SfxCdDC:	include "sfx/soniccd/DC.asm"
		even
SfxCdDD:	include "sfx/soniccd/DD.asm"
		even
SfxCdDE:	include "sfx/soniccd/DE.asm"
		even
SfxCdDF:	include "sfx/soniccd/DF.asm"
		even
; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------
BgmTest:	include "bgm/_tester.asm"
		even
BgmSoccer:	include "bgm/MDSoccer-Title.asm"
		even
BgmSCDTimeTravel:	include "bgm/CD Time Travel.asm"
		even

BgmS1Title:	include "bgm/sonic1/S1-Title.asm"
		even
BgmS1GHZ:	include "bgm/sonic1/S1-GHZ.asm"
		even
BgmS1LZ:	include "bgm/sonic1/S1-LZ.asm"
		even
BgmS1MZ:	include "bgm/sonic1/S1-MZ.asm"
		even
BgmS1SLZ:	include "bgm/sonic1/S1-SLZ.asm"
		even
BgmS1SYZ:	include "bgm/sonic1/S1-SYZ.asm"
		even
BgmS1SBZ:	include "bgm/sonic1/S1-SBZ.asm"
		even
BgmS1FZ:	include "bgm/sonic1/S1-FZ.asm"
		even
BgmS1Boss:	include "bgm/sonic1/S1-Boss.asm"
		even
BgmS1Special:	include "bgm/sonic1/S1-SpecialStage.asm"
		even
BgmS1Invinc:	include "bgm/sonic1/S1-Invincibility.asm"
		even
BgmS1ActClear:	include "bgm/sonic1/S1-ActClear.asm"
		even
BgmS1ExtraLife:	include "bgm/sonic1/S1-ExtraLife.asm"
		even
BgmS1Continue:	include "bgm/sonic1/S1-Continue.asm"
		even
BgmS1Emerald:	include "bgm/sonic1/S1-Emerald.asm"
		even
BgmS1Drowning:	include "bgm/sonic1/S1-Drowning.asm"
		even
BgmS1GameOver:	include "bgm/sonic1/S1-GameOver.asm"
		even
BgmS1Ending:	include "bgm/sonic1/S1-Ending.asm"
		even
BgmS1Credits:	include "bgm/sonic1/S1-Credits.asm"
		even

BgmS2Title:	include "bgm/sonic2/S2-Title.asm"
		even
BgmS2EHZ:	include "bgm/sonic2/S2-EHZ.asm"
		even
BgmS2EHZ2P:	include "bgm/sonic2/S2-EHZ2P.asm"
		even
BgmS2CPZ:	include "bgm/sonic2/S2-CPZ.asm"
		even
BgmS2ARZ:	include "bgm/sonic2/S2-ARZ.asm"
		even
BgmS2CNZ:	include "bgm/sonic2/S2-CNZ.asm"
		even
BgmS2CNZ2P:	include "bgm/sonic2/S2-CNZ2P.asm"
		even
BgmS2HTZ:	include "bgm/sonic2/S2-HTZ.asm"
		even
BgmS2MCZ:	include "bgm/sonic2/S2-MCZ.asm"
		even
BgmS2MCZ2P:	include "bgm/sonic2/S2-MCZ2P.asm"
		even
BgmS2OOZ:	include "bgm/sonic2/S2-OOZ.asm"
		even
BgmS2MTZ:	include "bgm/sonic2/S2-MTZ.asm"
		even
BgmS2SCZ:	include "bgm/sonic2/S2-SCZ.asm"
		even
BgmS2WFZ:	include "bgm/sonic2/S2-WFZ.asm"
		even
BgmS2DEZ:	include "bgm/sonic2/S2-DEZ.asm"
		even
BgmS2HPZ:	include "bgm/sonic2/S2-HPZ.asm"
		even
BgmS2Special:	include "bgm/sonic2/S2-SpecialStage.asm"
		even
BgmS2Boss:	include "bgm/sonic2/S2-Boss.asm"
		even
BgmS2FinalBoss:	include "bgm/sonic2/S2-FinalBoss.asm"
		even
BgmS2ActClear:	include "bgm/sonic2/S2-ActClear.asm"
		even
BgmS2Invinc:	include "bgm/sonic2/S2-Invincibility.asm"
		even
BgmS2Super:	include "bgm/sonic2/S2-SuperSonic.asm"
		even
BgmS2ExtraLife:	include "bgm/sonic2/S2-ExtraLife.asm"
		even
BgmS2GameOver:	include "bgm/sonic2/S2-GameOver.asm"
		even
BgmS2Options:	include "bgm/sonic2/S2-Options.asm"
		even
BgmS2Menu2P:	include "bgm/sonic2/S2-2PMenu.asm"
		even
BgmS2Ending:	include "bgm/sonic2/S2-Ending.asm"
		even
BgmS2Credits:	include "bgm/sonic2/S2-Credits.asm"
		even

BgmS2BTitle:	include "bgm/sonic2-wai/Title screen.asm"
		even
BgmS2BGHZ:	include "bgm/sonic2-wai/GHZ.asm"
		even
BgmS2BCPZ:	include "bgm/sonic2-wai/CPZ.asm"
		even
BgmS2BNGHZ:	include "bgm/sonic2-wai/NGHZ.asm"
		even
BgmS2BCNZ:	include "bgm/sonic2-wai/CNZ.asm"
		even
BgmS2BHTZ:	include "bgm/sonic2-wai/HTZ.asm"
		even
BgmS2BDHZ:	include "bgm/sonic2-wai/DHZ.asm"
		even
BgmS2BOOZ:	include "bgm/sonic2-wai/OOZ.asm"
		even
BgmS2BMTZ:	include "bgm/sonic2-wai/MTZ.asm"
		even
BgmS2BSSZ:	include "bgm/sonic2-wai/SSZ.asm"
		even
BgmS2BRWZ:	include "bgm/sonic2-wai/RWZ.asm"
		even
BgmS2BDEZ:	include "bgm/sonic2-wai/DEZ.asm"
		even
BgmS2BBOZ:	include "bgm/sonic2-wai/BOZ.asm"
		even
BgmS2BHPZ:	include "bgm/sonic2-wai/HPZ.asm"
		even
BgmS2BLevelSelect:	include "bgm/sonic2-wai/Level select.asm"
		even
BgmS2BSpecial:	include "bgm/sonic2-wai/Special Stage.asm"
		even
BgmS2BBoss:	include "bgm/sonic2-wai/Boss.asm"
		even
BgmS2BFinalBoss:	include "bgm/sonic2-wai/Final boss.asm"
		even
BgmS2BWFZ:	include "bgm/sonic2-wai/Unused 1.asm"
		even
BgmS2BMenu2P:	include "bgm/sonic2-wai/Unused 2.asm"
		even

BgmS3Complete:	include "bgm/sonic3/Game Complete (Sonic 3).asm"	; shares sequence data with s3title
		even
BgmSKComplete:	include "bgm/sonic3/Game Complete (Sonic & Knuckles).asm"
		even
BgmS3Title:	include "bgm/sonic3/Title (Sonic 3).asm"
		even
BgmSKitle:	include "bgm/sonic3/Title (Sonic & Knuckles).asm"
		even
BgmS3AIZ1:	include "bgm/sonic3/AIZ1.asm"
		even
BgmS3AIZ2:	include "bgm/sonic3/AIZ2.asm"
		even
BgmS3HCZ1:	include "bgm/sonic3/HCZ1.asm"
		even
BgmS3HCZ2:	include "bgm/sonic3/HCZ2.asm"
		even
BgmS3MGZ1:	include "bgm/sonic3/MGZ1.asm"
		even
BgmS3MZZ2:	include "bgm/sonic3/MGZ2.asm"
		even
BgmS3CNZ1:	include "bgm/sonic3/CNZ1.asm"
		even
BgmS3CNZ2:	include "bgm/sonic3/CNZ2.asm"
		even
BgmS3ICZ2:	include "bgm/sonic3/ICZ2.asm"	; shares FM instruments with ICZ1
		even
BgmS3ICZ1:	include "bgm/sonic3/ICZ1.asm"
		even
BgmS3LBZ1:	include "bgm/sonic3/LBZ1.asm"
		even
BgmS3LBZ2:	include "bgm/sonic3/LBZ2.asm"
		even
BgmSKMHZ1:	include "bgm/sonic3/MHZ1.asm"
		even
BgmSKMHZ2:	include "bgm/sonic3/MHZ2.asm"
		even
BgmSKFBZ1:	include "bgm/sonic3/FBZ1 (Sonic & Knuckles).asm"
		even
BgmSKFBZ2:	include "bgm/sonic3/FBZ2.asm"
		even
BgmSKSOZ1:	include "bgm/sonic3/SOZ1.asm"
		even
BgmSKSOZ2:	include "bgm/sonic3/SOZ2.asm"
		even
BgmSKLRZ1:	include "bgm/sonic3/LRZ1.asm"
		even
BgmSKLRZ2:	include "bgm/sonic3/LRZ2.asm"
		even
BgmSKSSZ:	include "bgm/sonic3/SSZ (Sonic & Knuckles).asm"
		even
BgmSKDEZ1:	include "bgm/sonic3/DEZ1.asm"
		even
BgmSKDEZ2:	include "bgm/sonic3/DEZ2.asm"
		even
BgmSKDDZ:	include "bgm/sonic3/DDZ.asm"
		even
BgmS3Gumball:	include "bgm/sonic3/Gum Ball Machine.asm"
		even
BgmSKPachinko:	include "bgm/sonic3/Pachinko.asm"
		even
BgmSKSlots:	include "bgm/sonic3/Slots.asm"
		even
BgmS3Special:	include "bgm/sonic3/Special Stage.asm"
		even
BgmS3MiniBoss:	include "bgm/sonic3/Miniboss (Sonic 3).asm"
		even
BgmSKMiniBoss:	include "bgm/sonic3/Miniboss (Sonic & Knuckles).asm"
		even
BgmS3ZoneBoss:	include "bgm/sonic3/Zone boss.asm"
		even
BgmS3FinalBoss:	include "bgm/sonic3/Final boss.asm"
		even
BgmS3Knuckles:	include "bgm/sonic3/Knuckles (Sonic 3).asm"
		even
BgmSKKnuckles:	include "bgm/sonic3/Knuckles (Sonic & Knuckles).asm"
		even
BgmS3Invinc:	include "bgm/sonic3/Invincible (Sonic 3).asm"
		even
BgmSKInvinc:	include "bgm/sonic3/Invincible (Sonic & Knuckles).asm"
		even
BgmS3ExtraLife:	include "bgm/sonic3/1UP (Sonic 3).asm"
		even
BgmSKExtraLife:	include "bgm/sonic3/1UP (Sonic & Knuckles).asm"
		even
BgmS3ActClear:	include "bgm/sonic3/Level Outro.asm"
		even
BgmS3Drowning:	include "bgm/sonic3/Countdown.asm"
		even
BgmS3GameOver:	include "bgm/sonic3/Game Over.asm"
		even
BgmS3Continue:	include "bgm/sonic3/Continue (Sonic & Knuckles).asm"
		even
BgmS3CompMenu:	include "bgm/sonic3/Competition Menu.asm"
		even
BgmS3ALZ:	include "bgm/sonic3/Azure Lake.asm"
		even
BgmS3BPZ:	include "bgm/sonic3/Balloon Park.asm"
		even
BgmS3CGZ:	include "bgm/sonic3/Chrome Gadget.asm"
		even
BgmS3DPZ:	include "bgm/sonic3/Desert Palace.asm"
		even
BgmS3EMZ:	include "bgm/sonic3/Endless Mine.asm"
		even
BgmS3Credits:	include "bgm/sonic3/Credits (Sonic 3).asm"
		even
BgmSKCredits:	include "bgm/sonic3/Credits (Sonic & Knuckles).asm"
		even

BgmS3BCNZ1:	include "bgm/sonic3-1103/CNZ1.asm"
		even
BgmS3BCNZ2:	include "bgm/sonic3-1103/CNZ2.asm"
		even
BgmS3BICZ1:	include "bgm/sonic3-1103/ICZ1.asm"
		even
BgmS3BICZ2:	include "bgm/sonic3-1103/ICZ2.asm"
		even
BgmS3BLBZ1:	include "bgm/sonic3-1103/LBZ1.asm"
		even
BgmS3BLBZ2:	include "bgm/sonic3-1103/LBZ2.asm"
		even
BgmS3BKnuckles:	include "bgm/sonic3-1103/Knuckles.asm"
		even
BgmS3BCompMenu:	include "bgm/sonic3-1103/Competition Menu.asm"
		even
BgmS3BCredits:	include "bgm/sonic3-1103/Credits.asm"
		even
BgmS3BUnused:	include "bgm/sonic3-1103/Unused Theme.asm"
		even

BgmS3DIntro:	include "bgm/sonic3D/Intro.asm"
		even
BgmS3DMenu:	include "bgm/sonic3D/Menu.asm"
		even
BgmS3DGrGZ1:	include "bgm/sonic3D/GreenGZ1.asm"
		even
BgmS3DGrGZ2:	include "bgm/sonic3D/GreenGZ2.asm"
		even
BgmS3DRRZ1:	include "bgm/sonic3D/RRZ1.asm"
		even
BgmS3DRRZ2:	include "bgm/sonic3D/RRZ2.asm"
		even
BgmS3DSSZ1:	include "bgm/sonic3D/SSZ1.asm"
		even
BgmS3DSSZ2:	include "bgm/sonic3D/SSZ2.asm"
		even
BgmS3DDDZ1:	include "bgm/sonic3D/DDZ1.asm"
		even
BgmS3DDDZ2:	include "bgm/sonic3D/DDZ2.asm"
		even
BgmS3VVDZ1:	include "bgm/sonic3D/VVZ1.asm"
		even
BgmS3VVDZ2:	include "bgm/sonic3D/VVZ2.asm"
		even
BgmS3DGeGZ1:	include "bgm/sonic3D/GeneGZ1.asm"
		even
BgmS3DGeGZ2:	include "bgm/sonic3D/GeneGZ2.asm"
		even
BgmS3PPDZ1:	include "bgm/sonic3D/PPZ1.asm"
		even
BgmS3PPDZ2:	include "bgm/sonic3D/PPZ2.asm"
		even
BgmS3DSpecial:	include "bgm/sonic3D/Special Stage.asm"
		even
BgmS3DInvinc:	include "bgm/sonic3D/Invincible.asm"
		even
BgmS3DBoss1:	include "bgm/sonic3D/Boss1.asm"
		even
BgmS3DBoss2:	include "bgm/sonic3D/Boss2.asm"
		even
BgmS3DBoss3:	include "bgm/sonic3D/Unused boss theme.asm"
		even
BgmS3DFinalBoss:	include "bgm/sonic3D/The Final Fight.asm"
		even
BgmS3DEnding:	include "bgm/sonic3D/Ending.asm"
		even
BgmS3DCredits:	include "bgm/sonic3D/Credits.asm"
		even
; ---------------------------------------------------------------
; PCM data
; ---------------------------------------------------------------
	pcminc START
	pcminc Kick,			"pcm/sonic2/Kick.dpcm"
	pcminc Snare,			"pcm/sonic2/Snare.pcm"
	pcminc Timpani,			"pcm/sonic2/Timpani.dpcm"
	pcminc Clap,			"pcm/sonic2/Clap.dpcm"
	pcminc Tom,			"pcm/sonic2/Tom.pcm"
	pcminc Scratch,			"pcm/sonic2/Scratch.dpcm"
	pcminc Bongo,			"pcm/sonic2/Bongo.dpcm"

	pcminc SnareS3,			"pcm/sonic3/SnareS3.dpcm"
	pcminc TomS3,			"pcm/sonic3/TomS3.dpcm"
	pcminc KickS3,			"pcm/sonic3/KickS3.dpcm"
	pcminc MuffledSnare,		"pcm/sonic3/MuffledSnare.dpcm"
	pcminc CrashCymbalS3,		"pcm/sonic3/CrashCymbalS3.dpcm"
	pcminc RideCymbal,		"pcm/sonic3/RideCymbal.dpcm"
	pcminc MetalHit,		"pcm/sonic3/MetalHit.dpcm"
	pcminc HighMetalHit,		"pcm/sonic3/HighMetalHit.dpcm"
	pcminc HigherMetalHit,		"pcm/sonic3/HigherMetalHit.dpcm"
	pcminc ClapS3,			"pcm/sonic3/ClapS3.dpcm"
	pcminc ElectricTomS3,		"pcm/sonic3/ElectricTomS3.dpcm"
	pcminc PitchSnareS3,		"pcm/sonic3/PitchSnareS3.dpcm"
	pcminc TimpaniS3,		"pcm/sonic3/TimpaniS3.dpcm"
	pcminc QuickLooseSnare,		"pcm/sonic3/QuickLooseSnare.dpcm"
	pcminc Click,			"pcm/sonic3/Click.dpcm"
	pcminc PowerKick,		"pcm/sonic3/PowerKick.dpcm"
	pcminc QuickGlassCrash,		"pcm/sonic3/QuickGlassCrash.dpcm"
	pcminc GlassCrashSnare,		"pcm/sonic3/GlassCrashSnare.dpcm"
	pcminc GlassCrash,		"pcm/sonic3/GlassCrash.dpcm"
	pcminc GlassCrashKick,		"pcm/sonic3/GlassCrashKick.dpcm"
	pcminc QuietGlassCrash,		"pcm/sonic3/QuietGlassCrash.dpcm"
	pcminc OddSnareKick,		"pcm/sonic3/OddSnareKick.dpcm"
	pcminc KickExtraBass,		"pcm/sonic3/KickExtraBass.dpcm"
	pcminc ComeOn,			"pcm/sonic3/ComeOn.dpcm"
	pcminc DanceSnare,		"pcm/sonic3/DanceSnare.dpcm"
	pcminc LooseKick,		"pcm/sonic3/LooseKick.dpcm"
	pcminc ModLooseKick,		"pcm/sonic3/ModLooseKick.dpcm"
	pcminc Woo,			"pcm/sonic3/Woo.dpcm"
	pcminc Go,			"pcm/sonic3/Go.dpcm"
	pcminc SnareGo,			"pcm/sonic3/SnareGo.dpcm"
	pcminc PowerTom,		"pcm/sonic3/PowerTom.dpcm"
	pcminc WoodBlock,		"pcm/sonic3/WoodBlock.dpcm"
	pcminc HitDrum,			"pcm/sonic3/HitDrum.dpcm"
	pcminc MetalCrashHit,		"pcm/sonic3/MetalCrashHit.dpcm"
	pcminc EchoedClapHitSK,		"pcm/sonic3/EchoedClapHitSK.dpcm"
	pcminc EchoedClapHitS3,		"pcm/sonic3/EchoedClapHitS3.dpcm"
	pcminc PowerKickHit,		"pcm/sonic3/PowerKickHit.dpcm"
	pcminc HipHopHitPowerKick,	"pcm/sonic3/HipHopHitPowerKick.dpcm"
	pcminc BassHey,			"pcm/sonic3/BassHey.dpcm"
	pcminc DanceStyleKick,		"pcm/sonic3/DanceStyleKick.dpcm"
	pcminc HipHopHitKick,		"pcm/sonic3/HipHopHitKick.dpcm"
	pcminc ReverseFadingWind,	"pcm/sonic3/ReverseFadingWind.dpcm"
	pcminc ScratchS3,		"pcm/sonic3/ScratchS3.dpcm"
	pcminc LooseSnareNoise,		"pcm/sonic3/LooseSnareNoise.dpcm"
	pcminc PowerKick2,		"pcm/sonic3/PowerKick2.dpcm"
	pcminc CrashingNoiseWoo,	"pcm/sonic3/CrashingNoiseWoo.dpcm"
	pcminc QuickHit,		"pcm/sonic3/QuickHit.dpcm"
	pcminc KickHey,			"pcm/sonic3/KickHey.dpcm"

	pcminc IntroKick,		"pcm/sonic3d/IntroKick.dpcm"
	pcminc FinalFightMetalCrash,	"pcm/sonic3d/FinalFightMetalCrash.dpcm"

	pcminc SegaPCM,			"pcm/Sega.pcm"
;	pcminc Rizzmas,			"pcm/rizzmas.wav"
	pcminc END
; ---------------------------------------------------------------
	even