testing
configurationErrors
	"Answer an array of configuration error strings.
	An empty array indicates that it is valid"

	self settings ifNil: [ ^#() ].
	^Array streamContents: [ :stream |
		((self settings at: 'Out 2 Voltage Multiplier') asNumber between: 0 and: 3) ifFalse: 
			[ stream nextPut: 'The Out 2 Voltage Multiplier must be between 0 and 3' ] ]