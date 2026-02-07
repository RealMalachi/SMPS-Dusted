@echo off
rem build with Wine: wine cmd /c build-Z80.bat
if not exist _out mkdir _out
echo ============================================
echo Building MegaPCM
sjasmplus\sjasmplus.exe "src-z80/main.asm" --raw=z80.bin --lst=_out\mpcm1.lst >_out\mpcm1.txt
echo ============================================
pause REM // pause to see what built
