accessing
channel: channelNumber arbitraryWave: aNumber
	"Set the channel to the given arbitrary wave number"
	| channel |
	
	channel := channels at: channelNumber.
	channel arbitraryWave: aNumber.
	self writeCommand: channel waveformCommand.