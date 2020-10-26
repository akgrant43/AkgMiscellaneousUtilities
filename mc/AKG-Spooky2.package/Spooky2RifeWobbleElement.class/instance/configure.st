configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		text: 'Wobble (Hz):' asRopedText).

	wobble := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: rifeModel wobble asString asRopedText).
	wobble addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateWobble ]).
	self addChild: wobble.
