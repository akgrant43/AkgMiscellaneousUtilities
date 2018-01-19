*AKG-SanoPlasma
asNumberOrNil
	"Answer the receiver as a number, or if empty, nil"

	self isEmpty ifTrue: [ ^nil ].
	^self asNumber