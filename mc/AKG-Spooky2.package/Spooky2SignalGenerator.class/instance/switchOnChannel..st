accessing
switchOnChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	self writeCommand: channel onCommand.