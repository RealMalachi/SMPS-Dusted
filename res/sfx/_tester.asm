TestSfx_Header:
	smpsHeaderStartSong	$F0E50000,1
	smpsHeaderVoice		TestSfx_Voices
	smpsHeaderVolEnv	TestSfx_VolEnv
	smpsHeaderModEnv	TestSfx_ModEnv
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$02

	smpsHeaderSFXChannel	cFM5,  TestSfx_FM5,  $00, $00
	smpsHeaderSFXChannel	cPSG2, TestSfx_PSG2, $00, $00

TestSfx_FM5:
	smpsFMvoice	$00
	smpsCall	TestSfx_ParityTest
; panning animation test
	smpsPanAni 2,1,pEnv_00,"UPD-REPEAT"
	smpsCall	TestSfx_FM5_Call
	smpsPanAni 2,1,pEnv_00,"TICK-REPEAT"
	smpsCall	TestSfx_FM5_Call
	smpsPanAni 2,1,pEnv_00,"TICK-HOLD"
	smpsCall	TestSfx_FM5_Call
	smpsPanAni "OFF"
; FM instrument SSG-EG test
	smpsFMvoice	$01
	smpsCall	TestSfx_FM5_Call
;	smpsFMvoice	$00
; FM instrument LFO test
	smpsFMvoice	$02
	smpsSetLFORate	$00
	smpsCall	TestSfx_FM5_Call
	smpsSetLFORate	$0C
	smpsCall	TestSfx_FM5_Call
	smpsFMvoice	$00
; FM operators test
	smpsFmKeyOnMask	%1010
	smpsCall	TestSfx_FM5_Call
	smpsFmKeyOnMask	%0101
	smpsCall	TestSfx_FM5_Call
	smpsFmKeyOnMask	%1111
; alright we're done
	smpsStop

TestSfx_PSG2:
	smpsSetTranspose	$0C
	smpsCall	TestSfx_ParityTest
	smpsStop

TestSfx_ParityTest:
; errors test
; default frequency, mute for fm and max for psg
	dc.b	$1E
; rest-time-time causes problems
	dc.b	nC0,$1E,nRst,$07,$07,$1D
; note-time-rest-rest does too apparently
	dc.b	nC0,$1E,nRst,nRst
; error tests done

; volenv test
	smpsFMVolEnv	$01,$0F
	smpsCall	TestSfx_FM5_Call
	smpsFMVolEnv	$00,$0F
; modenv tests
	smpsModChange	$01
	smpsCall	TestSfx_FM5_Call
	smpsModChange	$02
	smpsCall	TestSfx_FM5_Call
	smpsModChange	$00
; hold note test
	smpsHoldNotes
	smpsCall	TestSfx_FM5_Call
	smpsReleaseNotes
; portamento test
	dc.b	nC0,$01
	smpsPortamento	$04
	dc.b	nCs0,$1E,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0
	dc.b	nA0,nAb0,nG0,nFs0,nF0,nE0,nEb0,nD0,nCs0,nC0
	smpsPortamento	$C0
	dc.b	nC0,$20,nC1,nC2,nC3,nC4
	smpsPortamento	$40
	dc.b	nC1,$02,nC2,nC3,nC2,nC1,nC2,nC1,$7F
	smpsPortamento	$00
; parity test done
	smpsReturn

TestSfx_FM5_Call:
	dc.b	nC0,$40
TestSfx_FM5_Loop:
	dc.b	nC0,$20
	smpsLoopExit	$00,TestSfx_FM5_LoopExit	; this will skip the fifth loop
	smpsLoop	$00,$05,TestSfx_FM5_Loop
	dc.b	nC4,$20					; this won't play
TestSfx_FM5_LoopExit:
	smpsReturn

TestSfx_Voices:
	; Normal
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
	; SSG-EG
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
	; LFO
	smpsVcAlgorithm		$04
	smpsVcFeedback		$00
	smpsVcUnusedBits	$00
	smpsVcAmsPms		$03, $07
	smpsVcDetune		$04, $07, $07, $03
	smpsVcCoarseFreq	$09, $07, $02, $07
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $01, $01, $01
	smpsVcDecayRate1	$0D, $07, $0A, $07
	smpsVcDecayRate2	$0B, $00, $0B, $00
	smpsVcDecayLevel	$00, $01, $00, $01
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $23, $00, $23

TestSfx_VolEnv:
	smpsEnvTable START,1
	smpsEnvTable TestSfx_VolEnv_01
	smpsEnvTable END,$100
TestSfx_VolEnv_01:	smpsEnvVol $00,$00,$00,$00,$08,$10,$18,$20,HOLD

TestSfx_ModEnv:
	smpsEnvTable START,1
	smpsEnvTable TestSfx_ModEnv_01
	smpsEnvTable TestSfx_ModEnv_02
	smpsEnvTable END,$40
TestSfx_ModEnv_01:	smpsEnvMod 0,1,2,3,4,5,6,7,6,5,4,3,2,1,REPEAT
TestSfx_ModEnv_02:	smpsEnvMod 0,1,2,3,4,5,6,7,8,9,10,11,12,13,REST
