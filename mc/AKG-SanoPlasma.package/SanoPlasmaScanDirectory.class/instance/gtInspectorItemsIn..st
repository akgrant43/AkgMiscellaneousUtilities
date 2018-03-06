inspecting
gtInspectorItemsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ composite fastTable 
		title: 'Results';
		display: [ self sortedFiles ];
		column: 'Name' evaluated: [:each | each basename ] width: 400;
		column: 'Size' evaluated: [:each | each humanReadableSize] width: 100;
		column: 'Modified' evaluated: [ :each | 
			String streamContents: [:s | 
				each modificationTime printYMDOn: s.
				s nextPut: Character space.
				each creationTime printHMSOn: s ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousFolder ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: [self directory isDirectory and: [self directory hasChildren]];
		selectionAct: [:table | table selection delete. table update] entitled: 'Delete';
		act: [ :table |
			 (UIManager default request: 'New Directory name?' initialAnswer: '') 
					ifNotNil: [:name | (self directory / name) ensureCreateDirectory ].
			 table update
			 ] icon: GLMUIThemeExtraIcons glamorousFolder entitled: 'Create Directory';		
		act: [ :table |
			 (UIManager default request: 'New File name?' initialAnswer: '') 
					ifNotNil: [:name | (self directory / name) ensureCreateFile ].
			 table update
			 ] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Create File';		
		act: [ :table | table update ] icon: GLMUIThemeExtraIcons glamorousRefresh entitled: 'Refresh';
		send: [ :selection | SanoPlasmaScanResults on: selection ]