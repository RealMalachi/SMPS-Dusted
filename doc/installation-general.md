The Comprehensive General SMPS-Dusted Installation Guide (TCGSDIG)

# Step 1
Run `build-drv.bat`, this builds two binary blobs for the sound driver, one of which used for debugging
Run `build-snd.bat`, this builds the sound data used by the driver and a definitions file containing all the IDs

# Step 2
Include the generated `smps-ids.asm` file before allocating ram

# Step 3
Allocate ram for the sound driver
The included definitions file contains the constant `smpsramsize`, this specifies exactly how much ram the driver needs to operate
```
; the label name doesn't matter, all that matters is that you're using the same ram location for every API call
v_soundram:			rs.b smpsramsize
```

# Step 4
Include the binary driver and sound data in the rom:
```
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
	incbin "smps-drv.bin"
SMPS_DriverData:
	incbin "smps-snd.bin"
```

# Step 4.5
If your rom building process supports separate debug builds via an assembler flag, consider using it to include the debug driver:
*cough cough vladikcomper error handler*
```
	if def(__debug__)
	incbin "smps-drv-debug.bin"
	else
	incbin "smps-drv.bin"
	endif
```

# Step 5
Refer to `api.md` for using these function calls

# Step 6
Uhh, test it.
