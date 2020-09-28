configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		text: 'Voltage (V):' asRopedText).

	voltage := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: rifeModel voltage asString asRopedText ).
	voltage addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateVoltage ]).
	self addChild: voltage.