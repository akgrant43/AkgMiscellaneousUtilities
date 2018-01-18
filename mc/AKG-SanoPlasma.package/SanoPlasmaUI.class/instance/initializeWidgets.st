initialization
initializeWidgets

	menuBar := self createMenu.

	directoryTree := self newTree.
	directoryTree
		multiSelection: false;
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
		displayBlock: [ :item | item displayString ].
