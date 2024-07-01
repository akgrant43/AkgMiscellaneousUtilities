"
SanoPlasmaUI provides a general interface for viewing Chains and their associated Presets, Settings and Programs.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	currentSelection:		<Object>
	directoryTree:		<Object>
	dtLabel:		<Object>
	filesList:		<Object>
	flLabel:		<Object>
	inRebuild:		<Object>
	menuBar:		<Object>
	plLabel:		<Object>
	presetsList:		<Object>
	programSettingsEditor:		<Object>
	programsSettingsList:		<Object>
	pslLabel:		<Object>
	sanoPlasma:		<Object>


    Implementation Points
"
Class {
	#name : #SanoPlasmaUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sanoPlasma',
		'selectedChain',
		'directoryTree',
		'filesList',
		'chainUI',
		'menuBar',
		'currentSelection',
		'inRebuild',
		'dtLabel',
		'flLabel'
	],
	#classVars : [
		'Defaults'
	],
	#category : 'AKG-SanoPlasma-UI'
}

{ #category : #specs }
SanoPlasmaUI class >> defaultSpec [
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row add: #menuBar ] height: 30;
		newRow: [ :row | row 
			add: #dtLabel;
			add: #flLabel] height: tfh;
		newRow: [ :row | row
			add: #directoryTree;
			add: #filesList;
			add: #chainUI ].
]

{ #category : #specs }
SanoPlasmaUI class >> title [

	^'SanoPlasma'
]

{ #category : #'private - changed' }
SanoPlasmaUI >> applyCurrentSelection [
	"All the widgets have probably been reset.
	Set the selected item in each one."

	filesList setSelectedItem: (currentSelection at: 2).

]

{ #category : #accessing }
SanoPlasmaUI >> chainUI [
	^ chainUI
]

{ #category : #accessing }
SanoPlasmaUI >> chainUI: anObject [
	chainUI := anObject
]

{ #category : #private }
SanoPlasmaUI >> createMenu [

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ].
		group addItem: [ :item |
			item
				name: 'Chain';
				icon: (Smalltalk ui icons iconNamed: #add);
				action: [ self newChain ] ] ].
	newMenu applyTo: self.
	^newMenu
]

{ #category : #'private - changed' }
SanoPlasmaUI >> directorySelected: aFileReference [

	| files |

	aFileReference ifNil: [  ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 1 put: directoryTree highlightedItem.
	currentSelection at: 2 put: nil.
	files := (aFileReference filesMatching: '*.txt')
		asSortedCollection: [ :a :b | a basename < b basename ].
	self filesList items: files.
	files isNotEmpty ifTrue: 
		[ self filesList setSelectedItem: files first ]
]

{ #category : #accessing }
SanoPlasmaUI >> directoryTree [
	^ directoryTree
]

{ #category : #accessing }
SanoPlasmaUI >> directoryTree: anObject [
	directoryTree := anObject
]

{ #category : #accessing }
SanoPlasmaUI >> dtLabel [
	^ dtLabel
]

{ #category : #accessing }
SanoPlasmaUI >> dtLabel: anObject [
	dtLabel := anObject
]

{ #category : #initialization }
SanoPlasmaUI >> extent [

	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^(tfh*25) @ (tfh*19)
]

{ #category : #'private - changed' }
SanoPlasmaUI >> fileSelected: aFileReference [

	aFileReference ifNil: [ ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 2 put: aFileReference.
	currentSelection
		at: 3 put: nil;
		at: 4 put: nil.
	selectedChain := SanoPlasmaChain fromFile: aFileReference.
	chainUI chain: selectedChain.
]

{ #category : #accessing }
SanoPlasmaUI >> filesList [
	^ filesList
]

{ #category : #accessing }
SanoPlasmaUI >> filesList: anObject [
	filesList := anObject
]

{ #category : #accessing }
SanoPlasmaUI >> flLabel [
	^ flLabel
]

{ #category : #accessing }
SanoPlasmaUI >> flLabel: anObject [
	flLabel := anObject
]

{ #category : #initialization }
SanoPlasmaUI >> initializeWidgets [

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
]

{ #category : #accessing }
SanoPlasmaUI >> menuBar [
	^ menuBar
]

{ #category : #accessing }
SanoPlasmaUI >> menuBar: anObject [
	menuBar := anObject
]

{ #category : #private }
SanoPlasmaUI >> newChain [

	SanoPlasmaChain new inspect
]

{ #category : #accessing }
SanoPlasmaUI >> sanoPlasma [
	^ sanoPlasma
]

{ #category : #accessing }
SanoPlasmaUI >> sanoPlasma: aSanoPlasma [

	sanoPlasma := aSanoPlasma.
	self directoryTree roots: (sanoPlasma rootDirectory / 'Preset Collections') directories
]

{ #category : #accessing }
SanoPlasmaUI >> selectedChain [
	^ selectedChain
]

{ #category : #accessing }
SanoPlasmaUI >> selectedChain: anObject [
	selectedChain := anObject
]
