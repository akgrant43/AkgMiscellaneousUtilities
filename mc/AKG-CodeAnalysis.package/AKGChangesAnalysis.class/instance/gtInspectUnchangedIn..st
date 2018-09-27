inspecting
gtInspectUnchangedIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Unchanged';
		display: [ self unchanged ];
		format: [ :each | each gtDisplayString ]