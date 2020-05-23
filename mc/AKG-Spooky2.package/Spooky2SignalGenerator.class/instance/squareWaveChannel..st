accessing
squareWaveChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel squareWave.
	self writeCommand: channel waveformCommand.