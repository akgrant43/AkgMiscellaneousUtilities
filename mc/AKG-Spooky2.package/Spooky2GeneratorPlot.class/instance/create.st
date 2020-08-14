accessing
create 

	^ GtPlotterHorizontalLabelledSparklines new 
		addSparkline: self channel1Plot sparkleStencil;
		addSparkline: self channel2Plot sparkleStencil;
		create.
