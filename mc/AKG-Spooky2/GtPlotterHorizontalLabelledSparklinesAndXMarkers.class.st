Class {
	#name : #GtPlotterHorizontalLabelledSparklinesAndXMarkers,
	#superclass : #GtPlotterHorizontalLabelledSparklines,
	#instVars : [
		'xValueHolders'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklinesAndXMarkers >> at: anInteger putValueHolder: aValueHolder [
	"Assign the value holder for each marker"

	xValueHolders at: anInteger put: aValueHolder.
	^ aValueHolder
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalLabelledSparklinesAndXMarkers >> create [
	| container |

	container := super create.

	"Add a GtPlotterXMarker as a child of the plot area for each x-marker"
	xValueHolders do: [ :each |
		container children first addChild: (self createXMarkerFor: each) ].

	^ container
]

{ #category : #private }
GtPlotterHorizontalLabelledSparklinesAndXMarkers >> createXMarkerFor: aValueHolder [

	^ GtPlotterXMarker new
		xValueHolder: aValueHolder;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent. ].
]

{ #category : #configuration }
GtPlotterHorizontalLabelledSparklinesAndXMarkers >> xMarkerCount: aNumber [
	"Set the number of X markers to use"

	self assert: xValueHolders isNil.
	xValueHolders := Array new: aNumber.
]
