inspecting
gtInspectRemovedIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Removed';
		display: [ self removed ];
		format: [ :each | each gtDisplayString ]