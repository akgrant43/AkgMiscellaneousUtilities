collections
addFileName: fileReferenceOrString
	"Add the collection in the supplied file to the receiver"

	^self add: (HashDeepFiles fromFileName: fileReferenceOrString)