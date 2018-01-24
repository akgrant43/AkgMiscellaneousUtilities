inspecting
gtInspectIn: composite
	<gtInspectorPresentationOrder: 2>

	^ composite text
		title: 'Summary';
		format: #asText;
		display: [self descriptionText].