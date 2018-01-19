testing
configurationErrors
	"Answer an array of configuration error strings.
	An empty array indicates that it is valid"


	^Array streamContents: [ :stream |
		self crossoverFrequency isNumber ifFalse: 
			[ stream nextPut: 'The crossover frequency must be a number' ].
		self name isNotEmpty ifFalse: 
			[ stream nextPut: 'The name must not be empty' ].
		self range isNumber ifFalse: 
			[ stream nextPut: 'The range must be a number' ].
		self fromFrequency isNumber ifFalse: 
			[ stream nextPut: 'The From Frequency must be a number' ].
		self toFrequency isNumber ifFalse: 
			[ stream nextPut: 'The To Frequency must be a number' ].
		self crossoverFrequency > 0 ifFalse:
			[ stream nextPut: 'The Crossover Frequency must be greater than 0' ].
		self crossoverFrequency < 900000 ifFalse:
			[ stream nextPut: 'The Crossover Frequency must be less than 900,000 Hz' ].
		self fromFrequency > 0 ifFalse:
			[ stream nextPut: 'The From Frequency must be greater than 0' ].
		self toFrequency > 0 ifFalse:
			[ stream nextPut: 'The To Frequency must be greater than 0' ].
		stream nextPutAll: self settingsUI configurationErrors ].