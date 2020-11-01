initialization
initialize 

	super initialize.
	generator := Spooky2SignalGenerator findPort
		ifNil: [ Spooky2SignalGeneratorSimulator new ]
		ifNotNil: [ Spooky2SignalGenerator new ].
	generator connect.
	state := #stopped.
	channelModels := Array new: 2.
	channelModels at: 1 put: 
		(Spooky2RifeChannelModel new
			rifeModel: self;
			generator: generator;
			channelNumber: 1;
			label: 'Plasma').
	channelModels first
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	channelModels at: 2 put: 
		(Spooky2RifeChannelModel new
			rifeModel: self;
			generator: generator;
			channelNumber: 2;
			label: 'Contacts').
	channelModels second
		when: Spooky2ParameterChanged
		do: [ :announcement | self announce: announcement ].
	runTime := 60 minutes.
	isWobbling := false.
	wobbleFunction := Spooky2TriangleWave new period: 30 seconds.