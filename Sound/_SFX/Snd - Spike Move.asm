SndB6_Spikes_Move_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     SndB6_Spikes_Move_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, SndB6_Spikes_Move_PSG3,	$00, $00

; PSG3 Data
SndB6_Spikes_Move_PSG3:
; 016 016 006 3F6(FFF6) 3E6(FFE6) 3D6(FFD6) 3D6(FFD6)
	smpsModSet          $01, $01, $F0, $08
	smpsPSGform         $E7
	dc.b	nE5, $07
; 80
	smpsModOff
	smpsDetune          $01
SndB6_Spikes_Move_Loop00:
	dc.b	nA2, $01
	smpsPSGAlterVol     $01
	smpsLoop            $00, $0C, SndB6_Spikes_Move_Loop00
	smpsStop

; Song seems to not use any FM voices
SndB6_Spikes_Move_Voices:
