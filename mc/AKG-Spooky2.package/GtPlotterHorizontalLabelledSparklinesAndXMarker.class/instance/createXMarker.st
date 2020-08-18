as yet unclassified
createXMarker

	^ GtPlotterXMarker new
		xValueHolder: self xValueHolder;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent. ].