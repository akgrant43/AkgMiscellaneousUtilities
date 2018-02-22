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

	chainUI := self instantiate: SanoPlasmaChainUI.