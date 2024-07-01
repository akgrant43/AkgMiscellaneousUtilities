Class {
	#name : #SanoPlasmaCrossOverUI,
	#superclass : #ComposablePresenter,
	#instVars : [
		'settings',
		'program',
		'frequencyRange',
		'sanoPlasma',
		'labelCrossoverFreq',
		'labelRange',
		'labelTime',
		'labelName',
		'labelLocation',
		'inputCrossoverFreq',
		'inputRange',
		'inputTime',
		'inputName',
		'inputLocation',
		'summaryText',
		'createButton',
		'menu',
		'settingsUI'
	],
	#classVars : [
		'Defaults'
	],
	#category : 'AKG-SanoPlasma-UI'
}

{ #category : #specs }
SanoPlasmaCrossOverUI class >> defaultSpec [
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row add: #menu ] height: self toolbarHeight;
		newRow: [ :mainRow | mainRow
		newColumn: [ :column | column
		newRow: [ :row | row
			add: #labelCrossoverFreq;
			add: #inputCrossoverFreq ] height: tfh;
		newRow: [ :row | row 
			add: #labelRange;
			add: #inputRange ] height: tfh;
		newRow: [ :row | row 
			add: #labelTime;
			add: #inputTime ] height: tfh;
		newRow: [ :row | row
			add: #labelName;
			add: #inputName ] height: tfh;
		newRow: [ :row | row 
			add: #labelLocation;
			add: #inputLocation ] height: tfh ];
		newColumn: [ :column | column 
			newRow: [ :row | row add: #settingsUI ] ] ];
		newRow: [ :row | row add: #summaryText ] height: tfh * 10;
		newRow: [ :row | row add: #createButton ] height: tfh.

]

{ #category : #'as yet unclassified' }
SanoPlasmaCrossOverUI class >> defaults [

	^Defaults ifNil: [ Defaults := Dictionary new ]
]

{ #category : #'as yet unclassified' }
SanoPlasmaCrossOverUI class >> defaults: aDictionary [

	Defaults := aDictionary
]

{ #category : #'as yet unclassified' }
SanoPlasmaCrossOverUI class >> title [

	^'SanoPlasma Crossover Preset Generator'
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI class >> toolbarHeight [

	^30
]

{ #category : #testing }
SanoPlasmaCrossOverUI >> configurationErrors [
	"Answer an array of configuration error strings.
	An empty array indicates that it is valid"


	^Array streamContents: [ :stream |
		self crossoverFrequency isNumber ifFalse: 
			[ stream nextPut: 'The crossover frequency must be a number' ].
		self name isNotEmpty ifFalse: 
			[ stream nextPut: 'The name must not be empty' ].
		self range isNumber ifFalse: 
			[ stream nextPut: 'The range must be a number' ].
		self fromFrequency isNumber ifFalse: 
			[ stream nextPut: 'The From Frequency must be a number' ].
		self toFrequency isNumber ifFalse: 
			[ stream nextPut: 'The To Frequency must be a number' ].
		self crossoverFrequency > 0 ifFalse:
			[ stream nextPut: 'The Crossover Frequency must be greater than 0' ].
		self crossoverFrequency < 900000 ifFalse:
			[ stream nextPut: 'The Crossover Frequency must be less than 900,000 Hz' ].
		self fromFrequency > 0 ifFalse:
			[ stream nextPut: 'The From Frequency must be greater than 0' ].
		self toFrequency > 0 ifFalse:
			[ stream nextPut: 'The To Frequency must be greater than 0' ].
		stream nextPutAll: self settingsUI configurationErrors ].
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> createButton [
	^ createButton
]

{ #category : #private }
SanoPlasmaCrossOverUI >> createMenu [

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Settings';
				icon: (Smalltalk ui icons iconNamed: #smallCogState2);
				action: [ self settings inspect ] ].
		group addItem: [ :item |
			item
				name: 'Program';
				icon: (Smalltalk ui icons iconNamed: #book);
				action: [ self program inspect ] ].
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ] ].
	newMenu applyTo: self.
	^newMenu
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> crossoverFrequency [

	^[ inputCrossoverFreq text asNumber ]
		on: Error 
		do: [ :ex | 'Invalid Value' ]
]

{ #category : #private }
SanoPlasmaCrossOverUI >> defaultAt: aSymbol ifAbsent: defaultBlock [

	^self class defaults at: aSymbol ifAbsent: defaultBlock
]

{ #category : #initialization }
SanoPlasmaCrossOverUI >> extent [

	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^(tfh*25) @ (tfh*19)
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> frequencyRange [
	^ frequencyRange
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> frequencyRangeString [
	"Answer the receivers frequency range in human readable format"

	^[ self fromFrequency asString, ' - ', self toFrequency asString ]
		on: Error 
		do: [ :ex | 'Unable to calculate' ]
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> fromFrequency [

	| xover range |

	xover := self crossoverFrequency.
	range := self range / 1000.

	^[ (xover - (range / 2)) asFloat ]
		on: Error 
		do: [ :ex | 'N/A' ]
]

{ #category : #initialization }
SanoPlasmaCrossOverUI >> initialize [

	super initialize.
	frequencyRange := SanoPlasmaFrequencyRange new.
	program := SanoPlasmaProgram new 
					addFrequency: frequencyRange;
					yourself.
	self settings: SanoPlasmaSettings new.

]

{ #category : #initialization }
SanoPlasmaCrossOverUI >> initializeWidgets [

	menu := self createMenu.
	labelCrossoverFreq := self newLabel label: 'Crossover Freq. (kHz):'.
	labelRange := self newLabel label: 'Range (Hz):'.
	labelTime := self newLabel label: 'Time (min):'.
	labelName := self newLabel label: 'Name:'.
	labelLocation := self newLabel label: 'Location:'.

	inputCrossoverFreq := self newTextInput 
		text: (self defaultAt: #CrossoverFreq ifAbsent: [ 0 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputRange := self newTextInput 
		text: (self defaultAt: #Range ifAbsent: [ 500 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputTime := self newTextInput 
		text: (self defaultAt: #Time ifAbsent: [ 15 ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputName := self newTextInput
		ghostText: 'Preset & Program Name';
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	inputLocation := self newTextInput 
		text: (self defaultAt: #Location ifAbsent: ['FlexX' ]);
		autoAccept: true;
		acceptBlock: [ :text | self updateSummary ];
		yourself.
	summaryText := self newText.
	createButton := self newButton
		label: 'Create';
		action: [ self save ];
		icon: (Smalltalk ui icons iconNamed: #smallSave);
		yourself.
	settingsUI := self instantiate: SanoPlasmaSettingsUI.
	settingsUI whenSettingsChanged: [ :stngs | self updateSummary ].

	self focusOrder
		add: inputCrossoverFreq;
		add: inputRange;
		add: inputTime;
		add: inputName;
		add: inputLocation;
		add: settingsUI;
		add: createButton.
	self updateSummary.
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> inputCrossoverFreq [
	^ inputCrossoverFreq
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> inputLocation [
	^ inputLocation
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> inputName [
	^ inputName
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> inputRange [
	^ inputRange
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> inputTime [
	^ inputTime
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> labelCrossoverFreq [
	^ labelCrossoverFreq
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> labelLocation [
	^ labelLocation
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> labelName [
	^ labelName
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> labelRange [
	^ labelRange
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> labelTime [
	^ labelTime
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> location [

	^inputLocation text
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> menu [
	^ menu
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> menu: anObject [
	menu := anObject
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> name [

	^inputName text
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> presetDirectory [
	"Answer the directory where presets should be saved"

	^sanoPlasma rootDirectory / 'Preset Collections' / 'User' / self location
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> program [
	^ program
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> range [

	^inputRange text asNumber
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> sanoPlasma [
	^ sanoPlasma
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> sanoPlasma: anObject [
	sanoPlasma := anObject
]

{ #category : #private }
SanoPlasmaCrossOverUI >> save [
	"Save the receivers preset & program"

	| preset |

	self validConfiguration ifFalse: [ ^UIManager default 
			alert: 'Invalid Configuration'
			title: 'SanoPlasma CrossOver' ].
	frequencyRange
		fromFrequency: (self fromFrequency * 1000) rounded;
		toFrequency: (self toFrequency * 1000) rounded;
		dwell: self timeInSeconds.
	program
		name: self name;
		dwell: self timeInSeconds.
	preset := SanoPlasmaPreset new 
					name: self name;
					settings: settings;
					add: program;
					yourself.
	(preset fileNameIn: self presetDirectory) exists ifTrue: [ 
		(UIManager default confirm: self name, ' already exists.  Overwrite?' label: 'SanoPlasma')
			ifFalse: [ ^self ] ].
	preset saveIn: self presetDirectory.
	sanoPlasma programDB 
		addOrReplace: program;
		save.
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> settings [
	^ settings
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> settings: aSettings [

	settings := aSettings.
	settingsUI settings: aSettings.
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> settingsUI [
	^ settingsUI
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> settingsUI: anObject [
	settingsUI := anObject
]

{ #category : #accessing }
SanoPlasmaCrossOverUI >> summaryText [
	^ summaryText
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> timeInMinutes [

	^inputTime text asNumber
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> timeInSeconds [

	^inputTime text asNumber * 60
]

{ #category : #'private - accessing' }
SanoPlasmaCrossOverUI >> toFrequency [

	| xover range |

	xover := self crossoverFrequency.
	range := self range / 1000.

	^[ (xover + (range / 2)) asFloat ]
		on: Error 
		do: [ :ex | 'N/A' ]
]

{ #category : #private }
SanoPlasmaCrossOverUI >> updateSummary [
	"Update the summary text"

	| newText configErrors o2V |

	self settings ifNil:
		[ o2V := 'N/A' ]
	ifNotNil: 
		[ o2V := settings output2Voltage asString ].
	newText := String streamContents: [ :stream |
		stream
			<< 'Crossover Freq. (kHz):'; tab; tab;
			<< self crossoverFrequency asString; cr;
			<< 'Range (Hz):'; tab; tab; tab; tab;
			<< self range asString; cr;
			<< 'Time (min):'; tab; tab; tab; tab;
			<< self timeInMinutes asString; cr;
			<< 'Name:'; tab; tab; tab; tab; tab;
			<< self name asString; cr;
			<< 'Out 2 Voltage:'; tab; tab; tab;
			<< o2V; cr;
			cr;
			<< 'Frequency Range (kHz): '; tab;
			<< self frequencyRangeString asString; cr; cr.
		configErrors := self configurationErrors.
		configErrors isEmpty
			ifTrue: [ stream << 'Configuration Valid' ]
			ifFalse: [ 
				stream << 'Invalid Configuration:'; cr.
				configErrors do: [ :each |
					stream
						<< '- ';
						<< each;
						cr ] ].
		stream cr ].
		summaryText text: newText
]

{ #category : #testing }
SanoPlasmaCrossOverUI >> validConfiguration [
	"Answer a boolean indicating whether the configuration is valid"

	^self configurationErrors isEmpty
]
