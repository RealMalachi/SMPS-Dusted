QueueSound:
	set .loc,v_soundqueue_start
	rept (v_soundqueue_end-v_soundqueue_start)/2-1
		tst.w	.loc(a1)
		bne.s	.n
		move.w	d0,.loc(a1)
		rts
.n:
	set .loc,.loc+2
	endr
		tst.w	.loc(a1)
		bne.s	.n2
		move.w	d0,.loc(a1)
.n2:		rts
; ===========================================================================
UpdateFIFO:
		updfifo
; ===========================================================================
ReadComm:
		cmp.b	#__smpsCommBytes,d1
		bhs.s	.index
		and.w	#$FF,d1
		move.b	v_communication(a1,d1.w),d0
		rts
.index:		SMPS_assert "ReadComm: Index is too large"
WriteComm:
		cmp.b	#__smpsCommBytes,d1
		bhs.s	.index
		and.w	#$FF,d1
		move.b	d0,v_communication(a1,d1.w)
		rts
.index:		SMPS_assert "WriteComm: Index is too large"
; ===========================================================================
GuardDriver:
		bra.w	DACGuard
UnguardDriver:
		bra.w	DACUnguard
; ===========================================================================
RunMiscCommand:
		cmp.w	#(.lute-.lut)/2,d0
		blo.s	.valid
		SMPS_assert "AudioCommand: Invalid command, TODO print command id"
.valid:
		add.w	d0,d0
		jmp	.lut(pc,d0.w)
.lut:
		bra.s	PauseDriver
		bra.s	ResumeDriver
		bra.s	SetBgmTempo				; d1.w = new tempo
.lute:

PauseDriver:
		btst	#v_driverflags.paused,v_driverflags(a1)
		bne.s	.paused
		moveq_	~(1<<v_driverflags.dopause|1<<v_driverflags.paused),d0
		and.b	v_driverflags(a1),d0
		or.b	#1<<v_driverflags.dopause|1<<v_driverflags.paused,d0	; pause
		move.b	d0,v_driverflags(a1)
.paused:
		rts
ResumeDriver:
		btst	#v_driverflags.paused,v_driverflags(a1)
		beq.s	.playing
		moveq_	~(1<<v_driverflags.dopause|1<<v_driverflags.paused),d0
		and.b	v_driverflags(a1),d0
		or.b	#1<<v_driverflags.dopause|0<<v_driverflags.paused,d0	; resume
		move.b	d0,v_driverflags(a1)
.playing:
		rts
SetBgmTempo:
		move.w	d1,v_main_tempo(a1)
		rts