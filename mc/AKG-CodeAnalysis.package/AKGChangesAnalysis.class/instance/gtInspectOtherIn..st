inspecting
gtInspectOtherIn: composite
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Other';
		display: [ self other ];
		format: [ :each | each gtDisplayString ]