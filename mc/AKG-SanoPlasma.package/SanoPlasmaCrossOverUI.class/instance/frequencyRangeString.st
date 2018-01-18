private - accessing
frequencyRangeString
	"Answer the receivers frequency range in human readable format"

	^[ self fromFrequency asString, ' - ', self toFrequency asString ]
		on: Error 
		do: [ :ex | 'Unable to calculate' ]