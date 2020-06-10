configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical fitContent. ];
		text: 'Wobble (%):' asRopedText).

	self addChild: (BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: rifeModel wobble asString asRopedText )).

