ui
generatorControlFor: aView
	<gtView>

	^aView explicit 
		title: 'Generator';
		priority: 10;
		stencil: [ Spooky2RifeModelElement new rifeModel: self; configure ]