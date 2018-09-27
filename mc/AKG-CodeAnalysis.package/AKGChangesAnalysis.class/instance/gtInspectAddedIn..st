inspecting
gtInspectAddedIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Added';
		display: [ self added ];
		format: [ :each | each gtDisplayString ]