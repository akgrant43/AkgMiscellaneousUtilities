actions
pause 

	state = #running ifFalse: [ ^ self ].
	state := #paused.