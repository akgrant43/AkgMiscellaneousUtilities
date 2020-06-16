operating
hold
	"Toggle the hold state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state := state = #running
		ifTrue: [ #held ]
		ifFalse: [ #running ]