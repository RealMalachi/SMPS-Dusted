@echo off
setlocal enabledelayedexpansion
set mainpath=%~dp0
set PrintText=0
if not "%~2"=="" ( set PrintText=1 )

if /i %PROCESSOR_ARCHITECTURE%==x86 (
	set "AS=tools\asw\asw.exe -xx -n -A -L -U -i ."
	) else (
	set "AS=tools\asw\asw-x64.exe -xx -n -A -L -U -i ."
)
set "P2BIN=tools\asw\p2bin.exe"
set "SJ=tools\sjasmplus\sjasmplus.exe"
set "COMP=tools\zx0\salvador.exe"
if %PrintText% == 1 (
	set "ASFLAGS=-q -D __smpsPrintMessages=1"
	set "SJFLAGS="
) else (
	set "ASFLAGS=-q -D __smpsPrintMessages=0"
	set "SJFLAGS=--nologo --msg=war"
)

if "%~1"=="-h" goto :help
if "%~1"=="--help" goto :help
if "%~1"=="" goto :all
goto :%~1

:all
	call :drv
	call :snd
	call :rom
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo SMPS-Dusted is ready
	if %PrintText% == 1 pause
	goto :EOF

:help
	echo INPUT: build.bat routine print
	echo   routine accepts the following inputs
	echo     all   = (default) build the driver, sound data, and test rom
	echo     drv   = build the driver
	echo     snd   = build the sound data
	echo     rom   = build the test rom (requires the driver and sound data to already be built)
	echo     clean = clean the directory
	echo     help  = print the help text that you're reading right now
	echo     -h, --help = alias for help
	echo   if print is given anything, debug text will be printed in the command line
	pause
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
	call :BUILDZ80COMP "src-z80/mpcm1/main.asm" "mpcm1" "MegaPCM1"
	call :BUILDZ80 "src-z80/mpcm2/megapcm.asm" "megapcm2" "MegaPCM2.0" "-Wno-fileorg -DOUTPATH=\"_out/mpcm2.bin\" -DTRACEPATH=\"_out/mpcm2.tracedata.txt\""
	call :COMP "_out/mpcm2.bin" "_out/mpcm2.zx0"
	call :BUILD68K "src-68k\build-mcd.asm" "_out/build-mcd.bin" "build-mcd" "MegaCD driver"
	call :COMP "_out/build-mcd.bin" "_out/build-mcd.zx0"
	call :BUILD68K "build-drv.asm" "smps-drv.bin" "build-drv" "SMPS driver blob" "-a -shareout smps-def.asm -D __smpsDebug=0 -g map"
	call :BUILD68K "build-drv.asm" "smps-drv-debug.bin" "build-drv-debug" "SMPS debug driver blob" "-a -shareout smps-def-debug.asm -D __smpsDebug=1 -g map"
	goto :EOF

:snd
	if not exist _out mkdir _out
	call :BUILD68K "build-snd.asm" "smps-snd.bin" "build-snd" "SMPS sound data blob" "-a -shareout smps-ids.asm -D __smpsDebug=0"
	goto :EOF

:rom
	if not exist _out mkdir _out
	call :BUILDZ80 "src-z80/entry.a80" entry-z80 "Test ROM Z80 entry code"
	call :BUILD68K "build-testrom.asm" "smps-testrom.gen" "build-testrom" "SMPS test rom"
	goto :EOF

:COMP
	if %PrintText% == 1 echo Compressing %~3
	%COMP% %~1 %~2
	goto :EOF

; call :BUILDZ80 src-z80/mpcm2/megapcm.asm "mpcm2" "MegaPCM2"
; asmfile,outputfilenames,namefordebugtext,extraflags
:BUILDZ80
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building %~3
	%SJ% %~1 %~4 --raw=_out/%~2.bin --exp=_out/%~2.exp --sym=_out/%~2.sym --lst=_out/%~2.lst --cleanonerror %SJFLAGS%
	goto :EOF
:BUILDZ80COMP
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building %~3
	%SJ% %~1 --raw=_out/%~2.bin --exp=_out/%~2.exp --sym=_out/%~2.sym --lst=_out/%~2.lst %~4 %SJFLAGS% >_out/%~2.txt
	if %PrintText% == 1 echo Compressing %~3
	%COMP% "_out/%~2.bin" "_out/%~2.zx0"
	goto :EOF

; call :BUILD68K 
; asmfile,binaryoutput,outputfilenames,namefordebugtext,extraflags
:BUILD68K
	if %PrintText% == 1 echo ============================================
	if %PrintText% == 1 echo Building %~4
	%AS% %ASFLAGS% %~5 -olist _out\%~3.lst -E _out\%~3.log %~1
	for %%C in ("%~1") do (
		set "inputfilename=%%~dpC%%~nC"
		set "inputfilename=!inputfilename:%mainpath%=!"
	)
	if not exist !inputfilename!.p (
		echo - ASW ERROR: No generated .p file for %~4
		if exist "_out\%~3.log" ( type "_out\%~3.log" )
		pause
		goto :EOF
	)
	%P2BIN% "!inputfilename!.p" "%~2" ""
	if not exist "%~2" (
		echo - P2BIN ERROR: No generated binary file for %~4
		pause
		goto :EOF
	)
	> NUL move !inputfilename!.p _out
	if exist !inputfilename!.map ( > NUL move !inputfilename!.map _out )
	if exist _out\%~3.log ( type _out\%~3.log ) else ( if %PrintText% == 1 echo - Successful )
	goto :EOF

:EOF