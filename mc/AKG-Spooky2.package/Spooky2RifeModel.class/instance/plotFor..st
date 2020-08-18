ui
plotFor: aView
	<gtView>

	^aView explicit 
		title: 'Generator';
		priority: 50;
		stencil: ( Spooky2GeneratorPlot new rifeModel: self )