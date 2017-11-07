comparing
missingFromFiles: aHashDeepFiles
	"Answer the set of files that hashDeepFiles has but the receiver doesn't"

	| missing |

	missing := Set new.
	hashDeepFiles do: [ :each |
		missing addAll: (each missingFromFiles: aHashDeepFiles) ].
	^missing