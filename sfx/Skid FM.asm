Snd_SkidFM_Header:
	smpsHeaderStartSong	3
	smpsHeaderVoice		Snd_SkidFM_Voices
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$01
	smpsHeaderSFXChannel	cFM5, Snd_SkidFM_FM1, $00, $10
; nBb3-10=nCs3
; nAb3-09=nC3
Snd_SkidFM_FM1:
	smpsSetvoice	$00
;	dc.b	nBb3-10, $01, nAb3-9, nBb3-10, nAb3-9, nRst, $02
Snd_SkidFM_Loop1:
	dc.b	nBb3-10, $01, nAb3-9
	smpsLoop	$00, $0B, Snd_SkidFM_Loop1
	smpsStop

Snd_SkidFM_Voices:
;	Voice $00
;	$07
;	$07, $07, $08, $08,	$1F, $1F, $1F, $1F,	$00, $00, $00, $00
;	$00, $00, $00, $00,	$0F, $0F, $0F, $0F,	$80, $80, $80, $80
	smpsVcAlgorithm		$07
	smpsVcFeedback		$00
	smpsVcUnusedBits	$00
	smpsVcDetune		$00, $00, $00, $00
	smpsVcCoarseFreq	$08, $08, $07, $07
	smpsVcRateScale		$00, $00, $00, $00
	smpsVcAttackRate	$1F, $1F, $1F, $1F
	smpsVcAmpMod		$00, $00, $00, $00
	smpsVcDecayRate1	$00, $00, $00, $00
	smpsVcDecayLevel	$00, $00, $00, $00
	smpsVcDecayRate2	$00, $00, $00, $00
	smpsVcReleaseRate	$0F, $0F, $0F, $0F
	smpsVcTotalLevel	$80, $80, $80, $80
