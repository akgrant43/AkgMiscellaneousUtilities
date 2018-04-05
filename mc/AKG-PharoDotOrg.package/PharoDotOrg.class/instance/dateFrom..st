private
dateFrom: aString
	"Answer a date encoded in the supplied string"

	^[ DateAndTime fromString: aString ]
		on: Error 
		do: [ nil ].