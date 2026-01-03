TestSfx_Header:
	smpsHeaderStartSong	2
	smpsHeaderVoice		TestSfx_Voices
	smpsHeaderVolEnv	TestSfx_VolEnv
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$01

	smpsHeaderSFXChannel	cFM5, TestSfx_FM5, $00, $00

TestSfx_FM5:
	smpsFMvoice	$00
; FM volenv test
	smpsFMVolEnv	$01,$0F
TestSfx_FM5_Loop:
	dc.b	nC0,$20
	smpsLoop	$00,$04,TestSfx_FM5_Loop
	smpsFMVolEnv	$00,$0F
; rest-time-time causes problems
	dc.b	nC0,$1E,nRst,$07,$07,$1D	; only works on smps-68K
	dc.b	nC0,$1E,nRst,$07,nRst,nRst,$1D	; works on all
; second rest will play previous note on smps-z80
	dc.b	nC0,$1E,nRst,nRst

	smpsStop

TestSfx_Voices:
	smpsVcAlgorithm		$06
	smpsVcFeedback		$05
	smpsVcUnusedBits	$00
	smpsVcDetune		$01, $01, $01, $01
	smpsVcCoarseFreq	$03, $03, $03, $03
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$14, $13, $13, $13
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$12, $10, $10, $12
	smpsVcDecayRate2	$12, $12, $12, $17
	smpsVcDecayLevel	$03, $0A, $01, $04
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $00, $00, $18

TestSfx_VolEnv:
	dc.w .env-TestSfx_VolEnv
.env:	dc.b $00,$00,$00,$00,$01,$02,$03,$04,$81
