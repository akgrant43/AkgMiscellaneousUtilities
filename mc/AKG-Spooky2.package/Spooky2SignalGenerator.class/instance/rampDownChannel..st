accessing
rampDownChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel rampDown.
	self writeCommand: (channel pWaveformCommand: 2).
	self writeCommand: channel waveformCommand.