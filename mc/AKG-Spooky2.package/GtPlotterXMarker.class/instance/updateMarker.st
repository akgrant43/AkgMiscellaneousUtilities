private - events
updateMarker

	self removeChildren.
	self addChild: (BlElement new 
		geometry: (BlNormalizedPolyline vertices: { xValueHolder value @ 0.02. xValueHolder value @ 0.98. });
		border: (BlBorder paint: Color green darker width: 4);
		outskirts: BlOutskirts centered;
		constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ]).
