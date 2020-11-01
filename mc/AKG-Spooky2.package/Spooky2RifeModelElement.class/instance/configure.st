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
		rifeModel: rifeModel channelModels first;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeFrequencyElement new
		rifeModel: rifeModel channelModels second;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeRunTimeElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	self addChild: (Spooky2RifeControlButtonsElement new 
		rifeModel: rifeModel;
		padding: (BlInsets top: 20 right: 0 bottom: 20 left: 10);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	^ self.