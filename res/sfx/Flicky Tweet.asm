Flicky_Header:
	smpsHeaderStartSong	2
	smpsHeaderVoice		Flicky_Voices
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$01

	smpsHeaderSFXChannel	cFM4, Flicky_FM5, $00, $0D

; FM5 Data
Flicky_FM5:
	smpsSetvoice	$00
	dc.b	nEb6, $01, smpsNoAttack, nE6, smpsNoAttack, nF6, smpsNoAttack, nFs6
	dc.b	nC6, smpsNoAttack
	smpsAlterNote	$32
	dc.b	nC6, smpsNoAttack
	smpsAlterNote	$00
	dc.b	nCs6, smpsNoAttack, nD6
	smpsStop

Flicky_Voices:
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
