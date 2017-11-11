comparing
duplicates
	"Answer the collection of files that are duplicates in the receivers index"

	^Array streamContents: [ :stream |
		self fileDictionary valuesDo: [ :each |
			each size > 1 ifTrue: [ stream nextPut: each ] ] ]