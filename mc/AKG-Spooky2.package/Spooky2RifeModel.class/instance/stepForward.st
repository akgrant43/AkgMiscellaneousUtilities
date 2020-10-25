operating
stepForward
	"Step the receiver and its channels forward by 1 second"

	time := time + 1 second.
	channelModels do: [ :channel |
		channel stepForward ].
