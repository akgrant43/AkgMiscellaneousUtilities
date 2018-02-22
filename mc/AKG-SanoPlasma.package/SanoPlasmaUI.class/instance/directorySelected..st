private - changed
directorySelected: aFileReference

	| files |

	aFileReference ifNil: [  ^self ].
	inRebuild ifTrue: [ ^self ].
	currentSelection at: 1 put: directoryTree highlightedItem.
	currentSelection at: 2 put: nil.
	files := (aFileReference filesMatching: '*.txt')
		asSortedCollection: [ :a :b | a basename < b basename ].
	self filesList items: files.
	files isNotEmpty ifTrue: 
		[ self filesList setSelectedItem: files first ]