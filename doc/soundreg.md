# YM2612/YM3834
ymstat
range = $A04000 ($A04000-$A04003 on earlier YM2612s)
reads [W... ..BA]
All non-defined bits are highly volatile
W = Wait
A = Timer A overflow
A = Timer B overflow

yma0
ymd0
yma1
ymd1

# SN76459
psginput
range = $C00011
[1cct dddd]
T = Type (of data), 0 for tone/noise, 1 for volume
C = Channel, 0 for channel 1, 1 for channel 2 etc
D = Data, 10-bit value for tone, 4-bit value for volume

[0.DD DDDD]
D = Data, this write isn't necessary for volume (the lower 4 bits overwrite the already provided volume)
Data types
Tone:   DDDDDDdddd = cccccccccc
Noise:  (DDDDDD)dddd = (---trr)-trr
Volume: (DDDDDD)dddd = (--vvvv)vvvv



# adpcm

# adpcmdata
reads return how much bytes are free in FIFO
writes add bytes into the FIFO

# adpcmctrl
reads [B... .... .... ....]
B = BUSY status, 1 if the chip currently playing a sample
write [RI.. ?... FF.. .VVV]
R = Write 1 to reset
I = Interrupt enable. Level 3 interrupts will trigger based on FIFO fullness when set, or not when clear
? = Sega driver always sets this bit outside of reset, but some games expect ADPCM to work with it clear.
F = Low-pass filter selection, 11 = 16 kHz, 10 = 12 kHz, 01 = 6 kHz, 00 = ??
V = Volume




ymz263B

ymf262