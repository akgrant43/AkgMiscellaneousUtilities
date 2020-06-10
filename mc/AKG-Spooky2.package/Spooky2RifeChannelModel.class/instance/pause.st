operating
pause
	"Toggle the paused state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state := state = #running
		ifTrue: [ #paused ]
		ifFalse: [ #running ]