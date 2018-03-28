initialization
initializeWidgets

	menu := self createMenu.
	inRebuild := false.

	directoryList := self newMultiColumnList
		displayBlock: [ :entry | self columnsFor: entry ];
		whenSelectedItemChanged: [ :selection | self selectedReport: selection ];
		yourself.

	reportInspector := self emptyEditor.

	