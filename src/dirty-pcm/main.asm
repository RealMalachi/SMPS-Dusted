; Dirty-PCM, a jman2050 encoded DPCM player
; this is primarily meant to be used in combination with an SMPS sound driver
; -----------------------------------------------------------------------------
_smp	= 80h	; first valid sample
_sample = $0000	; _smp > sample, _smp = null
_status	= $0001	; 0 means it's busy, else it's idle
rombank	= $6000
ymstat	= $4000
yma0	= $4000
ymd0	= $4001
yma1	= $4002
ymd1	= $4003
; -----------------------------------------------------------------------------
Init:
	nop						; _sample==0
	nop						; _status==0
	di						; Disable interrupts
;	ld	sp,_stack				; Initialize the stack pointer (unused)
	ld	iy,DpcmLut
	ld	ix,yma0
	ld	bc,_smp<<8|0Fh				; b = _smp, c = 0Fh
	exx						; save shadow registers
WaitLoop:
	exx
	ld	hl,_status
	ld	(hl),h					; h==0; dac busy
	ld	(ix+0),2Bh				; DAC enable register
	ld	(ix+1),00h				; Disable
	ld	(hl),l					; l<>0; dac idle

	ld	hl,_sample
.loop:	ld	a,(hl)					; a = next sample to play.
	or	a
	jr	z,.loop					; Loop until we do
	xor	a
	ld	(hl),a					; clear sample

	ld	(hl),h					; h==0; dac busy
	ld	(ix+0),2Ah				; DAC write register
	ld	(ix+1),80h				; Silence
	nop
.ymw1:	bit	7, (ix+0)
	jr	nz, .ymw1
	ld	(ix+0),2Bh				; DAC enable register
	ld	(ix+1),80h				; Enable
	ld	(hl),l					; l<>0; dac idle
	exx					

;	db 1+(53693175/15/(sampleRate)-(.cycles)+(13/2))/13
;	dw endlabel-label,label
	ld	c,00h					; sample pitch
	ld	de,$0000				; sample length
	ld	hl,$0000				; sample location
; a = scratch ; b = temporary idle loop ; c = idle loop
; hl = sample location ; de = sample length
; ix = yma0
; iy = DPCM decode table
; a' = DPCM accumulator ; b' = _smp ; c' = 0Fh
; hl' = _status, de' = reserved
RunDPCM:
	ld	a,80h
	ex	af,af'				;';	; init DPCM
.loop:
	ld	a,(hl)				; 7	; Get next DAC byte
	rept 4
	rra					; 4
	endr					; ^16	; use upper bits, remove lower bytes
	exx					; 4
	and	c				; 4	; and 0Fh
	ld	(.n1+2),a			; 13	; store into the instruction after .lownybble (self-modifying code)
	ex	af,af'				;'; 4	; shadow register 'a' is the 'd' value for 'jman2050' encoding
	ld	(hl),h				; 7	; h==0; dac busy
.n1:	add	a,(iy+0)			; 19	; Get byte from zDACDecodeTbl (self-modified to proper index)
	ld	(ymd0),a			; 13	; Write this byte to the DAC
	ld	(hl),l				; 7	; l<>0; dac idle
	ex	af,af'				;'; 4	; back to regular registers
					; 98
	exx					; 4
	ld	a,(_sample)			; 13	; a = next sample to play.
	cp	_smp				; 7	; Do we have another valid sample?
	jr	nc,.exit			; 7	; If we do, exit out of this one
	ld	r,a				; 9	; stall
	ld	b,c				; 4	; reload 'b' with wait value
	djnz	$				; 8+13n	; Busy wait for specific amount of time in 'b'
					; 52
					; 150+13n
	ld	a,(hl)				; 7	; Get next DAC byte
	inc	hl				; 6	; Next byte in DAC stream...
	dec	de				; 6	; One less byte
	ld	b,c				; 4	; reload 'b' with wait value
	exx					; 4
	and	c				; 4	; and 0Fh
	ld	(.n2+2),a			; 13	; store into the instruction after .lownybble (self-modifying code)
	ex	af,af'				;'; 4	; shadow register 'a' is the 'd' value for 'jman2050' encoding
	ld	(hl),h				; 7	; h==0; dac busy
.n2:	add	a,(iy+0)			; 19	; Get byte from zDACDecodeTbl (self-modified to proper index)
	ld	(ymd0),a			; 13	; Write this byte to the DAC
	ld	(hl),l				; 7	; l<>0; dac idle
	ex	af,af'				;'; 4	; back to regular registers
					; 98
	exx					; 4
	djnz	$				; 8+13n	; Busy wait for specific amount of time in 'b'
	ld	r,a				; 9	; stall
	ld	r,a				; 9	; ^
	nop					; 4	; ^
	ld	a,d				; 4
	or	e				; 4
	jp	nz,.loop			; 10	; If 'de' (length of sample) <> 0, continue
					; 52
					; 150+13n
.exit:	jp	WaitLoop				; Back to the wait loop
; -----------------------------------------------------------------------------
; JMan2050's DAC decode lookup table
DpcmLut:
	db    0,   1,   2,   4,   8,  10h,  20h,  40h
	db  80h,  -1,  -2,  -4,  -8, -10h, -20h, -40h