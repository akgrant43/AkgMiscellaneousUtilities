private
regeneratePlot
	| graph |

	self removeChildNamed: #graph.
	graph := GtPlotterHorizontalLabelledSparklinesAndXMarkers new 
			xMarkerCount: 1;
			xAxisScale: (GtPlotterLinearScale new domainFrom: startValue to: endValue);
			at: 1 putValueHolder: valueHolder;
			yourself.
	self addChildFirst: graph create as: #graph.
	valueHolder value: valueHolder value.