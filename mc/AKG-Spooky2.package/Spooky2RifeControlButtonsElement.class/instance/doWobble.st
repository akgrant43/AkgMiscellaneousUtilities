private - button actions
doWobble

	rifeModel isWobbling ifTrue: 
		[ rifeModel stopWobble.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel startWobble.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color green ].
	self setButtonState.
