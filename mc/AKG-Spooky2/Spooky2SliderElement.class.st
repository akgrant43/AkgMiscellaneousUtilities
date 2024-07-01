Class {
	#name : #Spooky2SliderElement,
	#superclass : #BlElement,
	#instVars : [
		'startValue',
		'endValue',
		'valueHolder'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #accessing }
Spooky2SliderElement >> endValue [
	^ endValue
]

{ #category : #accessing }
Spooky2SliderElement >> endValue: anObject [
	endValue := anObject
]

{ #category : #initialization }
Spooky2SliderElement >> initialize [

	super initialize.
	valueHolder := NewValueHolder new value: 0.
	startValue := -1.
	endValue := 1.

	self regeneratePlot.

	self 
		when: BlClickEvent
		do: [ :event | self processClickEvent: event ].
]

{ #category : #'private - event handling' }
Spooky2SliderElement >> processClickEvent: event [
	"Set the value holder based on where the user clicked"
	| percentage |

	percentage := ((event position x - self boundsInWindow origin x) /
				(self bounds extent x)) asFloat.

	valueHolder value: percentage.

]

{ #category : #private }
Spooky2SliderElement >> regeneratePlot [
	| graph |

	self removeChildNamed: #graph.
	graph := GtPlotterHorizontalLabelledSparklinesAndXMarkers new 
			xMarkerCount: 1;
			xAxisScale: (GtPlotterLinearScale new domainFrom: startValue to: endValue);
			at: 1 putValueHolder: valueHolder;
			yourself.
	self addChildFirst: (graph create clipChildren: false)
			as: #graph.
	valueHolder value: valueHolder value.
]

{ #category : #accessing }
Spooky2SliderElement >> startValue [
	^ startValue
]

{ #category : #accessing }
Spooky2SliderElement >> startValue: anObject [
	startValue := anObject
]

{ #category : #accessing }
Spooky2SliderElement >> valueHolder [

	^ valueHolder
]
