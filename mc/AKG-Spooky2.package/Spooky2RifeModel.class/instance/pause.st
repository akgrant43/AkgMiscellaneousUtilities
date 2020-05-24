operating
pause
	"Toggle the paused state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state = #running
		ifTrue: [ state := #paused ]
		ifFalse: [ state := #running ]