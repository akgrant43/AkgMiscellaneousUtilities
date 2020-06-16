initialization
initialize 

	super initialize.
	generator := Spooky2SignalGeneratorSimulator new.
	channelModels := Array new: 2.
	channelModels at: 1 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 1).
	channelModels at: 2 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 2).
