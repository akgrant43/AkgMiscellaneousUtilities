initialization
initialize 

	super initialize.
	generator := Spooky2SignalGenerator new connect.
	announcer := Announcer new.
	state := #stopped.
	wobble := 0.
	random := Random new.