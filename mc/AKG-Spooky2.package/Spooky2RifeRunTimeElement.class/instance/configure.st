configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		text: 'Run Time:' asRopedText).

	runTime := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: '60 minutes' asString asRopedText).
	runTime addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateRunTime ]).
	self addChild: runTime.
