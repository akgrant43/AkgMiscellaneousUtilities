inspecting
gtInspectEditIn: composite
	<gtInspectorPresentationOrder: 3>

	^ composite spec
		title: 'Edit';
		display: [:arg1 | 
			SanoPlasmaSettingsUI new
				settings: arg1;
				buildWithSpec;
				yourself ].