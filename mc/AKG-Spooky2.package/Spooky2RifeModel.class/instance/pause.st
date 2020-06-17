actions
pause
	"Toggle the paused state of the programme"

	state = #running ifFalse: [ ^ self error: 'Attempt to pause while not running' ].
	channelModels do: #pause.
	super pause.
