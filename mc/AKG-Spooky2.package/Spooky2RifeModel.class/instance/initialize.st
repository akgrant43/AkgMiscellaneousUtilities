initialization
initialize 

	super initialize.
	generator := Spooky2SignalGeneratorSimulator new.
	generator connect.
	state := #stopped.
	channelModels := Array new: 2.
	channelModels at: 1 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 1).
	channelModels first
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	channelModels at: 2 put: 
		(Spooky2RifeChannelModel new
			generator: generator;
			channelNumber: 2).
	channelModels second
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	runTime := 60 minutes.