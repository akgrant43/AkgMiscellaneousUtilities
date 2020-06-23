accessing
channel2Plot
	^ channel2Plot ifNil: 
		[ channel2Plot := Spooky2ChannelPlot new 
			programme: rifeModel channelModels second function;
			runTime: rifeModel runTime;
			channelNumber: 2 ]