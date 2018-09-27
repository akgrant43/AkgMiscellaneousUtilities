accessing
changed
	"Answer the set of methods that exist in the image and are changed by the receivers file"

	^changed ifNil: [ changed := self getChanged asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]