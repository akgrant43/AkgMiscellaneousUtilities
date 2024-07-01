"
Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	plotStencil:		<Spooky2GeneratorPlot>


!!!Implementation Points
"
Class {
	#name : #Spooky2TimePlotElement,
	#superclass : #BlElement,
	#instVars : [
		'plotStencil'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #initialize }
Spooky2TimePlotElement >> initialize [

	super initialize.
	self 
		when: BlClickEvent
		do: [ :event | self processClickEvent: event ]
]

{ #category : #accessing }
Spooky2TimePlotElement >> plotStencil [
	^ plotStencil
]

{ #category : #accessing }
Spooky2TimePlotElement >> plotStencil: anObject [

	plotStencil := anObject.
	self regeneratePlot.
	self rifeModel 
				when: Spooky2ParameterChanged 
				do: [ self regeneratePlot ]
]

{ #category : #'private - event handling' }
Spooky2TimePlotElement >> processClickEvent: event [
	"Set the time based on where the user clicked"
	| percentage time |

	percentage := ((event position x - self bounds position x) /
				(self bounds extent x)) asFloat.
	time := self rifeModel runTime * percentage.
	self rifeModel adjustTime: time - self rifeModel time.
]

{ #category : #private }
Spooky2TimePlotElement >> regeneratePlot [

	plotStencil reset.
	self removeChildren.
	self addChild: (GtPlotterHorizontalLabelledSparklinesAndXMarker new 
			addSparkline: plotStencil channel1Plot sparkleStencil;
			addSparkline: plotStencil channel2Plot sparkleStencil;
			xAxisScale: (GtPlotterDurationScale new domainFrom: 0 minutes to: plotStencil runTime);
			xValueHolder: plotStencil timeProportionHolder;
			create).

]

{ #category : #accessing }
Spooky2TimePlotElement >> rifeModel [ 

	^ plotStencil rifeModel
]
