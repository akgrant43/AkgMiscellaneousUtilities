private - button actions
doPause

	rifeModel isPaused ifTrue: 
		[ rifeModel unpause.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel pause.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color red ].
	self setButtonState.
