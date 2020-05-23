accessing
phase: aNumber

	self assert: (aNumber between: 0 and: 359).
	phase := aNumber