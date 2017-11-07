private
constructFileDictionary

	| newDictionary bag |

	newDictionary := Dictionary new.
	self files do: [ :file |
		bag := newDictionary at: file hash ifAbsentPut: [ Bag new ].
		bag add: file ].
	^newDictionary