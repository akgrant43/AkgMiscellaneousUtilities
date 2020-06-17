operating
hold
	"Toggle the hold state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state := #held.