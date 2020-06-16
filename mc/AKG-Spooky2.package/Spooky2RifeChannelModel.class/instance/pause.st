operating
pause
	"Toggle the paused state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state = #running ifTrue: 
		[ generator switchOffChannel: channelNumber.
		state := #paused ]
	ifFalse: 
		[ generator switchOnChannel: channelNumber.
		state := #running ]