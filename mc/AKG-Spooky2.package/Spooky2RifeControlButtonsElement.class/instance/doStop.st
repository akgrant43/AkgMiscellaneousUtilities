private - button actions
doStop

	rifeModel isStopped ifTrue: [ ^self ].

	rifeModel stop.
	self setButtonState.