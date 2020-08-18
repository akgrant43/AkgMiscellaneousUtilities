accessing
create 

	^ GtPlotterHorizontalLabelledSparklinesAndXMarker new 
		addSparkline: self channel1Plot sparkleStencil;
		addSparkline: self channel2Plot sparkleStencil;
		xAxisScale: (GtPlotterDurationScale new domainFrom: 0 minutes to: self duration);
		xValueHolder: timeProportionHolder;
		create.
