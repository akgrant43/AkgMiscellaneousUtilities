private
constructFileDictionary

	| newDictionary bag |

	newDictionary := Dictionary new.
	collections do: [ :collection |
		collection files do: [ :file |
			bag := newDictionary at: file hash ifAbsentPut: [ OrderedCollection new ].
			bag add: file ] ].
	^newDictionary