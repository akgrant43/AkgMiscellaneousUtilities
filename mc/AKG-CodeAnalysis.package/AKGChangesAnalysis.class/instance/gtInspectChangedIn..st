inspecting
gtInspectChangedIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Changed';
		display: [ self changed ];
		format: [ :each | each gtDisplayString ]