@Echo Off
"tools\AS\asl.exe" -q -cpu Z80 -gnuerrors -c -A -L -xx "Z80.asm"
"tools\AS\p2bin.exe" "Z80.p" "Z80.bin" -r 0x-0x

"tools\ListEqu.exe" AS z80 "Z80.lst" asm68k 68k "EquZ80.asm"

IF NOT EXIST "Z80.p" goto Error
CLS
REM // DEL "Z80.lst"
DEL "Z80.p"
DEL "Z80.h"
:Error
Pause