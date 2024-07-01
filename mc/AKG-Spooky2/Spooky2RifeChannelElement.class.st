Class {
	#name : #Spooky2RifeChannelElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'editor'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
Spooky2RifeChannelElement >> configure [
	| slider |

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

	self addChild: (Spooky2RifeVoltageElement new 
		rifeModel: rifeModel;
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent. ];
		configure ).

	slider := Spooky2FrequencyOffsetElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 120 ].
	slider valueHolder whenChangedDo: [ :newValue | rifeModel frequencyOffset: slider offset ].
	self addChild: slider.

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
					c vertical exact: 180. ];
		editor: (editor := BrTextEditor new 
			text: (rifeModel functionString asRopedText glamorousCodeFont fontSize: 28) )).

	self addChild: (BrButton new 
		look: BrGlamorousButtonWithLabelLook;
		label: 'Update Function' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self updateFunction ]).


	^ self.
]

{ #category : #private }
Spooky2RifeChannelElement >> updateFunction [

	rifeModel functionString: editor text asString.
]
