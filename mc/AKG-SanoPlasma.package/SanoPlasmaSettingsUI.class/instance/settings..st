accessing
settings: aSettings

	aSettings ifNil: [ ^self ].
	settings := aSettings.
	inputOut2VoltageMultiplier text: (settings at: 'Out 2 Voltage Multiplier').
	harmonicWobbleWidget setIndex: (SanoPlasmaSettings harmonicWobbleChoices indexOf: 
		(settings at: 'Harmonic Wobble')).
