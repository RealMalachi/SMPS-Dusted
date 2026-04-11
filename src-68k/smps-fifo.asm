UpdateFIFO:
	if __smpsTarget=="pico"
	rts
	elseif __smpsTarget=="copera"
	rts
	else
	SMPS_assert "Driver has no FIFO"
	endif
