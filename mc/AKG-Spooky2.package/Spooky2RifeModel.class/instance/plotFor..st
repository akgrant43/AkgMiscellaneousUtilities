ui
plotFor: aView
	<gtView>

	^aView explicit 
		title: 'Graph';
		priority: 50;
		stencil: ( Spooky2GeneratorPlot new rifeModel: self )