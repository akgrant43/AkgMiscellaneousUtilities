private
regeneratePlot

	self removeChildren.
	self addChild: (GtPlotterHorizontalLabelledSparklinesAndXMarker new 
			addSparkline: plotStencil channel1Plot sparkleStencil;
			addSparkline: plotStencil channel2Plot sparkleStencil;
			xAxisScale: (GtPlotterDurationScale new domainFrom: 0 minutes to: plotStencil runTime);
			xValueHolder: plotStencil timeProportionHolder;
			create).
