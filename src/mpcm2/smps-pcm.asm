; ---------------------------------------------------------------------------
; INPUT: 
; TRASHES: d0-d1/a0-a1
DACInitDriver:
		move.w	sr,-(sp)
		move.w	#$2700,sr				; disable interrupts
		move.l	a3,-(sp)
		lea	MPCM_Z80_BUSREQ,a3
		move.w	#$100,d0
		move.w	d0,(a3)					; request Z80 bus (stop Z80)
		move.w	d0,MPCM_Z80_RESET-MPCM_Z80_BUSREQ(a3)	; release Z80 reset
		; Loads Mega PCM program into Z80 memory ...
;	KDebug.WriteLine "Decompressing Mega PCM 2.0 driver..."
		lea	.drv(pc),a0
		lea	(MPCM_Z80_RAM).l,a1
; ---------------------------------------------------------------------------
; KosinskiPlus decompression
	movem.l	d3-d5/a5,-(sp)
; KosPlusDec:
	moveq	#0,d3					; Flag as having no bits left.
	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.FetchCodeLoop:
	; Code 1 (Uncompressed byte).
	move.b	(a0)+,(a1)+

.FetchNewCode:
	bsr.s	.ReadBit
	bcs.s	.FetchCodeLoop				; If code = 1, branch.

	; Codes 00 and 01.
	moveq	#-1,d5
	lea	(a1),a5
	bsr.s	.ReadBit
	bcs.s	.Code_01

	; Code 00 (Dictionary ref. short).
	move.b	(a0)+,d5				; d5 = displacement.
	adda.w	d5,a5
	; Always copy at least two bytes.
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+
	bsr.s	.ReadBit
	bcc.s	.Copy_01
	move.b	(a5)+,(a1)+
	move.b	(a5)+,(a1)+

.Copy_01:
	bsr.s	.ReadBit
	bcc.s	.FetchNewCode
	bra.s	.Copy_01_Cont
;	move.b	(a5)+,(a1)+
;	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.Code_01:
	; Code 01 (Dictionary ref. long / special).
	move.b	(a0)+,d4				; d4 = %xxxxxxxx HHHHHCCC.
	move.b	d4,d5					; d5 = %11111111 HHHHHCCC.
	lsl.w	#5,d5					; d5 = %111HHHHH CCC00000.
	move.b	(a0)+,d5				; d5 = %111HHHHH LLLLLLLL.
	adda.w	d5,a5

	and.w	#7,d4					; d4 = %00000000 00000CCC.
	beq.s	.dolargecopy
; ---------------------------------------------------------------------------
.StreamCopy:
	neg.w	d4					; -10
	addq.w	#8,d4					; 10-2, -1 for dbf, another -1 for .Copy_01_Cont
	bra.s	.largeloop
; ---------------------------------------------------------------------------
.ReadBit:
	dbra	d3,.SkipRead
	moveq	#7,d3					; We have 8 new bits, but will use one up below.
	move.b	(a0)+,d0				; Get desc field low-byte.
.SkipRead:
	add.b	d0,d0					; Get a bit from the bitstream.
	rts
; ---------------------------------------------------------------------------
.dolargecopy:
	; special mode (extended counter)
	move.b	(a0)+,d4				; Read cnt
	beq.s	.Quit					; If cnt=0, quit decompression.
	addq.w	#7,d4					; val+8, -1 for .Copy_01_Cont
.largeloop:
	move.b	(a5)+,(a1)+
	dbra	d4,.largeloop

.Copy_01_Cont:
	move.b	(a5)+,(a1)+
	bra.s	.FetchNewCode
; ---------------------------------------------------------------------------
.Quit:
	movem.l	(sp)+,d3-d5/a5
; ---------------------------------------------------------------------------
		; Starts Z80 and prepares for "wait Mega PCM ready" cycle
;	KDebug.WriteLine "Preparing Mega PCM 2.0 driver..."
		moveq	#0,d1
		move.w	d1,MPCM_Z80_RESET-MPCM_Z80_BUSREQ(a3)	; reset Z80. Wait for 16 cycles before release
		lea	(MPCM_Z80_RAM+Z_MPCM_DriverReady).l,a0	; 8(x/x) ; a0 = Z_MPCM_DriverReady
		or.l	d0,d0					; 8(x/x) ; 
		move.w	d0,MPCM_Z80_RESET-MPCM_Z80_BUSREQ(a3)	; release Z80 reset
		move.w	d1,(a3)					; release Z80 bus (start Z80)
		; Waits until Mega PCM reports that it's ready
;	KDebug.WriteLine "Waiting for Mega PCM initialization..."
		; WARNING! Mega PCM performs ROM/RAM benchmarks during boot to
		; calibrate playback for inaccurate emulators.
		; It's highly recommended not to interrupt Z80 too often during
		; this phase,so benchmark is accurate.
		; Calibration takes roughly 3 frames, so don't worry about
		; wasting too many cycles.
.RedoLoop:
		move.w	#$1000-1,d0
		dbf	d0,*		; waste 40k+ cycles
		SMPS_stopZ80 (a3)
		SMPS_waitZ80 (a3)
		move.b	(a0),d1			; d1 = Z_MPCM_DriverReady
		SMPS_startZ80 (a3)
		cmp.b	#'R',d1			; is driver ready?
		bne.s	.RedoLoop		; if not, loop
		; Release additional registers, restore SR and quit
		move.l	(sp)+,a3
		move.w	(sp)+,sr
		rts
.drv:	binclude "src/mpcm2/z80.kosp"
	even
; ===========================================================================
; INPUT: a0 = table
; OUTPUT: d0.w = error code, see MPCM_ST_[] in smps-pcm-def
; TRASHES: d1/a1
DACLoadBank:

;MPCM_ST_TOO_MANY_SAMPLES:			equ	$01
;MPCM_ST_UNKNOWN_SAMPLE_TYPE:		equ	$02
;
;MPCM_ST_PITCH_NOT_SET:				equ	$10
;
;MPCM_ST_WAVE_INVALID_HEADER:		equ	$20
;MPCM_ST_WAVE_BAD_AUDIO_FORMAT:		equ	$21
;MPCM_ST_WAVE_NOT_MONO:				equ	$22
;MPCM_ST_WAVE_NOT_8BIT:				equ	$23
;MPCM_ST_WAVE_BAD_SAMPLE_RATE:		equ	$24
;MPCM_ST_WAVE_MISSING_DATA_CHUNK:	equ	$25

; ==============================================================================
; Loads a given sample table to Mega PCM
; INPUT
; a0 = sample table
; OUTPUT
; d0.w = error code
; ------------------------------------------------------------------------------

; ----------------------------------------------------------------------
; LOCAL MACROS:
MPCM2moveLE: macro src, dest
	if "ATTRIBUTE"=="w"
		move.b	1+src, (sp)
		move.b	src, 1(sp)
		move.w	(sp), dest
	elseif "ATTRIBUTE"=="l"
		move.b	3+src, (sp)
		move.b	2+src, 1(sp)
		move.b	1+src, 2(sp)
		move.b	src, 3(sp)
		move.l	(sp), dest
	else
		warning "Unsupported size: ATTRIBUTE"
	endif
	endm
; ----------------------------------------------------------------------
MegaPCM_LoadSampleTable:
	movem.l	d2-d5/a2-a4, -(sp)				; release additional registers

	lea		MPCM_Z80_BUSREQ, a3

	lea		MPCM_Z80_RAM+Z_MPCM_SampleTable, a1
	subq.w	#4, sp						; used for fast LE->BE conversion
	moveq	#$7F-1, d2			; load at most $7F samples (but table should have an end marker anyways!)

	.ProcessSampleLoop:
		; Fetch sample record data ...
		move.b	(a0)+, d5
		beq.w	.WriteEmptyRecord			; if type is TYPE_NONE, fill everything with zeroes
		bmi.w	.SampleTableDone			; if type is $FF, quit load loop
		move.b	(a0)+, d4
		move.b	(a0)+, d3
		addq.w	#1, a0				; skip a reserved byte
		move.l	(a0)+, a2
		add.l	a0, a2
		move.l	(a0)+, a4
		add.l	a0, a4

;		KDebug.WriteLine "Sample: type=%<.b d5>, flags=%<.b d4>, pitch=%<.b d3>, start=%<.l a2 sym>, end=%<.l a4 sym>"

		; If sample type is DPCM, we don't have to check if it's a WAVE file
		cmp.b	#TYPE_DPCM, d5
		beq.w	.WriteSampleData

		; Here, make sure sample is PCM or PCM Turbo
		cmp.b	#TYPE_PCM, d5
		beq.s	.Sample_PCM_or_DPCM
		cmp.b	#TYPE_PCM_TURBO, d5
		bne.w	.Err_UnknownSampleType
	.Sample_PCM_or_DPCM:

		; For TYPE_PCM and TYPE_PCM_TURBO, detect RIFF header if present
		move.l	(a2), d0
		cmp.l	#'RIFF', d0					; is this a RIFF container?
		beq.s	.WAVE_ChkHeader					; is yes, proceed to check WAVE header
		cmp.l	#'AIFF', d0					; is this an AIFF container?
		beq.w	.Err_WAVE_InvalidHeaderFormat	; we don't support AIFF's disguised as WAV files
		cmp.l	#'NIST', d0					; we don't support NIST containers either
		bne.w	.PCM_AlignOffsets				; if not RIFF, AIFF or NIST, assume raw PCM stream
		bra.w	.Err_WAVE_InvalidHeaderFormat

	.WAVE_ChkHeader:
		; Validate WAVE file format ...
		cmp.l	#'WAVE', 8(a2)		; for RIFF containers, we only accept WAVE type
		bne.w	.Err_WAVE_InvalidHeaderFormat

;		KDebug.WriteLine "Detected WAVE header"

		lea		$C(a2), a2; locate "fmt" chunk
		cmp.l	#'fmt ', (a2)
		bne.w	.Err_WAVE_InvalidHeaderFormat
		cmp.w	#$0100, 8(a2)		; is audio format uncompressed PCM ($0001 Little-endian)?
		beq.w	.WAVE_FormatOk					; if yes, branch
		cmp.w	#$FEFF, 8(a2)		; is it Microsoft's WAVEX PCM format ($FFFE Little-endian)?
		bne.w	.Err_WAVE_BadAudioFormat		; if not, we've exhausted supported format options
	.WAVE_FormatOk:
		cmp.w	#$0100, $A(a2)		; is number of channels 1 ($0001 Little-endian)?
		bne.w	.Err_WAVE_NotMono				; if not, branch
		cmp.w	#$0800, $16(a2)		; is bits per sample 8 ($0008 Little-endian)?
		bne.w	.Err_WAVE_Not8Bit				; if not, branch

		; If pitch isn't set, auto-calucate based on WAVE sample rate ...
		tst.b	d3					; is pitch set in the sample table?
		bne.s	.WAVE_SeekDataChunk				; if yes, don't calculate it
		MPCM2moveLE.w $C(a2), d0		; d0 = sample rate (e.g. 22050)
		cmp.b	#TYPE_PCM_TURBO, d5	; is sample TYPE_PCM_TURBO?
		bne.s	.WAVE_CalcPitch					; if not, branch
		cmp.w	#TYPE_PCM_TURBO_MAX_RATE, d0	; TYPE_PCM_TURBO should use rate of TYPE_PCM_TURBO_MAX_RATE
		bne.w	.Err_WAVE_BadSampleRate			; if it doesn't, raise an error
		moveq	#-1, d3				; set pitch to $FF (max)
		bra.s	.WAVE_SeekDataChunk

	.WAVE_CalcPitch:
		cmp.w	#TYPE_PCM_MAX_RATE, d0		; TYPE_PCM should use rate <= TYPE_PCM_MAX_RATE
		bhi.w	.Err_WAVE_BadSampleRate			; if it doesn't, raise an error
		ext.l	d0
		lsl.l	#8, d0
		divu.w	#TYPE_PCM_BASE_RATE, d0
		move.b	d0, d3

		; Locate "data" chunk ...
		.WAVE_SeekDataChunk:
			cmpa.l	a4, a2					; if we went outside of WAVE file
			bhs.w	.Err_WAVE_MissingDataChunk					; ... return an error
			MPCM2moveLE.l 4(a2), d0					; d0 = chunk size
;			KDebug.WriteLine "Seeking data chunk: Skipping %<.l d0> bytes"
			lea		8(a2, d0.l), a2	; load next chunk
;			KDebug.WriteLine "Checking data chunk at %<.l a2 sym>"
			cmp.l	#'data', (a2)					; is this a "data" chunk?
			bne		.WAVE_SeekDataChunk							; if not, repeat ...

		; Accurately detect `a4` offset based on "data" chunk length ...
		MPCM2moveLE.l 4(a2), d0					; d0 = data size
		lea		8(a2, d0.l), a4		; we can now acurately detect sample's end offset
		addq.w	#8, a2

;		KDebug.WriteLine "WAVE data offsets: start=%<.l a2 sym>, end=%<.l a4 sym>"

	.PCM_AlignOffsets:
		; Round end offset to even address boundary if needed ...
		move.w	a4, d0
		and.w	#1, d0
		suba.w	d0, a4					; this subtracts 1 if address was ODD, so it gets EVEN

	.WriteSampleData:
		tst.b	d3
		beq.w	.Err_PitchNotSet					; pitch can't be zero

		; Convert absolute start/end offsets to Z80 banks and window addresses ...
		move.l	a2, d0
		add.l	d0, d0
		addq.w	#1, d0							; bit 0 is always zero, so we just set it
		ror.w	#1, d0							; d0 LOW  = start offset | $8000
		move.w	d0, (sp)							; stack .00  = start offset | $8000
		swap	d0								; d0 HIGH = start bank

		move.l	a4, d1
		add.l	d1, d1
		addq.w	#1, d1							; bit 0 is always zero, so we just set it
		ror.w	#1, d1							; d1 LOW  = end offset | $8000
		move.w	d1, 2(sp)						; stack .02  = end offset | $8000
		swap	d1								; d1 HIGH = end bank

		; We can send processed data to Mega PCM's sample table now ...
		move.w	sr, -(sp)
		move.w	#$2700, sr							; disable interrupts
		MPCM_stopZ80	(a3)
		or.l	d0,d0				; ML: this fixes an error where the Z80 hasn't stopped fast
		MPCM_waitZ80	(a3)		; enough for the first samples data to be written safely
		move.b	d5, (a1)+				; 00h	- sample type
		move.b	d4, (a1)+				; 01h	- sample flags
		move.b	d3, (a1)+				; 02h	- pitch
		move.b	d0, (a1)+				; 03h	- start bank
		move.b	d1, (a1)+				; 04h	- end bank
		move.b	2+1(sp), (a1)+			; 05h	- start offset LOW
		move.b	2+0(sp), (a1)+			; 06h	- start offset HIGH
		move.b	2+3(sp), (a1)+			; 07h	- end offset LOW
		move.b	2+2(sp), (a1)+			; 08h	- end offset HIGH
		MPCM_startZ80 (a3)
		move.w	(sp)+, sr							; restore interrupts		

		dbf		d2, .ProcessSampleLoop
		bra.s	.Err_TooManySamples

; ----------------------------------------------------------------------
.SampleTableDone:
	subq.w	#1, a0					; seek the end of previous record
	moveq	#0, d0					; no errors to report

.Quit:
	lea		-$C(a0), a0	; seek the start of sample record (helps to investiage erros, if any)
	addq.w	#4, sp							; release stack variables
	movem.l	(sp)+, d2-d5/a2-a4				; release additional registers

	if 0==0
		chk	#0,d0
	else
		tst.w	d0
		bne.w	.Err_Print
	endif
	rts

	; ----------------------------------------------------------------------
	.WriteEmptyRecord:
;		KDebug.WriteLine "Sample: <None>"
		move.w	sr, -(sp)
		move.w	#$2700, sr							; disable interrupts
		MPCM_stopZ80	(a3)
		rept 9
			move.b	d5, (a1)+
		endr
		MPCM_startZ80 (a3)
		move.w	(sp)+, sr							; restore interrupts

		lea		11(a0), a0		; skip the remaining bytes
		dbf		d2, .ProcessSampleLoop

	;bra.s	.Err_TooManySamples
	; fallthrough
; ------------------------------------------------------------------------------
.Err_TooManySamples:
	moveq	#MPCM_ST_TOO_MANY_SAMPLES, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_UnknownSampleType:
	moveq	#MPCM_ST_UNKNOWN_SAMPLE_TYPE, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_InvalidHeaderFormat:
	moveq	#MPCM_ST_WAVE_INVALID_HEADER, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_BadAudioFormat:
	moveq	#MPCM_ST_WAVE_BAD_AUDIO_FORMAT, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_NotMono:
	moveq	#MPCM_ST_WAVE_NOT_MONO, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_Not8Bit:
	moveq	#MPCM_ST_WAVE_NOT_8BIT, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_BadSampleRate:
	moveq	#MPCM_ST_WAVE_BAD_SAMPLE_RATE, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_WAVE_MissingDataChunk:
	moveq	#MPCM_ST_WAVE_MISSING_DATA_CHUNK, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
.Err_PitchNotSet:
	moveq	#MPCM_ST_PITCH_NOT_SET, d0
	bra.w	.Quit
; ------------------------------------------------------------------------------
	if 0==1
.Err_Print:
; ------------------------------------------------------------------------------
; Additional debuggers
; ------------------------------------------------------------------------------

; ------------------------------------------------------------------------------
; DEBUGGER: Displays details for `MegaPCM_LoadSampleTable` error code
; ------------------------------------------------------------------------------
; INPUT:
;		d0	.w	Error code returned by `MegaPCM_LoadSampleTable`
;		a0		Pointer to faulty sample
; ------------------------------------------------------------------------------
	; Print raw error code
;	Console.Write "%<pal1>Error code: %<pal0>%<.b d0>%<endl>"

	; Print error description
		lea	.ErrorCodeToDescription-4(pc),a1
		lea	.Str_UnknownError(pc),a2	; fallback in case error description isn't found

	.findErrorDescriptionLoop:
		addq.w	#4,a1				; skip string pointer
		cmp.b	(a1),d0
		bhi.s	.findErrorDescriptionLoop
		blo.s	.errorDescriptionLoopDone	; search failure
		move.l	(a1),a2				; a2 = error description string
	.errorDescriptionLoopDone:

;	Console.Write "%<pal1>Error description:%<endl>%<pal0>%<.l a2 str>%<endl>%<endl>"

	; Print sample data
;	Console.WriteLine "%<pal1>RAW SAMPLE RECORD:"
;	Console.WriteLine "%<pal2>Type: %<pal0>%<.b (a0)>"
;	Console.WriteLine "%<pal2>Flags: %<pal0>%<.b 1(a0)>"
;	Console.WriteLine "%<pal2>Pitch: %<pal0>%<.b 2(a0)>"
;	Console.WriteLine "%<pal2>Start: %<pal0>%<.l 4(a0) sym>"
;	Console.WriteLine "%<pal2>End: %<pal0>%<.l 8(a0) sym>"
.exit:
	rts
; ------------------------------------------------------------------------------
.ErrorCodeToDescription:
;		Raw error code				String pointer
	dc.l	(MPCM_ST_TOO_MANY_SAMPLES<<24)		| .Str_TooManySamples
	dc.l	(MPCM_ST_UNKNOWN_SAMPLE_TYPE<<24)	| .Str_UnknownSampleType
	dc.l	(MPCM_ST_PITCH_NOT_SET<<24)		| .Str_PitchNotSet
	dc.l	(MPCM_ST_WAVE_INVALID_HEADER<<24)	| .Str_WaveInvalidHeader
	dc.l	(MPCM_ST_WAVE_BAD_AUDIO_FORMAT<<24)	| .Str_WaveBadAudioFormat
	dc.l	(MPCM_ST_WAVE_NOT_MONO<<24)		| .Str_WaveNotMono
	dc.l	(MPCM_ST_WAVE_NOT_8BIT<<24)		| .Str_WaveNot8bit
	dc.l	(MPCM_ST_WAVE_BAD_SAMPLE_RATE<<24)	| .Str_BadSampleRate
	dc.l	(MPCM_ST_WAVE_MISSING_DATA_CHUNK<<24)	| .Str_MissingDataChunk
	dc.b	$FF
; ------------------------------------------------------------------------------
.Str_TooManySamples:		ertxt "Too many samples in table"
.Str_UnknownSampleType:		ertxt "Unknown sample type or missing end marker. Please use one of: TYPE_PCM, TYPE_DPCM, TYPE_PCM_TURBO, TYPE_NONE"
.Str_PitchNotSet:		ertxt "Sample rate can't be auto-detected (only works for .WAV files). Please set it manually"
.Str_WaveInvalidHeader:		ertxt "WAVE error: Invalid WAVE header"
.Str_WaveBadAudioFormat:	ertxt "WAVE error: Unsupported audio format. Only PCM is supported"
.Str_WaveNotMono:		ertxt "WAVE error: Audio must be mono"
.Str_WaveNot8bit:		ertxt "WAVE error: Audio must be 8-bit PCM"
.Str_BadSampleRate:		ertxt "WAVE error: Unsupported sample rate. Use <=25100 Hz for TYPE_PCM or 32000 Hz for TYPE_PCM_TURBO."
.Str_MissingDataChunk:		ertxt "WAVE error: Failed to locate 'data' chunk"
.Str_UnknownError:		ertxt "Unknown error code"
	even
	endif
; ===========================================================================
; OUTPUT: d0 = 0 if not playing, non-zero if so ; TODO: use ccr zero bit?
DACCheckIfPlaying:
		rts
; ===========================================================================
; INPUT: d0.w = sample, from $81 to $FF ; $00 is resume, $01 is stop, $02 is pause
DACQueueSample:
DACQueueSampleSFX:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	d0, MPCM_Z80_RAM+Z_MPCM_CommandInput
		SMPS_startZ80
		rts
; ===========================================================================
; INPUT:
DACStopSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#Z_MPCM_COMMAND_STOP, MPCM_Z80_RAM+Z_MPCM_CommandInput
		SMPS_startZ80
		rts
; ===========================================================================
; INPUT:
DACPauseSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#Z_MPCM_COMMAND_PAUSE, MPCM_Z80_RAM+Z_MPCM_CommandInput
		SMPS_startZ80
		rts
; ===========================================================================
; INPUT:
DACResumeSample:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	#0, MPCM_Z80_RAM+Z_MPCM_CommandInput	; I don't know, ask vladik
		SMPS_startZ80
		rts
; ===========================================================================
; INPUT: d0.b = pan, 0 is silent, 40 is left, 80 is right, C0 is centre
DACSetPan:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	d0, MPCM_Z80_RAM+Z_MPCM_PanInput
;		move.b	d0, MPCM_Z80_RAM+Z_MPCM_SFXPanInput
		SMPS_startZ80
		rts
; ===========================================================================
; INPUT: d0.w = volume, 0 is loudest, F is quietest (silent?)
DACSetVolume:
		SMPS_stopZ80
		SMPS_waitZ80
		move.b	d0, MPCM_Z80_RAM+Z_MPCM_VolumeInput
;		move.b	d0, MPCM_Z80_RAM+Z_MPCM_SFXVolumeInput
		SMPS_startZ80
		rts