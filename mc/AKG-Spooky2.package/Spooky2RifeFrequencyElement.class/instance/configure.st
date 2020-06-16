configuration
configure 
	| label |

	label := 'Frequency ', rifeModel channelNumber asString, ' (kHz): '.
	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 200.
					c vertical exact: 30. ];
		text: (label asRopedText fontSize: 20) ";
		look: BrGlamorousLabelLook").

	frequency := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: (rifeModel frequency asString asRopedText fontSize: 20).
	self addChild: frequency.