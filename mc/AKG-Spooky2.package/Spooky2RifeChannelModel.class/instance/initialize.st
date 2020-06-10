initialization
initialize 

	super initialize.
	announcer := Announcer new.
	state := #stopped.
	wobble := 0.
	random := Random new.
	voltage := 6.
