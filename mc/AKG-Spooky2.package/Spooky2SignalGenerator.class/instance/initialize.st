initialization
initialize 

	super initialize.
	writeSemaphore := Semaphore new signal.
	channels := { 
		Spooky2Channel new channel: 1.
		Spooky2Channel new channel: 2 }.
