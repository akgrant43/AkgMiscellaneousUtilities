Class {
	#name : #GtPlotterHorizontalLabelledSparklinesAndXMarker,
	#superclass : #GtPlotterHorizontalLabelledSparklines,
	#instVars : [
		'xValueHolder'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #'api - instantiation' }
GtPlotterHorizontalLabelledSparklinesAndXMarker >> create [
	| container |

	container := super create.

	"Add a GtPlotterXMarker as a child of the plot area"
	container children first addChild: self createXMarker.

	^ container
]

{ #category : #'as yet unclassified' }
GtPlotterHorizontalLabelledSparklinesAndXMarker >> createXMarker [

	^ GtPlotterXMarker new
		xValueHolder: self xValueHolder;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent. ].
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklinesAndXMarker >> xValueHolder [
	^ xValueHolder
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklinesAndXMarker >> xValueHolder: anObject [
	xValueHolder := anObject
]
