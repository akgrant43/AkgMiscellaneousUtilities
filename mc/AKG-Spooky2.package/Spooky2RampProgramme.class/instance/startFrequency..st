accessing
startFrequency: aNumber

	self assert: (aNumber between: 1 and: 1000000).
	endFrequency ifNotNil: [ self assert: startFrequency < endFrequency ].
	startFrequency := aNumber