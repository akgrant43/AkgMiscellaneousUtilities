accessing
at: keyOrName ifAbsent: absentBlock
	"Answer the setting with the supplied key or name"

	| key |

	key := self class nameToKeyMap at: keyOrName ifAbsent: [ keyOrName ].
	^self settings at: key ifAbsent: [ absentBlock value ].