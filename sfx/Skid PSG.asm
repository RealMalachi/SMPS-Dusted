Snd_SkidPSG_Header:
	smpsHeaderStartSong	3
	smpsHeaderVoiceNull
	smpsHeaderTempoSFX	$01
	smpsHeaderChanSFX	$01
	smpsHeaderSFXChannel	cPSG2, Snd_SkidPSG_PSG2, $00, $00

Snd_SkidPSG_PSG2:
	smpsPSGvoice        $00
	dc.b	nBb3, $01, nAb3, nBb3, nAb3, nRst, $02
Snd_SkidPSG_Loop01:
	dc.b	nBb3, $01, nAb3
	smpsLoop            $00, $0B, Snd_SkidPSG_Loop01
	smpsStop
