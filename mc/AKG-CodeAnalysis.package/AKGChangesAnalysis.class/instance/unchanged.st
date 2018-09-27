accessing
unchanged
	"Answer the set of methods that haven't changed"

	^unchanged ifNil: [ unchanged := self getUnchanged asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]