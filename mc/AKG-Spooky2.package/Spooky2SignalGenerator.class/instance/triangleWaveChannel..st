accessing
triangleWaveChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel triangleWave.
	self writeCommand: channel waveformCommand.