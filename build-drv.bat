@echo off
if not exist _out mkdir _out
REM // https://github.com/Clownacy/p2bin
echo ============================================
echo Building SMPS driver release blob
tools\asw.exe -xx -n -q -A -L -U -g map -i . -olist _out\drv.lst -E _out\drv.log build-drv.asm -D __smpsDebug=0
if not exist build-drv.p goto _BUILDTYPE_ERROR_RELEASE
tools\p2bin.exe "build-drv.p" "smps-drv.bin" ""
move build-drv.p _out/build-drv.p
if exist build-drv.map move build-drv.map _out/build-drv.map

if exist _out\drv.log echo Build warning for release build: check _out\drv.log
if not exist _out\drv.log echo Release blob build successful

echo ============================================
echo Building SMPS driver debug blob
tools\asw.exe -xx -n -q -A -L -U -g map -i . -olist _out\drv-debug.lst -E _out\drv-debug.log build-drv.asm -D __smpsDebug=1
if not exist build-drv.p goto _BUILDTYPE_ERROR_DEBUG
tools\p2bin.exe "build-drv.p" "smps-drv-debug.bin" ""
move build-drv.p _out/build-drv-debug.p
if exist build-drv.map move build-drv.map _out/build-drv-debug.map

if exist _out\drv-debug.log echo Build warning for debug build: check _out\drv-debug.log
if not exist _out\drv-debug.log echo Debug blob build successful

echo ============================================
pause & exit

:_BUILDTYPE_ERROR_RELEASE
echo Build error: No generated .p file for release build
pause & exit

:_BUILDTYPE_ERROR_DEBUG
echo Build error: No generated .p file for debug build
pause & exit