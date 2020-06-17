actions
pause 

	state = #running ifFalse: [ ^ self ].
	self switchOffChannel.
	super pause.