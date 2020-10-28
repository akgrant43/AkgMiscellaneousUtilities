operating
adjustTime: aDuration
	"Adjust the receiver's time and its channels by the supplied duration"

	time := time + aDuration.
	channelModels do: [ :channel |
		channel adjustTime: aDuration ].
