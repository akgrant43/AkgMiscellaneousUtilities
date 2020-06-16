private - button actions
doPlay

	rifeModel isStopped ifFalse: [ ^ self ].

	rifeModel start.
	self setButtonState.
