configuration
configure

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 180.
					c vertical fitContent. ];
		text: ('Run Time:' asRopedText fontSize: 32)).

	runTime := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 250.
					c vertical fitContent. ];
		background: self inputBackgroundColor;
		editor: (BrTextEditor new 
			text: '<not set>' asString asRopedText).
	runTime addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateRunTime ]).
	self addChild: runTime.

	rifeModel ifNotNil: [ self updateModel ].