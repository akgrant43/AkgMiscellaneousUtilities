operating
stepBackward
	"Step the receiver and its channels backward by 1 second"

	time := time - 1 second.
	channelModels do: [ :channel |
		channel stepBackward ].
