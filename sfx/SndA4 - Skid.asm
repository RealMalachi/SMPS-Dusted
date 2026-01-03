SndA4_Skid_Header:
	smpsHeaderStartSong 3
	smpsHeaderVoice     SndA4_Skid_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01
	smpsHeaderSFXChannel cPSG2, SndA4_Skid_PSG2, $00, $00

SndA4_Skid_PSG2:
	smpsPSGvoice        $00
	dc.b	nBb3, $01, nAb3, nBb3, nAb3, nRst, $02
SndA4_Skid_Loop01:
	dc.b	nBb3, $01, nAb3
	smpsLoop            $00, $0B, SndA4_Skid_Loop01
	smpsStop

;SndA4_Skid_PSG2:
;	smpsPSGvoice        $00
;	dc.b	nBb3, $01, nRst, nBb3, nRst, $03
;SndA4_Skid_Loop01:
;	dc.b	nBb3, $01, nRst
;	smpsLoop            $00, $0B, SndA4_Skid_Loop01
;	smpsStop
;SndA4_Skid_PSG3:
;	smpsPSGvoice        $00
;	dc.b	nRst, $01, nAb3, nRst, nAb3, nRst, $03
;SndA4_Skid_Loop00:
;	dc.b	nAb3, $01, nRst, $01
;	smpsLoop            $00, $0B, SndA4_Skid_Loop00
;	smpsStop

; Song seems to not use any FM voices
SndA4_Skid_Voices:
