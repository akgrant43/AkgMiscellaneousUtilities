private
stepDuration: stepDuration

	state = #running ifTrue:
		[ time := time + stepDuration ].
	channelModels do: [ :channel |
		channel stepDuration: stepDuration ].
	announcer announce: Spooky2Step new.