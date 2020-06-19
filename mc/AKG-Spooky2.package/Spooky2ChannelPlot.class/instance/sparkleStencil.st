accessing
sparkleStencil

	^ sparkleStencil ifNil: [ sparkleStencil := GtPlotterHorizontalSparkline new
		scaleX: (GtPlotterLinearScale new domainFrom: 0 to: self points size);
		scaleDataX: #x;
		scaleY: (GtPlotterLinearScale new domainFrom: 0 to: self maxY);
		scaleDataY: #y;
		with: self data ]