FlickyGrab_Header:
	smpsHeaderStartSong	2
	smpsHeaderVoice		FlickyGrab_Voices
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$02

	smpsHeaderSFXChannel	cFM4, FlickyGrab_FM4, $00, $05
	smpsHeaderSFXChannel	cFM5, FlickyGrab_FM5, $00, $08
; FM4 Data
FlickyGrab_FM4:
	smpsSetvoice	$00
	dc.b	nG5, $06, nF5, nE5, nC6, $0C
	smpsStop

; FM5 Data
FlickyGrab_FM5:
	smpsSetvoice	$00
	dc.b	nE5, $06, nD5, nC5, nG6, $0C
	smpsStop

FlickyGrab_Voices:
	smpsVcAlgorithm		$01
	smpsVcFeedback		$00
	smpsVcUnusedBits	$00
	smpsVcDetune		$00, $00, $00, $00
	smpsVcCoarseFreq	$01, $02, $01, $04
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$10, $10, $10, $1E
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$11, $03, $05, $0C
	smpsVcDecayRate2	$08, $09, $00, $00
	smpsVcDecayLevel	$0F, $01, $02, $02
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$00, $2D, $10, $18