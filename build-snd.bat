@echo off
if not exist _out mkdir _out
REM // https://github.com/Clownacy/p2bin
echo ============================================
echo Building SMPS blob
tools\asw.exe -xx -n -q -A -L -U -i . -a -shareout smps-ids.asm -olist _out\snd.lst -E _out\snd.log build-snd.asm
if not exist build-snd.p goto _BUILDTYPE_ERROR_PENIS

tools\p2bin.exe "build-snd.p" "smps-snd.bin" ""
move build-snd.p _out
if exist build-snd.map move build-snd.map _out
if exist _out\snd.log goto _BUILDTYPE_WARNING
echo Build successful, nice cock
pause & exit

:_BUILDTYPE_WARNING
echo Build warning, check snd.log
pause & exit

:_BUILDTYPE_ERROR_PENIS
echo Build error: No generated .p file
pause & exit