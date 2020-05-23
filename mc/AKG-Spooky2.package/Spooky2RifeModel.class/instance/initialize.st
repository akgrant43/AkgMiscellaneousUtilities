initialization
initialize 

	super initialize.
	generator := Spooky2SignalGenerator new connect.
	announcer := Announcer new.
	pauseBoolean := false.
	pauseSemaphore := Semaphore new.