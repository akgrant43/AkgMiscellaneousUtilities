accessing
endFrequency: aNumber

	self assert: (aNumber between: 1 and: 1000000).
	startFrequency ifNotNil: [ self assert: startFrequency < aNumber ].
	endFrequency := aNumber