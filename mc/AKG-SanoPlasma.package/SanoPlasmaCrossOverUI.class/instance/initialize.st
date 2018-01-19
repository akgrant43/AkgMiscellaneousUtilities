initialization
initialize

	super initialize.
	frequencyRange := SanoPlasmaFrequencyRange new.
	program := SanoPlasmaProgram new 
					addFrequency: frequencyRange;
					yourself.
	self settings: SanoPlasmaSettings new.
