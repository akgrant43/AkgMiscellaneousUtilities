actions
unpause

	state = #paused ifFalse: [ ^ self error: 'Attempt to unpause while not paused' ].
	channelModels do: #unpause.
	super unpause.
