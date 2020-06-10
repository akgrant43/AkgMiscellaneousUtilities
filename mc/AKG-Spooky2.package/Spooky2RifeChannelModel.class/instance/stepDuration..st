private
stepDuration: stepDuration
	| newFrequency |

	state = #running ifTrue:
		[ time := time + stepDuration ].
	newFrequency := function value: time asSeconds.
	wobble > 0 ifTrue:
		[ newFrequency := (newFrequency * (1 + (wobble / 100.0 * (random next * 2.0 - 1.0)))) rounded ].
	newFrequency = frequency ifFalse:
		[ frequency := newFrequency.
		generator channel: channelNumber frequency: newFrequency].
