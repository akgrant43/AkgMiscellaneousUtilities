accessing
channel: channelNumber frequency: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel frequency: aNumber.
	self writeCommand: channel frequencyCommand.