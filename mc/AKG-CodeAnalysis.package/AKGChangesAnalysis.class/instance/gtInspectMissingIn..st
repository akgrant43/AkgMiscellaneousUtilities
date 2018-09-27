inspecting
gtInspectMissingIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Missing';
		display: [ self missing ];
		format: [ :each | each gtDisplayString ]