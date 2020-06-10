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

	play := BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Play' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPlay ].
	self addChild: play.

	forward := BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: '>' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doForward ].
	self addChild: forward.

	stop := BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Stop' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doStop ].
	self addChild: stop.

	^ self.