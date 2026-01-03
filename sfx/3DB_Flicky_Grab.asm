FlickyGrab_Header:
	smpsHeaderStartSong 2
	smpsHeaderVoice     FlickyGrab_Voices	; 2
	smpsHeaderTempoSFX  $01			; 1
	smpsHeaderChanSFX   $02			; 1

	smpsHeaderSFXChannel cFM4, FlickyGrab_FM4, $00, $05	; 6
	smpsHeaderSFXChannel cFM5, FlickyGrab_FM5, $00, $08	; 6
						; 14
; FM4 Data
FlickyGrab_FM4:
	smpsSetvoice        $00 ; 2
	dc.b	smpsNoAttack, nRst, $01, nG5, $06, nF5, nE5, nC6, $0C ; 
	smpsStop		; 1
				; 2+9+1=12
; FM5 Data
FlickyGrab_FM5:
	smpsSetvoice        $00
	dc.b	smpsNoAttack, nRst, $01, nE5, $06, nD5, nC5, nG6, $0C
	smpsStop		; same story
						; 14+(12*2)
FlickyGrab_Voices:
;	Voice $00
;	$01
;	$04, $01, $02, $01, 	$1E, $10, $10, $10, 	$0C, $05, $03, $11
;	$00, $00, $09, $08, 	$2F, $2F, $1F, $FF, 	$18, $10, $2D, $00
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $02, $01, $04
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $10, $10, $10, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $11, $03, $05, $0C
	smpsVcDecayRate2    $08, $09, $00, $00
	smpsVcDecayLevel    $0F, $01, $02, $02
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $2D, $10, $18