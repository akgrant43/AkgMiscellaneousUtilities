accessing
rampUpChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel rampUp.
	self writeCommand: (channel pWaveformCommand: 1).
	self writeCommand: channel waveformCommand.