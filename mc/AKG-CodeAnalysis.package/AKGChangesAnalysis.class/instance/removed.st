accessing
removed
	"Answer the set of methods that don't exist in the image and are added by the receivers file"

	^removed ifNil: [ removed := self getRemoved asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]