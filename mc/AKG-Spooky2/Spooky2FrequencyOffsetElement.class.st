Class {
	#name : #Spooky2FrequencyOffsetElement,
	#superclass : #BlElement,
	#instVars : [
		'sliderElement',
		'maxFrequencyInput',
		'resetButton',
		'range'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #adding }
Spooky2FrequencyOffsetElement >> addChildren [
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
			c horizontal exact: 80 ];
		background: (Color fromHexString: #'f0f0f0');
		editor: (BrTextEditor new 
			text: (self initialRange asString asRopedText fontSize: 32) )).
	maxFrequencyInput
		when: BlKeyUpEvent
		do: [ :event | self updateRange ].

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
]

{ #category : #initialization }
Spooky2FrequencyOffsetElement >> initialRange [

	^ 100
]

{ #category : #initialization }
Spooky2FrequencyOffsetElement >> initialize [

	super initialize.

	self layout: BlLinearLayout vertical.
	self addChildren.
	self updateRange.
]

{ #category : #accessing }
Spooky2FrequencyOffsetElement >> offset [ 
	"Answer the offset in Hz"

	^ (sliderElement valueHolder value - 0.5) * range * 2
]

{ #category : #private }
Spooky2FrequencyOffsetElement >> updateRange [

	[ range := maxFrequencyInput editor text asString. 
	(NumberParser isNumber: range) ifTrue:
		[ range := range asNumber.
		sliderElement 
			startValue: 0 - range;
			endValue: range;
			regeneratePlot.
		maxFrequencyInput background: (Color fromHexString: #'f0f0f0').
		sliderElement valueHolder value: 0.5 ]
	ifFalse:
		[ StringSignal emit: 'phooey 2'.
		maxFrequencyInput background: (Color fromHexString: #'f00000'). ] ]
		on: Error 
		do: [ :ex | StringSignal emit: 'phooey'.
			maxFrequencyInput background: (Color fromHexString: #'f00000').
			maxFrequencyInput invalidate ].

]

{ #category : #accessing }
Spooky2FrequencyOffsetElement >> valueHolder [ 


	^ sliderElement valueHolder
]
