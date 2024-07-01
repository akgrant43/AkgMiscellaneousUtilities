Class {
	#name : #SanoPlasmaChainUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'chain',
		'removePresetButton',
		'saveChainButton',
		'inspectButton',
		'nameLabel',
		'nameInput',
		'presetList',
		'programsSettingsList',
		'programSettingsEditor',
		'upButton',
		'downButton',
		'inRebuild',
		'currentSelection',
		'presetLabel',
		'psLabel'
	],
	#category : 'AKG-SanoPlasma-UI'
}

{ #category : #specs }
SanoPlasmaChainUI class >> defaultSpec [
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row 
			add: #nameLabel;
			add: #nameInput ] height: tfh;
		newRow: [ :row | row 
			add: #presetLabel;
			add: #psLabel ] height: tfh;
		newRow: [ :row | row 
			add: #presetList;
			add: #programsSettingsList ] height: tfh * 4;
		newRow: [ :row | row 
			add: #upButton;
			add: #downButton;
			add: #saveChainButton;
			add: #inspectButton ] height: tfh;
		newRow: [ :row | row add: #programSettingsEditor ].
]

{ #category : #specs }
SanoPlasmaChainUI class >> title [

	^'SanoPlasma Chain'
]

{ #category : #accessing }
SanoPlasmaChainUI >> addPreset: aPreset [

	self chain add: aPreset.
	self updateUI.
]

{ #category : #'private - events' }
SanoPlasmaChainUI >> applyCurrentSelection [
	"All the widgets have probably been reset.
	Set the selected item in each one."

	presetList setSelectedItem: (currentSelection at: 1).
	programsSettingsList setSelectedItem: (currentSelection at: 2).

]

{ #category : #accessing }
SanoPlasmaChainUI >> chain [
	^ chain
]

{ #category : #accessing }
SanoPlasmaChainUI >> chain1: anObject [
	chain := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> chain: aSanoPlasmaChain [

	chain := aSanoPlasmaChain.
	self updateUI.

]

{ #category : #accessing }
SanoPlasmaChainUI >> downButton [
	^ downButton
]

{ #category : #accessing }
SanoPlasmaChainUI >> downButton: anObject [
	downButton := anObject
]

{ #category : #private }
SanoPlasmaChainUI >> emptyEditor [
	"Provide a default widget to open the UI with"

	^self newLabel
		label: 'Select Settings or Program';
		yourself.
]

{ #category : #initialization }
SanoPlasmaChainUI >> initializeWidgets [

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
]

{ #category : #accessing }
SanoPlasmaChainUI >> inspectButton [
	^ inspectButton
]

{ #category : #accessing }
SanoPlasmaChainUI >> inspectButton: anObject [
	inspectButton := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> nameInput [
	^ nameInput
]

{ #category : #accessing }
SanoPlasmaChainUI >> nameInput: anObject [
	nameInput := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> nameLabel [
	^ nameLabel
]

{ #category : #accessing }
SanoPlasmaChainUI >> nameLabel: anObject [
	nameLabel := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> presetLabel [
	^ presetLabel
]

{ #category : #accessing }
SanoPlasmaChainUI >> presetLabel: anObject [
	presetLabel := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> presetList [
	^ presetList
]

{ #category : #accessing }
SanoPlasmaChainUI >> presetList: anObject [
	presetList := anObject
]

{ #category : #'private - events' }
SanoPlasmaChainUI >> presetSelected: aPreset [

	| items |

	aPreset ifNil: [ ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 1 put: aPreset.
	currentSelection at: 2 put: nil.
	items := OrderedCollection new.
	items
		add: aPreset settings;
		addAll: aPreset programs.
	self programsSettingsList items: items
]

{ #category : #accessing }
SanoPlasmaChainUI >> programSettingsEditor [
	^ programSettingsEditor
]

{ #category : #accessing }
SanoPlasmaChainUI >> programSettingsEditor: anObject [
	programSettingsEditor := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> programsSettingsList [
	^ programsSettingsList
]

{ #category : #accessing }
SanoPlasmaChainUI >> programsSettingsList: anObject [
	programsSettingsList := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> psLabel [
	^ psLabel
]

{ #category : #accessing }
SanoPlasmaChainUI >> psLabel: anObject [
	psLabel := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> removePresetButton [
	^ removePresetButton
]

{ #category : #accessing }
SanoPlasmaChainUI >> removePresetButton: anObject [
	removePresetButton := anObject
]

{ #category : #accessing }
SanoPlasmaChainUI >> saveChainButton [
	^ saveChainButton
]

{ #category : #accessing }
SanoPlasmaChainUI >> saveChainButton: anObject [
	saveChainButton := anObject
]

{ #category : #'private - events' }
SanoPlasmaChainUI >> spSelected: settingsOrProgram [
	"Update the UI with the editor for the supplied Settings or Program"

	| widget |

	settingsOrProgram ifNil: [ ^self ].
	currentSelection at: 2 put: settingsOrProgram.
	widget := GlamourPresentationModel new.
	widget presentationClass: GTInspector startOn: settingsOrProgram.
	programSettingsEditor := widget.
	inRebuild := true.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.
	self applyCurrentSelection.
	inRebuild := false.
]

{ #category : #accessing }
SanoPlasmaChainUI >> upButton [
	^ upButton
]

{ #category : #accessing }
SanoPlasmaChainUI >> upButton: anObject [
	upButton := anObject
]

{ #category : #private }
SanoPlasmaChainUI >> updateUI [

	| presets |

	nameInput text: chain name.
	presets := chain presets.
	presetList items: presets.
	( presets isNotEmpty and: [ currentSelection first isNil ] ) ifTrue: [ 
		self presetSelected: presets first.
		self spSelected: presets first settings ].

]
