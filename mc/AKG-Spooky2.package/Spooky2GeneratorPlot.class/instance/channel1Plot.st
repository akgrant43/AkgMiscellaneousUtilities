accessing
channel1Plot
	^ channel1Plot ifNil: 
		[ channel1Plot := Spooky2ChannelPlot new 
			programme: rifeModel channelModels first function;
			runTime: rifeModel runTime;
			channelNumber: 1 ]