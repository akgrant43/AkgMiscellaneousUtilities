initialization
initialize 

	super initialize.
	generator := Spooky2SignalGenerator new.
	steps := 4.
	stepFrequency := 200.
	amplitude1 := 2.
	amplitude2 := 2.