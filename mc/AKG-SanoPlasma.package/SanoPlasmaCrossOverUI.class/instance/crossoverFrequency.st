private - accessing
crossoverFrequency

	^[ inputCrossoverFreq text asNumber ]
		on: Error 
		do: [ :ex | 'Invalid Value' ]