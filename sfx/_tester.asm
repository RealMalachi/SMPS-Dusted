TestSfx_Header:
	smpsHeaderStartSong	"DUSTED",1
	smpsHeaderVoice		TestSfx_Voices
	smpsHeaderVolEnv	TestSfx_VolEnv
	smpsHeaderModEnv	TestSfx_ModEnv
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$01

	smpsHeaderSFXChannel	cFM5, TestSfx_FM5, $00, $00

TestSfx_FM5:
; FM instrument SSG test
	smpsFMvoice	$01
	smpsCall	TestSfx_FM5_Call
	smpsFMvoice	$00
; FM volenv test
	smpsFMVolEnv	$01,$0F
	smpsCall	TestSfx_FM5_Call
	smpsFMVolEnv	$00,$0F
; FM modenv tests
	smpsModChange	$01
	smpsCall	TestSfx_FM5_Call
	smpsModChange	$02
	smpsCall	TestSfx_FM5_Call
	smpsModChange	$00
; FM hold note test
	smpsHoldNotes
	smpsCall	TestSfx_FM5_Call
	smpsReleaseNotes
; various errors test
; rest-time-time causes problems
	dc.b	nC0,$1E,nRst,$07,$07,$1D	; only works on smps-68K
	dc.b	nC0,$1E,nRst,$07,nRst,nRst,$1D	; works on all
; second rest will play previous note on smps-z80
	dc.b	nC0,$1E,nRst,nRst
; alright we're done
	smpsStop

TestSfx_FM5_Call:
	dc.b	nC0,$40
TestSfx_FM5_Loop:
	dc.b	nC0,$20
	smpsConditionalJump	$00,TestSfx_FM5_LoopEnd	; this will skip the fifth loop
	smpsLoop	$00,$05,TestSfx_FM5_Loop
	dc.b	nC4,$20					; this won't play
TestSfx_FM5_LoopEnd:
	smpsReturn

TestSfx_Voices:
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
	smpsVcUnusedBits	$00
	smpsVcDetune		$04, $07, $07, $03
	smpsVcCoarseFreq	$09, $07, $02, $07
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $07, $0A, $07
	smpsVcDecayRate2	$0B, $00, $0B, $00
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $23, $00, $23

	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
	smpsVcUnusedBits	$00
	smpsVcSsgEg		$08, $08, $08, $08
	smpsVcDetune		$04, $07, $07, $03
	smpsVcCoarseFreq	$09, $07, $02, $07
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$0D, $07, $0A, $07
	smpsVcDecayRate2	$0B, $00, $0B, $00
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $23, $00, $23

TestSfx_VolEnv:
	smpsEnvTable START
	smpsEnvTable TestSfx_VolEnv_01
	smpsEnvTable END
TestSfx_VolEnv_01:	smpsVolEnv $00,$00,$00,$00,$08,$10,$18,$20,HOLD

TestSfx_ModEnv:
	smpsEnvTable START
	smpsEnvTable TestSfx_ModEnv_01
	smpsEnvTable TestSfx_ModEnv_02
	smpsEnvTable END
TestSfx_ModEnv_01:	smpsModEnv 0,1,2,3,4,5,6,7,6,5,4,3,2,1,RESET
TestSfx_ModEnv_02:	smpsModEnv 0,1,2,3,4,5,6,7,8,9,10,11,12,13,REST
