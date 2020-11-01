initialization
initialize 

	super initialize.
	announcer := Announcer new.
	state := #stopped.
	random := Random new.
	voltage := 6.
	timeOffset := Duration zero.