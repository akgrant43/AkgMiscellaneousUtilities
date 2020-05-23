accessing
channel: channelNumber offset: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel offset: aNumber.
	self writeCommand: channel offsetCommand.