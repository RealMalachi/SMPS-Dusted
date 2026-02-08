Sound_42_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     Sound_42_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Sound_42_PSG3,	$00, $00

; PSG3 Data
Sound_42_PSG3:
	smpsPSGform         $E7
;	smpsEnvVolPsg $01,$00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$03,$04
	smpsPSGvoice        sTone_17
; 35C
	smpsDetune          $06
	dc.b	nC1, $04
	smpsDetune          $00
	smpsModSet          $02, $01, $06, $07
	dc.b	nAb6, $10
	smpsStop

; Song seems to not use any FM voices
Sound_42_Voices:
