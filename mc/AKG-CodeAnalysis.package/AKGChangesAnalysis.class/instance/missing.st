accessing
missing
	"Answer the set of methods that exist in the image but aren't in the receivers file"

	^missing ifNil: [ missing := self getMissing asSortedCollection: [ :a :b | a selector < b selector ] ]