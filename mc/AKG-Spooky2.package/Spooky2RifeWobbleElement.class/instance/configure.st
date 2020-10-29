configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 200.
					c vertical fitContent. ];
		text: ('Wobble (Hz):' asRopedText fontSize: 32)).

	wobble := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		background: self inputBackgroundColor;
		editor: (BrTextEditor new 
			text: (rifeModel wobble asString asRopedText fontSize: 32)).
	wobble addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateWobble ]).
	self addChild: wobble.
