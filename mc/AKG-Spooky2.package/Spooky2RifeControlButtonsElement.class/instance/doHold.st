private - button actions
doHold
	| label |

	label := 'Hold' asRopedText.
	rifeModel isHeld ifTrue: 
		[ rifeModel unhold ]
	ifFalse: 
		[ rifeModel hold.
		label := '*Hold*' asRopedText.
		label foreground: Color red ].
	hold label: label.
	self setButtonState.
