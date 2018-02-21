initialization
initializeWidgets

	Transcript show: 'initializeWidgets'; cr.
	currentSelection := Array new: 4.
	inRebuild := false.
	menuBar := self createMenu.
	
	dtLabel := self newLabel
		label: 'Directory';
		yourself.
	flLabel := self newLabel
		label: 'Chains (Files)';
		yourself.
	plLabel := self newLabel
		label: 'Presets';
		yourself.
	pslLabel := self newLabel
		label: 'Settings / Programs';
		yourself.

	directoryTree := self newTree.
	directoryTree
		multiSelection: false;
		autoDeselection: false;
		displayBlock: [ :item | item basename ];
		childrenBlock: [ :item | item directories ];
		whenSelectedItemChanged: [ :selection | self directorySelected: selection ].

	filesList := self newList.
	filesList
		displayBlock: [ :item | item basename ];
		whenSelectedItemChanged: [ :selection | self fileSelected: selection ].

	presetsList := self newList.
	presetsList
		displayBlock: [ :item | item name ];
		whenSelectedItemChanged: [ :selection | self presetSelected: selection ].

	programsSettingsList := self newList.
	programsSettingsList 
		displayBlock: [ :item | item displayString ];
		whenSelectedItemChanged: [ :selection | self spSelected: selection ].

	programSettingsEditor := self emptyEditor.