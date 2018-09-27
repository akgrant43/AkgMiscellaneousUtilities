accessing
added
	"Answer the set of methods that don't exist in the image and are added by the receivers file"

	^added ifNil: [ added := self getAdded asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]