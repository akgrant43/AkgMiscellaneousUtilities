operating
pause 

	state = #running ifFalse: [ ^ self ].
	state := #paused.