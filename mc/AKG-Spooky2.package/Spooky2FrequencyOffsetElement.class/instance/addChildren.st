adding
addChildren
	| row2 |

	self addChild: (sliderElement := Spooky2SliderElement new 
		constraintsDo: [ :c |
			c vertical exact: 80.
			c horizontal matchParent ]).
	sliderElement valueHolder whenChangedDo: [ :newValue | self halt ].

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
			c horizontal exact: 80 ];
		background: (Color fromHexString: #'f0f0f0');
		editor: (BrTextEditor new 
			text: (self initialRange asString asRopedText fontSize: 32) )).
	maxFrequencyInput
		when: BlFocusOutEvent
		do: [ :event | self updateRange ].
	maxFrequencyInput addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateRange ]).
	maxFrequencyInput addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey tab);
		action: [ self updateRange ]).

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
		action: [ :aButton | self updateRange ]).

	self addChild: row2.