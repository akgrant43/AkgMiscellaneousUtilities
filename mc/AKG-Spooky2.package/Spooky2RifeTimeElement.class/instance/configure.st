configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 170.
					c vertical exact: 30. ];
		text: ('Time: ' asRopedText fontSize: 20) ";
		look: BrGlamorousLabelLook").

	time := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: ('Not Started' asRopedText fontSize: 20).
	self addChild: time.