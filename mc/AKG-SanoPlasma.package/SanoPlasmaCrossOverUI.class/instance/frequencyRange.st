private - accessing
frequencyRange

	| xover range |

	xover := self crossoverFrequency.
	range := self range / 1000.

	^[ self fromFrequency asString, ' - ', self toFrequency asString ]
		on: Error 
		do: [ :ex | 'Unable to calculate' ]