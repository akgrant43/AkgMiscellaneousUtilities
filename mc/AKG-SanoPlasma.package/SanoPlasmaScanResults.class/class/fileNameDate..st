accessing
fileNameDate: aFileReference
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"

	| regex day month year |

	regex := '(\d\d)(\d\d)(\d\d\d\d)\d*.csv' asRegexIgnoringCase.
	regex matches: aFileReference basename.
	day := regex subexpression: 2.
	month := regex subexpression: 3.
	year := regex subexpression: 4.
	^Date year: year asInteger month: month asInteger day: day asInteger.