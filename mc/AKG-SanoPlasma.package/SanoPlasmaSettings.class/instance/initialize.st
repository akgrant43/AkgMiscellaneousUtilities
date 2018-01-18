initialization
initialize

	super initialize.
	settings := self class settingsDictionaryFromPresetString: SanoPlasmaPreset template.
	"out2Voltage := 12."
	self at: #out1FreqLimitMax put: 900000.
	self at: #out1FreqLimitMin put: 1.
