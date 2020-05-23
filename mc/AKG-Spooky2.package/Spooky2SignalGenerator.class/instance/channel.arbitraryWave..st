accessing
channel: channelNumber arbitraryWave: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel arbitraryWave: aNumber.
	self writeCommand: channel waveformCommand.