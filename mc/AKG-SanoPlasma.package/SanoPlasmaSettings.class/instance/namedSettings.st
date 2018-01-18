accessing
namedSettings
	"Answer a dictionary with the known named keys"

	| dictionary |

	dictionary := Dictionary new.
	self class nameToKeyMap keysAndValuesDo: [ :key :value |
		dictionary at: key put: (self at: value) ].
	^dictionary