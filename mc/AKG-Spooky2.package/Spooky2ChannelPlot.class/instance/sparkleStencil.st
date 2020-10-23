accessing
sparkleStencil

	^ GtPlotterHorizontalSparkline new
		scaleX: (GtPlotterLinearScale new domainFrom: 0 to: self xPointCount);
		scaleDataX: #x;
		scaleY: (GtPlotterLinearScale new domainFrom: self minY to: self maxY);
		scaleDataY: #y;
		with: self data