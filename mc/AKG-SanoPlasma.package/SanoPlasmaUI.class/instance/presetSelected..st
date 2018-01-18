private - changed
presetSelected: aPreset

	| items |

	aPreset ifNil: [ ^self ].
	items := OrderedCollection new.
	items
		add: aPreset settings;
		addAll: aPreset programs.
	self programsSettingsList items: items