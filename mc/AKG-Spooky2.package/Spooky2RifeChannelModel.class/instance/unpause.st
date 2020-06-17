actions
unpause 

	state = #paused ifFalse: [ ^ self ].
	self switchOnChannel.
	super unpause.