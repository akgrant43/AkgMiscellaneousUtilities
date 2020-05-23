accessing
sineWaveChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel sineWave.
	self writeCommand: channel waveformCommand.