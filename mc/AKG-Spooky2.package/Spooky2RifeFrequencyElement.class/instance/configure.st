configuration
configure 
	| label |

	label := rifeModel label, ' (kHz): '.
	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 250.
					c vertical exact: 30. ];
		text: ((label asRopedText fontSize: 32) foreground: rifeModel suggestedColor)).

	frequency := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: (rifeModel frequency asString asRopedText fontSize: 32).
	self addChild: frequency.