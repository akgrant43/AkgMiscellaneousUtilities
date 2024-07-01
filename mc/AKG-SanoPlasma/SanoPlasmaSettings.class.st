Class {
	#name : #SanoPlasmaSettings,
	#superclass : #SanoPlasmaModel,
	#instVars : [
		'settings'
	],
	#classVars : [
		'NameKeyMap'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaSettings class >> addKeyValue: aString to: settings [

	| equalsIndex keyStart keyEnd fieldName valueStart valueEnd fieldValue |

	(aString includesSubstring: '[Preset]') ifTrue:
		"Ignore"
		[ ^self ].

	fieldName := nil.
	fieldValue := nil.
	equalsIndex := aString indexOf: $=.
	equalsIndex > 0 ifTrue: [ 
		keyEnd := equalsIndex - 1.
		keyStart := aString first = $"
			ifTrue: [ 2 ]
			ifFalse: [ 1 ].
		fieldName := aString copyFrom: keyStart to: keyEnd.
		valueStart := equalsIndex + 1.
		valueEnd := aString last = $"
			ifTrue: [ aString size - 1 ]
			ifFalse: [ aString size ].
		fieldValue := aString copyFrom: valueStart to: valueEnd.
		settings at: fieldName put: fieldValue ].

]

{ #category : #'instance creation' }
SanoPlasmaSettings class >> fromStream: aStream [
	"Answer an instance of the receiver from the supplied stream.
	The leading '[Preset]' is optional."

	| done entry settings |

	done := false.
	settings := Dictionary new.
	[ done ] whileFalse: [ 
		entry := aStream nextLine.
		(entry isNil or: [entry includesSubstring: '[/Preset]'])
			ifTrue: [ done := true ]
			ifFalse: [ self addKeyValue: entry to: settings ] ].
	^self new
		settings: settings;
		yourself.
]

{ #category : #choices }
SanoPlasmaSettings class >> harmonicWobbleChoices [
	"Answer the list of supported Harmonic Wobbles"

	^#(
		'None'
		'+-.02% Feathering'
		'+-.05% Feathering'
		'.02% 4 Stage Wobble'
		'.05% 4 Stage Wobble'
		'.02% 8 Stage Wobble'
		'.05% 8 Stage Wobble'
	)
]

{ #category : #initialization }
SanoPlasmaSettings class >> keysFromPresetString: aString [
	"Answer the list of valid keys from the supplied string (preset file contents)"

	| equalsIndex start end fieldName keys |
	keys := SanoPlasmaPreset template lines
		collect: [ :each | 
			fieldName := nil.
			equalsIndex := each indexOf: $=.
			equalsIndex > 0
				ifTrue: [ end := equalsIndex - 1.
					start := each first = $"
						ifTrue: [ 2 ]
						ifFalse: [ 1 ].
					fieldName := each copyFrom: start to: end ].
			fieldName ].
	keys := keys select: [ :each | each isNotNil ].
	^keys storeString
]

{ #category : #mappings }
SanoPlasmaSettings class >> nameToKeyMap [
	"Map the human readable names to the SanoPlasma key"

	^NameKeyMap ifNil: [ NameKeyMap := {
		'Program Name' -> 'Text17'.
		'Repeat each program' -> 'Text3'.
		'Repeat Chain' -> 'Text9'.
		'Out 1 Voltage' -> 'Text20'.
		'Out 2 Voltage Multiplier' -> 'Text22(2)'.
		'Out 1 Offset' -> 'Text21'.
		'Out 2 Offset' -> 'Text25'.
		'Out 1 Freq. Limit Min.' -> 'Text37(1)'.
		'Out 1 Freq. Limit Max.' -> 'Text37(0)'.
		'Harmonic Wobble' -> 'Combo2'.
		} asDictionary ]
]

{ #category : #initialization }
SanoPlasmaSettings class >> reset [
	<script>

	NameKeyMap := nil.
]

{ #category : #initialization }
SanoPlasmaSettings class >> settingsDictionaryFromPresetString: aString [
	"Answer the list of valid keys from the supplied string (preset file contents)"

	| equalsIndex keyStart keyEnd fieldName valueStart valueEnd fieldValue settings |
	settings := Dictionary new.
	SanoPlasmaPreset template lines do: [ :each | 
			fieldName := nil.
			fieldValue := nil.
			equalsIndex := each indexOf: $=.
			equalsIndex > 0 ifTrue: [ 
				keyEnd := equalsIndex - 1.
				keyStart := each first = $"
					ifTrue: [ 2 ]
					ifFalse: [ 1 ].
				fieldName := each copyFrom: keyStart to: keyEnd.
				valueStart := equalsIndex + 1.
				valueEnd := each last = $"
					ifTrue: [ each size - 1 ]
					ifFalse: [ each size ].
				fieldValue := each copyFrom: valueStart to: valueEnd.
				settings at: fieldName put: fieldValue ].
			].
	^settings
]

{ #category : #mappings }
SanoPlasmaSettings class >> validKeyNames [
	"Answer the list of keys that are valid for a SanoPlasma preset"

	^ #('PresetName' 'Text2' 'Text3' 'Text4' 'Text9' 'Text14' 'Text10' 'Text11' 'Text12(0)' 'Text12(1)' 'Text12(2)' 'Text12(3)' 'Text12(4)' 'Text12(5)' 'Text12(6)' 'Text13(0)' 'Text17' 'Text20' 'Text21' 'Text22(0)' 'Text22(1)' 'Text22(2)' 'Text22(3)' 'Text22(4)' 'Text22(5)' 'Text22(6)' 'Text22(7)' 'Text22(10)' 'Text22(11)' 'Text22(12)' 'Text25' 'Text27' 'Text28' 'Text29' 'Text31' 'Text32' 'Text33' 'Text37(0)' 'Text37(1)' 'Text37(2)' 'Text37(3)' 'Text41' 'Text44(0)' 'Text44(1)' 'Text45' 'Text7(0)' 'Text7(1)' 'Text7(2)' 'Text7(3)' 'Text7(4)' 'Text7(5)' 'Text7(6)' 'Text7(7)' 'Text7(8)' 'Text7(9)' 'Text7(10)' 'Text7(11)' 'Text7(12)' 'Text7(13)' 'Text7(14)' 'Text7(15)' 'Text7(16)' 'Text7(17)' 'Text7(18)' 'Text7(19)' 'Text7(20)' 'Text7(21)' 'Text7(22)' 'Text7(23)' 'Text7(24)' 'Text7(25)' 'Text7(26)' 'Text7(27)' 'Text7(28)' 'Text7(29)' 'Text7(30)' 'Text7(31)' 'Text7(32)' 'Text7(33)' 'Text7(34)' 'Text7(35)' 'Text7(36)' 'Text7(37)' 'Text7(38)' 'Text7(39)' 'Text7(40)' 'Text7(41)' 'Text7(42)' 'Text7(43)' 'Text7(44)' 'Text7(45)' 'Text7(46)' 'Combo1' 'Combo2' 'Combo3' 'Combo4' 'Combo5' 'Combo6' 'Combo7' 'Combo8' 'Combo12' 'Combo14' 'Option1(0)' 'Option1(1)' 'Option1(2)' 'Option5(0)' 'Option5(1)' 'Option6(0)' 'Option6(1)' 'Option6(2)' 'Option6(3)' 'Option6(4)' 'Option6(5)' 'Option30(0)' 'Option30(1)' 'Option30(2)' 'Option30(3)' 'Option30(4)' 'Option30(5)' 'Option30(6)' 'Option30(7)' 'Option30(8)' 'Option30(9)' 'Option30(10)' 'Option40(0)' 'Option40(1)' 'Option40(2)' 'Option40(3)' 'Option40(4)' 'Option40(5)' 'Option40(6)' 'Option40(7)' 'Option40(8)' 'Option40(9)' 'Option40(10)' 'Option40(11)' 'Option40(12)' 'Check2' 'Check3' 'Check4(0)' 'Check4(1)' 'Check4(2)' 'Check6(0)' 'Check6(1)' 'Check6(2)' 'Check6(3)' 'Check8(0)' 'Check8(1)' 'Check8(2)' 'Check8(3)' 'Check8(4)' 'Check8(5)' 'Check8(6)' 'Check8(7)' 'Check8(8)' 'Check8(9)' 'Check8(10)' 'Check8(11)' 'Check8(12)' 'Check8(13)' 'Check8(14)' 'Check9(0)' 'Check9(1)' 'Check12(0)' 'Check12(1)' 'Check12(2)' 'List2' 'List4' 'List5')
]

{ #category : #accessing }
SanoPlasmaSettings >> at: keyOrName [
	"Answer the setting with the supplied key or name"

		^self at: keyOrName ifAbsent: [ KeyNotFound signalFor: keyOrName in: self ].
]

{ #category : #accessing }
SanoPlasmaSettings >> at: keyOrName ifAbsent: absentBlock [
	"Answer the setting with the supplied key or name"

	| key |

	key := self class nameToKeyMap at: keyOrName ifAbsent: [ keyOrName ].
	^self settings at: key ifAbsent: [ absentBlock value ].
]

{ #category : #accessing }
SanoPlasmaSettings >> at: keyOrName put: anObject [
	"Store the supplied setting"

	| key |

	key := self class nameToKeyMap at: keyOrName ifAbsent: [ keyOrName ].
	^self settings at: key put: anObject.
]

{ #category : #printing }
SanoPlasmaSettings >> displayString [

	^'SanoPlasma Settings'
]

{ #category : #inspecting }
SanoPlasmaSettings >> gtInspectEditIn: composite [
	<gtInspectorPresentationOrder: 3>

	^ composite spec
		title: 'Edit';
		display: [:arg1 | 
			SanoPlasmaSettingsUI new
				settings: arg1;
				buildWithSpec;
				yourself ].
]

{ #category : #inspecting }
SanoPlasmaSettings >> gtInspectSettingsIn: composite [
	<gtInspectorPresentationOrder: 1>

	^ composite fastTable
		title: 'Settings';
		display: [ self namedSettings associations sorted: 
			[ :a :b | a key < b key ] ];
		"children: [ :each | 
			(each value isDictionary) 
				ifTrue: [ each value associations ] 
				ifFalse: [ (each value isArray and: [ each value allSatisfy: #isDictionary ])
						ifTrue: [ each value collectWithIndex: [:x :i | i -> x ] ]
						ifFalse: [ #() ] ] ];"
		column: 'Setting'
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each value ];
		selectionPopulate: #selection 
			entitled: 'Open key'
			with: [ :table | (table rawSelection collect: #key) gtInspectorInterestingObject ];
		beMultiple;
		send: [ :selection | 
			selection isNil 
			ifTrue:[nil]
			ifFalse:[ (selection size = 1) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ]]

]

{ #category : #initialization }
SanoPlasmaSettings >> initialize [

	super initialize.
	"out2Voltage := 12."
	self at: 'Out 1 Freq. Limit Max.' put: 900000.
	self at: 'Out 1 Freq. Limit Min.' put: 1.

]

{ #category : #accessing }
SanoPlasmaSettings >> namedSettings [
	"Answer a dictionary with the known named keys"

	| dictionary |

	dictionary := Dictionary new.
	self class nameToKeyMap keysAndValuesDo: [ :key :value |
		dictionary at: key put: (self at: value) ].
	^dictionary
]

{ #category : #'accessing - convenience' }
SanoPlasmaSettings >> output2Voltage [
	"Answer the absolute voltage on Output 2"

	^(self at: 'Out 1 Voltage') asNumber * (self at: 'Out 2 Voltage Multiplier') asNumber
]

{ #category : #'private - accessing' }
SanoPlasmaSettings >> settings [

	^settings ifNil: [ settings := self class settingsDictionaryFromPresetString: SanoPlasmaPreset template ]
]

{ #category : #accessing }
SanoPlasmaSettings >> settings: anObject [
	settings := anObject
]

{ #category : #saving }
SanoPlasmaSettings >> writeOn: aStream [
	"Write the receiver on aStream in SanoPlasma text format"

	"Strings should be written without quotes"
	self class validKeyNames do: [ :keyName |
		aStream
			<< '"';
			<< keyName;
			<< '=';
			<< (self at: keyName) asString;
			<< '"';
			cr ].
]
