SMPS_InitDriver			= *+00
SMPS_RunDriver			= *+04
SMPS_QueueSound			= *+08
SMPS_UpdateFIFO			= *+12
SMPS_ReadComm			= *+16
SMPS_WriteComm			= *+20
SMPS_PauseDriver		= *+24
SMPS_ResumeDriver		= *+28
SMPS_SetupPianoRoll		= *+32
SMPS_SetDriverDataPointer	= *+36
SMPS_Signature			= *+64	; ASCII with zero-terminator
	binclude "Sound/smps-drv.bin"
SMPS_DriverData:
	binclude "Sound/smps-snd.bin"
	even
