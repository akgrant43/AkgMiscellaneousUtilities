accessing
switchOffChannel: channelNumber
	| channel |
	
	channel := channels at: channelNumber.
	self writeCommand: channel offCommand.