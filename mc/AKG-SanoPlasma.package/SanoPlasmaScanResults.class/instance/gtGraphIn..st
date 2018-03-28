inspecting
gtGraphIn: composite
	<gtInspectorPresentationOrder: 2>

	composite roassal2
		title: 'Graph';
		initializeView: [ self graph ];
		when: [ self scanData isNotNil ]