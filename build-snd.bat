@echo off
if not exist _out mkdir _out
echo ============================================
echo Building SMPS blob
tools\asw\asw.exe -xx -n -q -A -L -U -i . -a -shareout smps-ids.asm -olist _out\build-snd.lst -E _out\build-snd.log build-snd.asm
if not exist build-snd.p goto _BUILDTYPE_ERROR_PENIS

tools\asw\p2bin.exe "build-snd.p" "smps-snd.bin" ""
move build-snd.p _out
if exist build-snd.map move build-snd.map _out
if exist _out\build-snd.log type _out\build-snd.log
if not exist _out\build-snd.log echo Sound data build successful
pause & exit

:_BUILDTYPE_ERROR_PENIS
echo Build error: No generated .p file
pause & exit