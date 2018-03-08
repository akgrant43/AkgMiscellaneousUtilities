initialization
initializeWidgets

	menu := self createMenu.

	directoryList := self newMultiColumnList
		displayBlock: [ :entry | self columnsFor: entry ];
		whenSelectedItemChanged: [ :selection | self selectedReport: selection ];
		yourself.

	reportText := self newText 
		enabled: false;
		yourself.

	