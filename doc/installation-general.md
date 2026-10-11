The Comprehensive General SMPS-Dusted Installation Guide (TCGSDIG)

# Step 1
Run `build.bat`, this builds the driver code, driver sound data, and a test rom

## Step 1.5
`build.bat` can take an additional parameter to only do one thing

| parameter | description |
| - | - |
| all | build all (same as no parameter) |
| drv | build driver code |
| snd | build driver sound data |
| rom | build test rom |
| help, -h, --help | print help for usage of the script |
| clean | cleans the directory |

# Step 2
Include the generated definition files, ideally before allocating the games ram
```
	include "smps-def.asm"
	include "smps-ids.asm"
```

# Step 3
Allocate ram for the sound driver

`smps-def.asm` contains the constant `smpsramsize`, this specifies how much ram the driver needs to operate

The rams label name doesn't matter, all that matters is that you're using the same ram location for every API call
```
v_soundram:			rs.b smpsramsize
```

# Step 4
Include the binary driver and sound data in the rom:
```
SMPS_DriverCode:	incbin "smps-drv.bin"
SMPS_InitDriver		equ SMPS_DriverCode+SMPS_Offset_InitDriver
SMPS_RunDriver		equ SMPS_DriverCode+SMPS_Offset_RunDriver
SMPS_QueueSound		equ SMPS_DriverCode+SMPS_Offset_QueueSound
SMPS_UpdateFIFO		equ SMPS_DriverCode+SMPS_Offset_UpdateFIFO
SMPS_ReadComm		equ SMPS_DriverCode+SMPS_Offset_ReadComm
SMPS_WriteComm		equ SMPS_DriverCode+SMPS_Offset_WriteComm
SMPS_GuardDriver	equ SMPS_DriverCode+SMPS_Offset_GuardDriver
SMPS_UnguardDriver	equ SMPS_DriverCode+SMPS_Offset_UnguardDriver
SMPS_SetupPianoRoll	equ SMPS_DriverCode+SMPS_Offset_SetupPianoRoll
SMPS_PlayCDDA		equ SMPS_DriverCode+SMPS_Offset_PlayCDDA
SMPS_PauseDriver	equ SMPS_DriverCode+SMPS_Offset_PauseDriver
SMPS_ResumeDriver	equ SMPS_DriverCode+SMPS_Offset_ResumeDriver
SMPS_SetBgmTempo	equ SMPS_DriverCode+SMPS_Offset_SetBgmTempo
SMPS_SetBgmSpeed	equ SMPS_DriverCode+SMPS_Offset_SetBgmSpeed
SMPS_Signature		equ SMPS_DriverCode+SMPS_Offset_Signature
SMPS_DriverData:	incbin "smps-snd.bin"
```

# Step 4.5
If your rom building process supports separate debug builds via an assembler flag, consider using it to include the debug driver:
*cough cough vladikcomper error handler*
```
	if def(__debug__)
	include "smps-def-debug.asm"
	else
	include "smps-def.asm"
	endif
...
	if def(__debug__)
	incbin "smps-drv-debug.bin"
	else
	incbin "smps-drv.bin"
	endif
```

# Step 5
Refer to `api.md` or `src-68k/main.asm` for using these function calls

# Step 6
Uhh, test it.
