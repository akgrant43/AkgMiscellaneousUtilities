initialize
initialize

	super initialize.
	programSeconds := 1800.
	namePrefix := 'Fr'.
	namePostfix := ''.
	crossoverCount := 1.
	settings := SanoPlasmaSettings new 
						at: 'Harmonic Wobble' put: 'None';
						at: 'Out 2 Voltage Multiplier' put: '2';
						yourself.
