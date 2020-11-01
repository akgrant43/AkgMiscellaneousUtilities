adding
addChildren
	| row2 |

	self addChild: (sliderElement := Spooky2SliderElement new 
		constraintsDo: [ :c |
			c vertical exact: 80.
			c horizontal matchParent ]).

	row2 := BlElement new 
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		layout: BlLinearLayout horizontal.

	row2 addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 35.
					c vertical fitContent. ];
		margin: (BlInsets top: 5);
		text: ('+/-' asRopedText fontSize: 26)).

	row2 addChild: (maxFrequencyInput := BrEditorElement new 
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal matchParent ];
		background: (Color fromHexString: #'f0f0f0');
		editor: (BrTextEditor new 
			text: ('100' asRopedText fontSize: 32) )).
	maxFrequencyInput
		when: BlFocusOutEvent
		do: [ :event | | hz |
			hz := maxFrequencyInput editor text asString asNumber. 
			sliderElement 
				startValue: 0 - hz;
				endValue: hz;
				regeneratePlot.
				sliderElement valueHolder value: 0.5 ].

	row2 addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 50.
					c vertical fitContent. ];
		margin: (BlInsets top: 5 left: 5);
		text: ('Hz' asRopedText fontSize: 26)).

	row2 addChild: (resetButton := BrButton new 
		hExact: 100;
		vMatchParent;
		margin: (BlInsets top: 5 left: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Reset';
		action: [ :aButton | sliderElement valueHolder value: 0.5 ]).

	self addChild: row2.