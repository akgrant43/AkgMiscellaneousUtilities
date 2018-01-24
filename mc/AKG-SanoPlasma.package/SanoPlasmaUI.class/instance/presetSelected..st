private - changed
presetSelected: aPreset

	| items |

	aPreset ifNil: [ ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 3 put: aPreset.
	currentSelection at: 4 put: nil.
	items := OrderedCollection new.
	items
		add: aPreset settings;
		addAll: aPreset programs.
	self programsSettingsList items: items