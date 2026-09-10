@echo off
set PrintText=0

if %PrintText% == 1 (
	set "PrintTextAS=-q -D __smpsPrintMessages=1"
	set "PrintTextSJ="
) else (
	set "PrintTextAS=-q -D __smpsPrintMessages=0"
	set "PrintTextSJ=--nologo --msg=war"
)

if "%~1"=="" goto :all
goto :%~1

:all
:build
	call :drv
	call :snd
	call :rom
	goto :EOF

:done
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo SMPS-Dusted is ready
	if %PrintText% == 1 pause
	goto :EOF

:clean
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Removing output files
	if exist _out rmdir /s /q _out
	if exist smps-def.asm del smps-def.asm
	if exist smps-def-debug.asm del smps-def-debug.asm
	if exist smps-drv.bin del smps-drv.bin
	if exist smps-drv-debug.bin del smps-drv-debug.bin
	
	if exist smps-ids.asm del smps-ids.asm
	if exist smps-snd.bin del smps-snd.bin
	
	if exist smps-testrom.gen del smps-testrom.gen
	goto :EOF

:drv
	if not exist _out mkdir _out
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building MegaPCM1
	tools\sjasmplus\sjasmplus.exe src-z80/mpcm1/main.asm --raw=_out/mpcm1.bin --exp=_out/mpcm1.exp --lst=_out/mpcm1.lst >_out/mpcm1.txt %PrintTextSJ%
	if %PrintText% == 1 echo Compressing MegaPCM1
	tools\zx0\salvador.exe "_out/mpcm1.bin" "_out/mpcm1.zx0"
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building MegaPCM2
	tools\sjasmplus\sjasmplus.exe src-z80/mpcm2/megapcm.asm -DOUTPATH=\"_out/mpcm2.bin\" -DTRACEPATH=\"_out/mpcm2.tracedata.txt\" --exp=_out/mpcm2.exp --sym=_out/mpcm2.sym --lst=_out/mpcm2.lst >_out/mpcm2.txt %PrintTextSJ%
	if %PrintText% == 1 echo Compressing MegaPCM2
	tools\zx0\salvador.exe "_out/mpcm2.bin" "_out/mpcm2.zx0"
	REM // if %PrintText% == 1 echo ============================================
	REM // if %PrintText% == 1 echo Building DualPCM-FlexEd
	REM // tools\sjasmplus\sjasmplus.exe src-z80/dualpcm-flexed/Z80.asm --raw=_out/dualpcm-flexed.bin --exp=_out/dualpcm-flexed.exp --sym=_out/dualpcm-flexed.sym --lst=_out/dualpcm-flexed.lst >_out/dualpcm-flexed.txt %PrintTextSJ%
	REM // if %PrintText% == 1 echo Compressing DualPCM-FlexEd
	REM // tools\zx0\salvador.exe "_out/dualpcm-flexed.bin" "_out/dualpcm-flexed.zx0"
	REM // if %PrintText% == 1 echo ============================================
	REM // if %PrintText% == 1 echo Building Z80 driver release blob
	REM // tools\sjasmplus\sjasmplus.exe "src-z80/build.asm" --raw=_out/smps-drvz80.bin --exp=_out/drvz80.exp --lst=_out/drvz80.lst >_out/drvz80.txt %PrintTextSJ%
	REM // if %PrintText% == 1 echo Compressing Z80 driver release blob
	REM // tools\zx0\salvador.exe "_out/smps-drvz80.bin" "_out/smps-drvz80.bin"
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building MegaCD driver
	tools\asw\asw.exe -xx -n -A -L -U -g map -i . -olist _out\build-mcd.lst -E _out\build-mcd.log src-68k\build-mcd.asm %PrintTextAS%
	if not exist src-68k\build-mcd.p goto _BUILDTYPE_ERROR_MEGACD
	tools\asw\p2bin.exe "src-68k\build-mcd.p" "_out/build-mcd.bin" ""
	> NUL move src-68k\build-mcd.p _out/build-mcd.p
	if exist src-68k\build-mcd.map > NUL move src-68k\build-mcd.map _out/build-mcd.map
	if exist _out\build-mcd.log type _out\build-mcd.log
	if not exist _out\build-mcd.log ( if %PrintText% == 1 echo MegaCD driver build successful )
	if %PrintText% == 1 echo Compressing MegaCD driver
	tools\zx0\salvador.exe "_out/build-mcd.bin" "_out/build-mcd.zx0"
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building 68K driver release blob
	tools\asw\asw.exe -xx -n -A -L -U -g map -i . -a -shareout smps-def.asm -olist _out\build-drv.lst -E _out\build-drv.log build-drv.asm -D __smpsDebug=0 %PrintTextAS%
	if not exist build-drv.p goto _BUILDTYPE_ERROR_RELEASE
	tools\asw\p2bin.exe "build-drv.p" "smps-drv.bin" ""
	> NUL move build-drv.p _out/build-drv.p
	if exist build-drv.map > NUL move build-drv.map _out/build-drv.map
	if exist _out\build-drv.log type _out\build-drv.log
	if not exist _out\build-drv.log ( if %PrintText% == 1 echo Release driver build successful )
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building 68K driver debug blob
	tools\asw\asw.exe -xx -n -A -L -U -g map -i . -a -shareout smps-def-debug.asm -olist _out\build-drv-debug.lst -E _out\build-drv-debug.log build-drv.asm -D __smpsDebug=1 %PrintTextAS%
	if not exist build-drv.p goto _BUILDTYPE_ERROR_DEBUG
	tools\asw\p2bin.exe "build-drv.p" "smps-drv-debug.bin" ""
	> NUL move build-drv.p _out/build-drv-debug.p
	if exist build-drv.map > NUL move build-drv.map _out/build-drv-debug.map
	if exist _out\build-drv-debug.log type _out\build-drv-debug.log
	if not exist _out\build-drv-debug.log ( if %PrintText% == 1 echo Debug driver build successful )
	goto :EOF

:_BUILDTYPE_ERROR_MEGACD
	echo SMPS build error: No generated .p file for MegaCD driver
	pause & exit

:_BUILDTYPE_ERROR_RELEASE
	echo SMPS build error: No generated .p file for release driver
	pause & exit

:_BUILDTYPE_ERROR_DEBUG
	echo SMPS build error: No generated .p file for debug driver
	pause & exit

:snd
	if not exist _out mkdir _out
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building SMPS blob
	tools\asw\asw.exe -xx -n -A -L -U -i . -a -shareout smps-ids.asm -olist _out\build-snd.lst -E _out\build-snd.log build-snd.asm -D __smpsDebug=0 %PrintTextAS%
	if not exist build-snd.p goto _BUILDTYPE_ERROR_DATA
	tools\asw\p2bin.exe "build-snd.p" "smps-snd.bin" ""
	> NUL move build-snd.p _out
	if exist build-snd.map > NUL move build-snd.map _out
	if exist _out\build-snd.log type _out\build-snd.log
	if not exist _out\build-snd.log ( if %PrintText% == 1 echo Sound data build successful )
	goto :EOF

:_BUILDTYPE_ERROR_DATA
	echo SMPS build error: No generated .p file for driver data
	pause & exit

:rom
	if not exist _out mkdir _out
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building Test ROM Z80 entry code
	tools\sjasmplus\sjasmplus.exe src-z80/entry.a80 --raw=_out/entry-z80.bin --lst=_out/entry-z80.lst >_out/entry-z80.txt %PrintTextSJ%
	
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building SMPS test rom
	tools\asw\asw.exe -xx -n -A -L -U -g map -i . -olist _out\build-testrom.lst -E _out\build-testrom.log build-testrom.asm %PrintTextAS%
	if not exist build-testrom.p goto _BUILDTYPE_ERROR_ROM
	tools\asw\p2bin.exe "build-testrom.p" "smps-testrom.gen" ""
	> NUL move build-testrom.p _out
	if exist build-testrom.map > NUL move build-testrom.map _out
	if exist _out\build-testrom.log type _out\build-testrom.log
	if not exist _out\build-testrom.log ( if %PrintText% == 1 echo Sound data build successful )
	goto :EOF

:_BUILDTYPE_ERROR_ROM
	echo SMPS build error: No generated .p file for test rom
	pause & exit

:EOF