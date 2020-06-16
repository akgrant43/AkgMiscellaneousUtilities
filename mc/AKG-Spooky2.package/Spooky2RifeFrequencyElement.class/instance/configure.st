configuration
configure 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 170.
					c vertical exact: 30. ];
		text: ('Frequency (kHz): ' asRopedText fontSize: 20) ";
		look: BrGlamorousLabelLook").

	frequency := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: (rifeModel frequency asString asRopedText fontSize: 20).
	self addChild: frequency.