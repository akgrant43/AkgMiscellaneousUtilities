operating
unpause 

	state = #paused ifFalse: [ ^ self ].
	state := #running.