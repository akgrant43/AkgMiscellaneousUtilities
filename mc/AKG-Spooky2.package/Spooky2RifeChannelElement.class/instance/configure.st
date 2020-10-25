configuration
configure

	self 
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].

	self addChild: (Spooky2RifeTimeElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeFrequencyElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeWobbleElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeVoltageElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeChannelControlButtonsElement new 
		rifeModel: rifeModel;
		padding: (BlInsets top: 20 right: 0 bottom: 20 left: 40);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (BrLabel new 
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		padding: (BlInsets all: 5);
		text: 'Function:';
		look: BrGlamorousLabelLook).

	self addChild: (BrEditorElement new 
		padding: (BlInsets all: 5);
		margin: (BlInsets all: 5);
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 100. ];
		editor: (editor := BrTextEditor new 
			text: (rifeModel functionString asRopedText glamorousCodeFontAndSize) )).

	self addChild: (BrButton new 
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Update Function' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self updateFunction ]).


	^ self.