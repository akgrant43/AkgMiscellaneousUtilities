initialization
initializeWidgets

	removePresetButton := self newButton
		label: 'X';
		action: [ self removeSelectedPreset ];
		yourself.
	saveChainButton := self newButton
		label: 'Save';
		icon: (Smalltalk ui icons iconNamed: #glamorousSave);
		action: [ self saveChain ];
		yourself.
	inspectButton := self newButton
		label: 'Inspect';
		icon: (Smalltalk ui icons iconNamed: #smallObjects);
		action: [ self inspect ];
		yourself.
	nameLabel := self newLabel
		label: 'Name:';
		yourself.
	nameInput := self newTextInput 
		ghostText: 'Preset Name';
		autoAccept: true;
		acceptBlock: [ :text | self updateName ];
		yourself.
	presetList := self newList.
	summaryText := self newText
		disable;
		yourself.
	upButton := self newButton
		label: '^';
		action: [ self moveSelectedPresetUp ];
		yourself.
	downButton := self newButton
		label: 'v';
		action: [ self moveSelectedPresetDown ];
		yourself.