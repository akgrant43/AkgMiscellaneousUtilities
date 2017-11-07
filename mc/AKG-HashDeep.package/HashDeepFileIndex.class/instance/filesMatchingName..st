selecting
filesMatchingName: aRegex
	"Answer the collection of files with names matching aRegex"

	| regex |

	regex := aRegex asRegex.
	^Array streamContents: [ :stream |
		collections do: [ :collection |
			stream nextPutAll: (collection filesMatchingName: aRegex) ] ].