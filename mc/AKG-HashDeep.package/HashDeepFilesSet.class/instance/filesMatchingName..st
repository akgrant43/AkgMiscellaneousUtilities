selecting
filesMatchingName: aRegex
	"Answer the collection of files with names matching aRegex"

	^Array streamContents: [ :stream |
		hashDeepFiles do: [ :files |
			stream nextPutAll: (files filesMatchingName: aRegex) ] ].