inspecting
gtInspectEditIn: composite
	<gtInspectorPresentationOrder: 3>

	^ composite spec
		title: 'Edit';
		display: [:arg1 | 
			SanoPlasmaChainEditorUI new
				chain: arg1;
				buildWithSpec;
				yourself ].