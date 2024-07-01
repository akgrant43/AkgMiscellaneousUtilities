Class {
	#name : #SanoPlasmaSettingsUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'settings',
		'o2vmLabel',
		'harmonicWobbleLabel',
		'repeatChainLabel',
		'repeatProgramLabel',
		'inputOut2VoltageMultiplier',
		'harmonicWobbleWidget',
		'repeatChainWidget',
		'repeatProgramWidget',
		'settingsChangedBlock'
	],
	#category : 'AKG-SanoPlasma-UI'
}

{ #category : #specs }
SanoPlasmaSettingsUI class >> defaultSpec [
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row
			add: #o2vmLabel;
			add: #inputOut2VoltageMultiplier ] height: tfh;
		newRow: [ :row | row
			add: #repeatProgramLabel;
			add: #repeatProgramWidget ] height: tfh;
		newRow: [ :row | row
			add: #repeatChainLabel;
			add: #repeatChainWidget ] height: tfh;
		newRow: [ :row | row 
			add: #harmonicWobbleLabel;
			add: #harmonicWobbleWidget ] height: tfh.

]

{ #category : #testing }
SanoPlasmaSettingsUI >> configurationErrors [
	"Answer an array of configuration error strings.
	An empty array indicates that it is valid"

	self settings ifNil: [ ^#() ].
	^Array streamContents: [ :stream |
		((self settings at: 'Out 2 Voltage Multiplier') asNumber between: 0 and: 3) ifFalse: 
			[ stream nextPut: 'The Out 2 Voltage Multiplier must be between 0 and 3' ] ]
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> harmonicWobbleLabel [
	^ harmonicWobbleLabel
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> harmonicWobbleLabel: anObject [
	harmonicWobbleLabel := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> harmonicWobbleWidget [
	^ harmonicWobbleWidget
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> harmonicWobbleWidget: anObject [
	harmonicWobbleWidget := anObject
]

{ #category : #initialization }
SanoPlasmaSettingsUI >> initializeWidgets [

	| out2VMName harmonicWobbleName repeatChainName repeatProgramName |

	out2VMName := 'Out 2 Voltage Multiplier'.
	harmonicWobbleName := 'Harmonic Wobble'.
	repeatChainName := 'Repeat Chain'.
	repeatProgramName := 'Repeat each program'.

	o2vmLabel := self newLabel label: out2VMName, ':'.
	harmonicWobbleLabel := self newLabel label: harmonicWobbleName, ':'.
	repeatChainLabel := self newLabel label: repeatChainName, ':'.
	repeatProgramLabel := self newLabel label: repeatProgramName, ':'.

	inputOut2VoltageMultiplier := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: out2VMName put: text ];
		yourself.
	repeatChainWidget := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: repeatChainName put: text ];
		yourself.
	repeatProgramWidget := self newTextInput 
		autoAccept: true;
		acceptBlock: [ :text | self settingsAt: repeatProgramName put: text ];
		yourself.
	harmonicWobbleWidget := self newDropList.
	SanoPlasmaSettings harmonicWobbleChoices do: [ :each |
		harmonicWobbleWidget addItemLabeled: each do: [ self setHarmonicWobble ] ].

	self focusOrder
		add: inputOut2VoltageMultiplier.

]

{ #category : #accessing }
SanoPlasmaSettingsUI >> inputOut2VoltageMultiplier [
	^ inputOut2VoltageMultiplier
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> inputOut2VoltageMultiplier: anObject [
	inputOut2VoltageMultiplier := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> o2vmLabel [
	^ o2vmLabel
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> o2vmLabel: anObject [
	o2vmLabel := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatChainLabel [
	^ repeatChainLabel
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatChainLabel: anObject [
	repeatChainLabel := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatChainWidget [
	^ repeatChainWidget
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatChainWidget: anObject [
	repeatChainWidget := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatProgramLabel [
	^ repeatProgramLabel
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatProgramLabel: anObject [
	repeatProgramLabel := anObject
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatProgramWidget [
	^ repeatProgramWidget
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> repeatProgramWidget: anObject [
	repeatProgramWidget := anObject
]

{ #category : #private }
SanoPlasmaSettingsUI >> setHarmonicWobble [
	"Update the Harmonic Wobble in the receivers settings from the widget"

	| index name |

	index := harmonicWobbleWidget selectedIndex.
	name := SanoPlasmaSettings harmonicWobbleChoices at: index.
	self settingsAt: 'Harmonic Wobble' put: name.
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> settings [
	^ settings
]

{ #category : #accessing }
SanoPlasmaSettingsUI >> settings: aSettings [

	aSettings ifNil: [ ^self ].
	settings := aSettings.
	inputOut2VoltageMultiplier text: (settings at: 'Out 2 Voltage Multiplier').
	harmonicWobbleWidget setIndex: (SanoPlasmaSettings harmonicWobbleChoices indexOf: 
		(settings at: 'Harmonic Wobble')).

]

{ #category : #private }
SanoPlasmaSettingsUI >> settingsAt: key put: value [

	self settings at: key put: value.
	settingsChangedBlock ifNotNil: [ settingsChangedBlock value: self ].
	^value
]

{ #category : #'api-events' }
SanoPlasmaSettingsUI >> whenSettingsChanged: aBlock [
	"Evaluate aBlock when the receivers settings have been updated"

	settingsChangedBlock := aBlock
]
