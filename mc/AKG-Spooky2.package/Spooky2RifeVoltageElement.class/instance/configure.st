configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 200.
					c vertical fitContent. ];
		text: ('Voltage (V):' asRopedText fontSize: 32)).

	voltage := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		editor: (BrTextEditor new 
			text: (rifeModel voltage asString asRopedText fontSize: 32)).

	rifeModel channelNumber = 1 ifTrue: 
		[ voltage editor beReadOnlyWithoutSelection ]
	ifFalse:
		[ voltage
			when: BlKeyUpEvent 
			do: [ :event | self updateVoltage ].
		voltage background: self inputBackgroundColor ].
	self addChild: voltage.