accessing
at: keyOrName put: anObject
	"Store the supplied setting"

	| key |

	key := self class nameToKeyMap at: keyOrName ifAbsent: [ keyOrName ].
	^self settings at: key put: anObject.