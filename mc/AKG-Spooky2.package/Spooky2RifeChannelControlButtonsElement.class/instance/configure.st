configuration
configure

	backward := BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: '<' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doBackward ].
	self addChild: backward.

	forward := BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: '>' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doForward ].
	self addChild: forward.

	self setButtonState.

	^ self.