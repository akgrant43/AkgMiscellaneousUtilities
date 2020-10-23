initialization
initialize 

	super initialize.
	announcer := Announcer new.
	generator := Spooky2SignalGeneratorSimulator new.
	generator connect.
	state := #stopped.
	channelModels := Array new: 2.
	channelModels at: 1 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 1).
	channelModels at: 2 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 2).
	runTime := 60 minutes.