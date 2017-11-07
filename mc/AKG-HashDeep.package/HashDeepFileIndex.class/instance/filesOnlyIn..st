comparing
filesOnlyIn: hashDeepFiles
	"Answer the set of files that hashDeepFiles has but the receiver doesn't"

	| missing hdfDictionary |

	missing := Set new.
	hdfDictionary := self fileDictionary.
	hashDeepFiles files do: [ :file |
		(hdfDictionary includesKey: file hash) ifFalse: 
			[ missing add: file ] ].
	^missing