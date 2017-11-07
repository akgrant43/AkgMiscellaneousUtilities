selecting
filesMatchingName: aRegex
	"Answer the collection of files with names matching aRegex"

	| regex |

	regex := aRegex asRegex.
	^Array streamContents: [ :stream |
		self files do: [ :file |
			(regex search: file fileName) ifTrue: 
				[ stream nextPut: file ] ] ].