InitDriver:
		move.w	#$100,($A11100).l		; request Z80 stop (ON)
		move.w	#$100,($A11200).l		; request Z80 reset (OFF)
		lea	(Z80ROM).l,a0			; load Z80 ROM data
		lea	($A00000).l,a1			; load Z80 RAM space address
		move.w	#(Z80ROM_End-Z80ROM)-$01,d1	; set repeat times
.wait:		btst	#0,($A11100).l			; has the Z80 stopped yet?
		bne.s	.wait				; if not, branch
.load:		move.b	(a0)+,(a1)+			; copy Dual PCM to Z80 RAM
		dbf	d1,.load			; repeat til done

		lea	(MuteSample).l,a0		; load mute sample address
		lea	($A00C62).l,a1			; load Z80 RAM space where the pointer is to be stored
		move.b	(a0)+,(a1)+			; copy pointer over into Z80
		move.b	(a0)+,(a1)+			; ''
		move.b	(a0)+,(a1)+			; ''
		move.b	(a0)+,(a1)+			; copy "reverse" pointer over into Z80
		move.b	(a0)+,(a1)+			; ''
		move.b	(a0)+,(a1)+			; ''

		move.w	#$000,($A11200).l		; request Z80 reset (ON)
		moveq	#$7F,d1				; set repeat times
		dbf	d1,*				; no way of checking for reset, so a manual delay is necessary
		move.w	#$000,($A11100).l		; request Z80 stop (OFF)
		move.w	#$100,($A11200).l		; request Z80 reset (OFF)
		rts
; INPUT
; a0 = sample address
QueuePCM1:
		lea ($A00C69).l,a1 ; load PCM1 pointers
		lea ($A0064E).l,a2 ; load PCM1 request switch
		move.w #$0100,($A11100).l ; request Z80 stop (ON)
		btst.b #$00,($A11100).l ; has the Z80 stopped yet?
		bne.s *-$08 ; if not, branch
		move.b (a0)+,(a1)+ ; set address of sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of reverse sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of loop sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of loop reverse sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b #%11011010,(a2) ; set request
		move.w #$0000,($A11100).l ; request Z80 stop (OFF)
		rts
QueuePCM2:
		lea ($A00C75).l,a1 ; load PCM2 pointers
		lea ($A00651).l,a2 ; load PCM2 request switch
		move.w #$0100,($A11100).l ; request Z80 stop (ON)
		btst.b #$00,($A11100).l ; has the Z80 stopped yet?
		bne.s *-$08 ; if not, branch
		move.b (a0)+,(a1)+ ; set address of sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of reverse sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of loop sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; set address of loop reverse sample
		move.b (a0)+,(a1)+ ; ''
		move.b (a0)+,(a1)+ ; ''
		move.b #%11011010,(a2) ; set request
		move.w #$0000,($A11100).l ; request Z80 stop (OFF)
		rts
; repeat the previously queued sample
RepeatPCM1:
		lea ($A0064E).l,a2 ; load PCM1 request switch
		move.w #$0100,($A11100).l ; request Z80 stop (ON)
		btst.b #$00,($A11100).l ; has the Z80 stopped yet?
		bne.s *-$08 ; if not, branch
		move.b #%11011010,(a2) ; set request
		move.w #$0000,($A11100).l ; request Z80 stop (OFF)
		rts
RepeatPCM2:
		lea ($A00651).l,a2 ; load PCM2 request switch
		move.w #$0100,($A11100).l ; request Z80 stop (ON)
		btst.b #$00,($A11100).l ; has the Z80 stopped yet?
		bne.s *-$08 ; if not, branch
		move.b #%11011010,(a2) ; set request
		move.w #$0000,($A11100).l ; request Z80 stop (OFF)
		rts

MuteSample:	dc.b (SWF_MuteSample)&$FF,((SWF_MuteSample)>>8)&$7F|$80,((SWF_MuteSample)>>15)&$FF
		dc.b (SWF_MuteSample_Rev)&$FF,((SWF_MuteSample_Rev)>>8)&$7F|$80,((SWF_MuteSample_Rev)>>15)&$FF
Sonic1Kick:	dcz80 SWF_S1_Kick,  SWF_S1_Kick_Rev,  SWF_MuteSample, SWF_MuteSample_Rev
Sonic1Snare:	dcz80 SWF_S1_Snare, SWF_S1_Snare_Rev, SWF_MuteSample, SWF_MuteSample_Rev

WriteFM:
	move.w	#$0100,($A11100).l		; request Z80 stop (ON)
	btst.b	#$00,($A11100).l		; has the Z80 stopped yet?
	bne.s	*-$08				; if not, branch
	move.b	#$02,(a4)+			; write YM2612 port address
	move.b	d1,(a4)+			; write YM2612 data
	move.b	d0,(a4)+			; write YM2612 address
	st.b	(a4)				; set end of list marker
	move.w	#$0000,($A11100).l		; request Z80 stop (OFF)
	rts
			align	$8000
			pcmendmark
SWF_MuteSample:		dcb.b	$8000-(($18*$10)*2),$80	; a large block of silent PCM data
SWF_MuteSample_Rev:	pcmendmark
SWF_S1_Kick:		incbin	"Samples\incswf\Sonic 1 Kick.swf"
SWF_S1_Kick_Rev:	pcmendmark
SWF_S1_Snare:		incbin	"Samples\incswf\Sonic 1 Snare.swf"
SWF_S1_Snare_Rev:	pcmendmark