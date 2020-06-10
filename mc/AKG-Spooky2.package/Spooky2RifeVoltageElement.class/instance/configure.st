configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		text: 'Voltage (V):' asRopedText).

	self addChild: (BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 100.
					c vertical exact: 14. ];
		editor: (BrTextEditor new 
			text: rifeModel voltage asString asRopedText )).
