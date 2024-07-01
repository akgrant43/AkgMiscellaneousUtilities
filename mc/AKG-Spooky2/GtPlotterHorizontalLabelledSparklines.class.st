"
GtPlotterHorizontalLabelledSparklines plots a graph with one or more sparklines and common x- and y- axis.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	sparklines:		<Object>
	xAxisData:		<Object>
	xAxisScale:		<Object>
	yAxisData:		<Object>
	yAxisScale:		<Object>


    Implementation Points
"
Class {
	#name : #GtPlotterHorizontalLabelledSparklines,
	#superclass : #GtPlotterBuilder,
	#instVars : [
		'sparklines',
		'xAxisScale',
		'xAxisData',
		'yAxisScale',
		'yAxisData'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
GtPlotterHorizontalLabelledSparklines >> addSparkline: aSparkline [

	sparklines := sparklines copyWith: aSparkline.
]

{ #category : #'api - instantiation' }
GtPlotterHorizontalLabelledSparklines >> create [ 
	| plotAndXAxis plotArea |

	plotArea := BlElement new 
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].
	plotArea addChild: self plotGrid.
	plotArea addChildren: (sparklines collect: [ :each | 
		each create
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent. ] ]).

	plotAndXAxis := BlElement new 
		layout: BlLinearLayout vertical;
		clipChildren: false;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent. ].

	plotAndXAxis
		addChild: plotArea;
		addChild: self createXAxis.

	^ plotAndXAxis
]

{ #category : #private }
GtPlotterHorizontalLabelledSparklines >> createXAxis [
	| tickLabelLook tickLabelColor |

	tickLabelLook := [ BrGlamorousLabelLook new glamorousRegularFontAndSize ] asStencil.
	tickLabelColor := Color gray.
	^ GtPlotterHorizontalTickLabelsElement new
		clipChildren: false;
		scale: xAxisScale;
		"padding: (BlInsets left: self barLabelWidth + self gridlineOffset);"
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical exact: 50 ];
		labelFormat: [ :aTickObject | aTickObject printString ];
		labelElement: [ :aGtPlotterScaleContext |
			BrLabel new
				look: (tickLabelLook create foreground: tickLabelColor);
				text: (aGtPlotterScaleContext scale formattedTick: aGtPlotterScaleContext originalValue) ];
		labels: 3
]

{ #category : #initialization }
GtPlotterHorizontalLabelledSparklines >> initialize [ 

	super initialize.
	sparklines := Array new.
]

{ #category : #private }
GtPlotterHorizontalLabelledSparklines >> plotGrid [
	"Answer an element which is the grid"

	^ BlElement new
			geometry: (BlNormalizedPolyline 
				vertices: { 0@0. 1@0. 1@1. 0@1. 0@0. });
			border: (BlBorder paint: Color black width: 2);
			outskirts: BlOutskirts centered;
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].

]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> xAxisData [
	^ xAxisData
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> xAxisData: anObject [
	xAxisData := anObject
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> xAxisScale [
	^ xAxisScale
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> xAxisScale: anObject [
	xAxisScale := anObject
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> yAxisData [
	^ yAxisData
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> yAxisData: anObject [
	yAxisData := anObject
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> yAxisScale [
	^ yAxisScale
]

{ #category : #accessing }
GtPlotterHorizontalLabelledSparklines >> yAxisScale: anObject [
	yAxisScale := anObject
]
