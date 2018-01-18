accessing
at: keyOrName put: anObject
	"Store the supplied setting"

	| key |

	key := self class nameToKeyMap at: keyOrName ifAbsent: [ keyOrName ].
	^settings at: key put: anObject.