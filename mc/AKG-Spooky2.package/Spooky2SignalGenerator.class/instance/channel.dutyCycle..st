accessing
channel: channelNumber dutyCycle: aNumber
	| channel |
	
	channel := channels at: channelNumber.
	channel dutyCycle: aNumber.
	self writeCommand: channel dutyCycleCommand.