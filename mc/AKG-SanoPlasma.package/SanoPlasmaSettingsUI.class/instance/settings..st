accessing
settings: aSettings

	aSettings ifNil: [ ^self ].
	settings := aSettings.
	inputOut2VoltageMultiplier text: (settings at: 'Out 2 Voltage Multiplier').
