inspecting
gtInspectEditIn: composite
	<gtInspectorPresentationOrder: 3>

	^ composite spec
		title: 'Edit';
		display: [:arg1 | 
			SanoPlasmaChainUI new
				chain: arg1;
				buildWithSpec;
				yourself ].