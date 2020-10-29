configuration
configure

	play := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Play' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPlay ].
	self addChild: play.

	backward := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: '<' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doBackward ].
	self addChild: backward.

	pause := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Pause' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPause ].
	self addChild: pause.

	hold := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Hold' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doHold ].
	self addChild: hold.

	forward := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: '>' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doForward ].
	self addChild: forward.

	stop := BrButton new 
		beHuge;
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Stop' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doStop ].
	self addChild: stop.

	self setButtonState.

	^ self.