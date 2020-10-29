private - button actions
doHold
	| label |

	label := 'Hold' asRopedText.
	rifeModel isHeld ifTrue: 
		[ rifeModel unhold.
		(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel hold.
		label := 'Hold' asRopedText.
		(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color red ].
	hold label: label.
	self setButtonState.
