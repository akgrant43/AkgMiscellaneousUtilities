actions
pause
	"Toggle the paused state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state = #running ifTrue: 
		[ channelModels do: #switchOffChannel.
		state := #paused ]
	ifFalse: 
		[ channelModels do: #switchOnChannel.
		state := #running ]