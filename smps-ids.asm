; UVB FM instrument IDs
	enum		yGuitar=$01
; ---------------------------------------------------------------------------
; UVB PSG instrument IDs
	enum		fTone_01=$01,fTone_02,fTone_03,fTone_04,fTone_05,fTone_06
	nextenum	fTone_07,fTone_08,fTone_09,fTone_0A,fTone_0B,fTone_0C
	nextenum	fTone_0D
	nextenum	sTone_01,sTone_02,sTone_04,sTone_08,sTone_0A,sTone_0C,sTone_0D,sTone_1B
	nextenum	smlTone_04,smlTone_06
; ---------------------------------------------------------------------------
; DAC IDs
; NOTE: all claps aside for dClap are actually bongos. it's due to poor documentation that stuck around
d__First:		equ $81
	enum		dKick=d__First,dSnare,dClap,dScratch,dTimpani,dHiTom,dVLowClap,dHiTimpani,dMidTimpani
	nextenum	dLowTimpani,dVLowTimpani,dMidTom,dLowTom,dFloorTom
	nextenum	dHiClap,dMidClap,dLowClap

	nextenum	dSnareS3,dKickS3,dCrashCymbal
	nextenum	dElectricHighTom,dElectricMidTom,dElectricLowTom,dElectricFloorTom
	nextenum	dMidpitchSnare
	nextenum	dSegaChant
	nextenum	d__Last
dS3Crash	= dCrashCymbal
dMuffledSnare	= dMidpitchSnare
dLowTimpaniS3	= dLowTimpani
dHiTimpaniS3	= dHiTimpani
dCrackerKick	= dKickS3
dCrackerSnare	= dSnareS3
dMidConga	= dScratch
dQuickLooseSnare	= dMidpitchSnare
dMetalCrashHit	= dScratch
dKickHey	= dKickS3
dOddSnareKick	= dSnareS3
dKickExtraBass	= dKickS3
; ---------------------------------------------------------------------------
; Background music
bgm__First:		equ $01
	enum		bgm_GHZ=bgm__First,bgm_SS,bgm_EHZ2P,bgm_MCZ2P,bgm_MTZ,bgm_LRZ1,bgm_ExtraLife,bgm_ExtraLife3,bgm_ExtraLifeK
	nextenum	bgm_Drowning,bgm_Soccer,bgm_S3Credits;,bgm_S3CreditsP
	nextenum	bgm__Last
; Sound effects
sfx__First:		equ bgm__Last
	enum		sfx_Jump=sfx__First,sfx_Lamppost,sfx_Death,sfx_Skid,sfx_HitSpikes,sfx_Push,sfx_SSGoal
	nextenum	sfx_SSItem,sfx_Splash,sfx_HitBoss,sfx_Bubble,sfx_Fireball,sfx_Shield,sfx_Saw,sfx_Electric
	nextenum	sfx_Drown,sfx_Flamethrower,sfx_Bumper,sfx_Ring,sfx_SpikesMove,sfx_Rumbling,sfx_Collapse,sfx_SSGlass
	nextenum	sfx_Door,sfx_Teleport,sfx_ChainStomp,sfx_Roll,sfx_Continue,sfx_Basaran,sfx_BreakItem,sfx_Warning
	nextenum	sfx_GiantRing,sfx_Bomb,sfx_Cash,sfx_RingLoss,sfx_ChainRise,sfx_Burning,sfx_Bonus,sfx_EnterSS
	nextenum	sfx_WallSmash,sfx_Spring,sfx_Switch,sfx_RingLeft,sfx_Signpost
	nextenum	sfx_RevUp,sfx_RevRel
	nextenum	ssfx_Waterfall,ssfx_TestFM4
	nextenum	csfx_WindQuiet
	nextenum	sfx_Test
	nextenum	sfx__Last
; PCM sound effects
pcm__First:		equ sfx__Last
pcm__Last:		equ pcm__First+(d__Last-d__First)
; Commands
cmd__First:		equ $F000
cmd_FadeoutBGM:		equ $F000
cmd_Fadeout:		equ $F100
cmd_Fadein:		equ $F200
cmd_StopAll:		equ $F307
cmd_StopBGM:		equ $F301
cmd_StopSFX:		equ $F302
cmd_StopBSFX:		equ $F304
cmd_SpeedOff:		equ $F400
cmd_SpeedOn:		equ $F401
cmd_PanStereo:		equ $F402
cmd_PanMono:		equ $F403
cmd_SsgOn:		equ $F404
cmd_SsgOff:		equ $F405
cmd_MuffleOn:		equ $F406
cmd_MuffleOff:		equ $F407
cmd__Last:		equ $F500
; ---------------------------------------------------------------------------