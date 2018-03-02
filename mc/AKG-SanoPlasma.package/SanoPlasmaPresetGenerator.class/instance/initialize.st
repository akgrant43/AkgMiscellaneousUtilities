initialize
initialize

	super initialize.
	programSeconds := 1800.
	namePrefix := 'Fr'.
	namePostfix := ''.
	presetTemplate := self class defaultTemplate.
	settings := SanoPlasmaSettings new 
						at: 'Harmonic Wobble' put: 'None';
						at: 'Out 2 Voltage Multiplier' put: '2';
						yourself.
