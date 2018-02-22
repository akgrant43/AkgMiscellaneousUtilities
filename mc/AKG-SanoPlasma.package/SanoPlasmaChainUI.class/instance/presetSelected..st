private - events
presetSelected: aPreset

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