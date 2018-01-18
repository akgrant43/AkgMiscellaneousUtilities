tests
testDefaults

	| settings |
	
	settings := SanoPlasmaSettings new.
	self assert: (settings at: #out1FreqLimitMax) equals: 900000.
	self assert: (settings at: #out1FreqLimitMin) equals: 1.
	"self assert: (settings at: #out2Voltage) equals: 12."