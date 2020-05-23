accessing
dutyCycle: aNumber

	self assert: (aNumber between: 1 and: 100).
	dutyCycle := aNumber