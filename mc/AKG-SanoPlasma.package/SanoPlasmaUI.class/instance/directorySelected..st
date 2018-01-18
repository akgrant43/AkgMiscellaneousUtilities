private - changed
directorySelected: aFileReference

	| files |

	aFileReference ifNil: [ ^self ].
	files := (aFileReference filesMatching: '*.txt')
		asSortedCollection: [ :a :b | a basename < b basename ].
	self filesList items: files