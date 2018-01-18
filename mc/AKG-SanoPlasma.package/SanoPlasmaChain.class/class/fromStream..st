instance creation
fromStream: aStream

	| chain |

	chain := self new.
	[ aStream atEnd ] whileFalse: [ 
		chain add: (SanoPlasmaPreset fromStream: aStream) ].
	^chain