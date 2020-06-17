private - button actions
doPause

	rifeModel isPaused
		ifTrue: [ rifeModel unpause ]
		ifFalse: [ rifeModel pause ].
	self setButtonState.
