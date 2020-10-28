configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 170.
					c vertical exact: 30. ];
		text: ('Time: ' asRopedText fontSize: 32)).

	time := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: ('Not Started' asRopedText fontSize: 32).
	self addChild: time.