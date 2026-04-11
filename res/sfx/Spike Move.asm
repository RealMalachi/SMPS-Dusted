Snd_SpikeMove_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_SpikeMove_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, Snd_SpikeMove_PSG3, $00, $00

; PSG3 Data
Snd_SpikeMove_PSG3:
; 016 016 006 3F6(FFF6) 3E6(FFE6) 3D6(FFD6) 3D6(FFD6)
	smpsModSet          $01, $01, $F0, $08
	smpsPSGform         $E7
	dc.b	nE5, $07
; 80
	smpsModOff
	smpsDetune          $01
Snd_SpikeMove_Loop00:
	dc.b	nA2, $01
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0C, Snd_SpikeMove_Loop00
	smpsStop


; Song seems to not use any FM voices
Snd_SpikeMove_Voices:
