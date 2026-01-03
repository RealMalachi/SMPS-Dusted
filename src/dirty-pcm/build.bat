@echo off

if not exist _out mkdir _out
echo Building Dirty-PCM
sjasmplus\sjasmplus.exe main.asm --raw=z80.bin --lst=_out\dpcm.lst >_out\dpcm.txt

pause	REM pause to see what built