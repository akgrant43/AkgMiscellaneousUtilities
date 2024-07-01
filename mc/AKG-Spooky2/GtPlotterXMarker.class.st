Class {
	#name : #GtPlotterXMarker,
	#superclass : #BlElement,
	#instVars : [
		'xValueHolder'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #'hooks - children' }
GtPlotterXMarker >> onAddedToSceneGraph [ 

	super onAddedToSceneGraph.
	xValueHolder announcer when: ValueChanged send: #updateMarker to: self.
	self updateMarker.
]

{ #category : #'hooks - children' }
GtPlotterXMarker >> onRemovedFromSceneGraph [ 

	super onRemovedFromSceneGraph.
	xValueHolder announcer unsubscribe: self.
]

{ #category : #'private - events' }
GtPlotterXMarker >> updateMarker [

	self removeChildren.
	xValueHolder value ifNil: [ ^ self ].
	self addChild: (BlElement new 
		geometry: (BlNormalizedPolyline vertices: { xValueHolder value @ 0.02. xValueHolder value @ 0.98. });
		border: (BlBorder paint: Color green darker width: 4);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ]).

]

{ #category : #accessing }
GtPlotterXMarker >> xValueHolder [
	^ xValueHolder
]

{ #category : #accessing }
GtPlotterXMarker >> xValueHolder: anObject [
	xValueHolder := anObject
]
