accessing
channel: channelNumber phase: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel phase: aNumber.
	self writeCommand: channel phaseCommand.