initialization
initialize

	super initialize.
	"out2Voltage := 12."
	self at: #out1FreqLimitMax put: 900000.
	self at: #out1FreqLimitMin put: 1.
