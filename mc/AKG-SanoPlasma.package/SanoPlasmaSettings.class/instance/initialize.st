initialization
initialize

	super initialize.
	"out2Voltage := 12."
	self at: 'Out 1 Freq. Limit Max.' put: 900000.
	self at: 'Out 1 Freq. Limit Min.' put: 1.
