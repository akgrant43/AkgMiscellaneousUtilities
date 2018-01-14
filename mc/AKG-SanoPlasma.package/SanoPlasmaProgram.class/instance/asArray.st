converting
asArray
	"Answer the receiver as an Array in SanoPlasma format"

	^{
		name.
		'CUST'.
		runningTime.
		notes.
		',' join: (frequencies collect: [ :each | each asString ]).
		organ.
		illness.
		dwell.
	}