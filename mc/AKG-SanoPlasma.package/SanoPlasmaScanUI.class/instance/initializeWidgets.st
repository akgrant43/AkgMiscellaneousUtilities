initialization
initializeWidgets

	filesList := self newList
		displayBlock: [ :item | item name ];
		whenSelectedItemChanged: [ :selection | self fileSelected: selection ];
		yourself.
	report := self newText 
		enabled: false;
		yourself.
	graph := self newLabel
		label: 'To Be Implemented';
		yourself.