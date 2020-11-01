private
createXMarkerFor: aValueHolder

	^ GtPlotterXMarker new
		xValueHolder: aValueHolder;
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent. ].