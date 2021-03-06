initialization
initializeWidgets

	inRebuild := false.
	currentSelection := Array new: 2.

	presetLabel := self newLabel
		label: 'Presets';
		yourself.
	psLabel := self newLabel
		label: 'Settings / Programs';
		yourself.
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
	presetList := self newList
		displayBlock: [ :item | item name ];
		whenSelectedItemChanged: [ :selection | self presetSelected: selection ];
		dragEnabled: true;
		dropEnabled: true;
		wantDropBlock: [ :draggedItem :event :source | 
			"(draggedItem class = SanoPlasmaChain) and: [" 
				(self chain presets includes: draggedItem first) not "]" ];
		acceptDropBlock: [ :transfer :event :source :receiver | 
			self addPreset: transfer passenger first copy ];
		yourself.
	programsSettingsList := self newList
		displayBlock: [ :item | item displayString ];
		whenSelectedItemChanged: [ :selection | self spSelected: selection ];
		yourself.
	programSettingsEditor := self emptyEditor.
	upButton := self newButton
		label: '^';
		action: [ self moveSelectedPresetUp ];
		yourself.
	downButton := self newButton
		label: 'v';
		action: [ self moveSelectedPresetDown ];
		yourself.