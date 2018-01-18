private - accessing
settings

	^settings ifNil: [ settings := self class settingsDictionaryFromPresetString: SanoPlasmaPreset template ]