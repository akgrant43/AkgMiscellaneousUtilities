accessing
amplitude: aNumber

	self assert: (aNumber between: 0 and: 20).
	amplitude := aNumber