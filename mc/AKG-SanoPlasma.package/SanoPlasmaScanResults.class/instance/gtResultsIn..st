inspecting
gtResultsIn: composite
	<gtInspectorPresentationOrder: 1>

	^composite text
		title: 'Results';
		format: #asText;
		display: [ self reportText ]