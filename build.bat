@echo off
if not exist _out mkdir _out
set BuildDriver=1
set BuildData=1
set BuildTestRom=1

if %BuildDriver% == 1 (
echo ============================================
echo Building MegaPCM1
tools\sjasmplus\sjasmplus.exe src-z80/mpcm1/main.asm --raw=_out/mpcm1.bin --exp=_out/mpcm1.exp --lst=_out/mpcm1.lst >_out/mpcm1.txt
echo Compressing MegaPCM1
tools\clownlzss\clownlzss.exe -kp "_out/mpcm1.bin" "_out/mpcm1.kosp"
echo ============================================
echo Building MegaPCM2
tools\sjasmplus\sjasmplus.exe src-z80/mpcm2/megapcm.asm -DOUTPATH=\"_out/mpcm2.bin\" -DTRACEPATH=\"_out/mpcm2.tracedata.txt\" --exp=_out/mpcm2.exp.sym --sym=_out/mpcm2.sym --lst=_out/mpcm2.lst >_out/mpcm2.txt
echo Compressing MegaPCM2
tools\clownlzss\clownlzss.exe -kp "_out/mpcm2.bin" "_out/mpcm2.kosp"
REM // echo ============================================
REM // echo Building Z80 driver release blob
REM // tools\sjasmplus\sjasmplus.exe "src-z80/build.asm" --raw=smps-drvz80.bin --exp=_out/drvz80.exp --lst=_out/drvz80.lst >_out/drvz80.txt
REM // echo Compressing Z80 driver release blob
REM // tools\clownlzss\clownlzss.exe -kp "_out/mpcm2.bin" "_out/mpcm2.kosp"
echo ============================================
echo Building 68K driver release blob
tools\asw\asw.exe -xx -n -q -A -L -U -g map -i . -a -shareout smps-def.asm -olist _out\build-drv.lst -E _out\build-drv.log build-drv.asm -D __smpsDebug=0
if not exist build-drv.p goto _BUILDTYPE_ERROR_RELEASE
tools\asw\p2bin.exe "build-drv.p" "smps-drv.bin" ""
move build-drv.p _out/build-drv.p
if exist build-drv.map move build-drv.map _out/build-drv.map
if exist _out\build-drv.log type _out\build-drv.log
if not exist _out\build-drv.log echo Release driver build successful
echo ============================================
echo Building 68K driver debug blob
tools\asw\asw.exe -xx -n -q -A -L -U -g map -i . -a -shareout smps-def-debug.asm -olist _out\build-drv-debug.lst -E _out\build-drv-debug.log build-drv.asm -D __smpsDebug=1
if not exist build-drv.p goto _BUILDTYPE_ERROR_DEBUG
tools\asw\p2bin.exe "build-drv.p" "smps-drv-debug.bin" ""
move build-drv.p _out/build-drv-debug.p
if exist build-drv.map move build-drv.map _out/build-drv-debug.map
if exist _out\build-drv-debug.log type _out\build-drv-debug.log
if not exist _out\build-drv-debug.log echo Debug driver build successful
)

if %BuildData% == 1 (
echo ============================================
echo Building SMPS blob
tools\asw\asw.exe -xx -n -q -A -L -U -i . -a -shareout smps-ids.asm -olist _out\build-snd.lst -E _out\build-snd.log build-snd.asm
if not exist build-snd.p goto _BUILDTYPE_ERROR_DATA
tools\asw\p2bin.exe "build-snd.p" "smps-snd.bin" ""
move build-snd.p _out
if exist build-snd.map move build-snd.map _out
if exist _out\build-snd.log type _out\build-snd.log
if not exist _out\build-snd.log echo Sound data build successful
)

if %BuildTestRom% == 1 (
echo ============================================
echo Building Test ROM Z80 entry code
tools\sjasmplus\sjasmplus.exe src-z80/entry.a80 --raw=_out/entry-z80.bin --lst=_out/entry-z80.lst >_out/entry-z80.txt

echo ============================================
echo Building SMPS test rom
tools\asw\asw.exe -xx -n -q -A -L -U -g map -i . -olist _out\build-testrom.lst -E _out\build-testrom.log build-testrom.asm
if not exist build-testrom.p goto _BUILDTYPE_ERROR_ROM
tools\asw\p2bin.exe "build-testrom.p" "smps-testrom.gen" ""
move build-testrom.p _out
if exist build-testrom.map move build-testrom.map _out
if exist _out\build-testrom.log type _out\build-testrom.log
if not exist _out\build-testrom.log echo Sound data build successful
)
echo ============================================
pause & exit

:_BUILDTYPE_ERROR_ROM
echo Build error: No generated .p file for test rom
pause & exit

:_BUILDTYPE_ERROR_DATA
echo Build error: No generated .p file for driver data
pause & exit

:_BUILDTYPE_ERROR_RELEASE
echo Build error: No generated .p file for release driver
pause & exit

:_BUILDTYPE_ERROR_DEBUG
echo Build error: No generated .p file for debug driver
pause & exit