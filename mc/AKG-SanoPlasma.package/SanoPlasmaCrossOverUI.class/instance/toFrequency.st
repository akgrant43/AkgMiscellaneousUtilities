private - accessing
toFrequency

	| xover range |

	xover := self crossoverFrequency.
	range := self range / 1000.

	^[ (xover + (range / 2)) asFloat ]
		on: Error 
		do: [ :ex | 'N/A' ]