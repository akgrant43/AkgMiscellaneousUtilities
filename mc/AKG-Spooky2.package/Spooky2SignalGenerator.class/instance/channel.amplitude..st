accessing
channel: channelNumber amplitude: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel amplitude: aNumber.
	self writeCommand: channel amplitudeCommand.