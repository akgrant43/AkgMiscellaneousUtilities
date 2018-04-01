private
dateFromName: aString
	"Answer a date encoded in the file name.
	The date must be encoded YYYYMMDD have a year of 2018 - 2028"

	| dateRegex found year month day |

	dateRegex := '(\d\d\d\d)(\d\d)(\d\d)' asRegex.
	found := dateRegex search: aString.
	found ifFalse: [ ^nil ].
	year := (dateRegex subexpression: 2) asNumber.
	(year between: 2018 and: 2028) ifFalse: [ ^nil ].
	month := (dateRegex subexpression: 3) asNumber.
	(month between: 1 and: 12) ifFalse: [ ^nil ].
	day := (dateRegex subexpression: 4) asNumber.
	(day between: 1 and: 31) ifFalse: [ ^nil ].
	^Date 	year: year month: month day: day.