	switch __smpsPCM
	case "mpcm1"
		include "src-68k/mpcm1/pcm-def.asm"
	case "mpcm2"
		include "src-68k/mpcm2/pcm-def.asm"
	elsecase
		include "src-68k/fmbuffer/pcm-def.asm"
	endcase
