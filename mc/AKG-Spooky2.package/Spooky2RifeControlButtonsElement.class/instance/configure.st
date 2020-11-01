configuration
configure

	play := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Play' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPlay ].
	self addChild: play.

	pause := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Pause' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPause ].
	self addChild: pause.

	hold := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		vFitContent;
		hExact: 150;
		look: BrGlamorousButtonWithLabelLook;
		label: 'Hold' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doHold ].
	self addChild: hold.

	wobble := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Wobble' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doWobble ].
	self addChild: wobble.

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