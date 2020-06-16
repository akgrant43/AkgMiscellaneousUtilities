private
stepDuration: stepDuration
	| newFrequency |

	time := time + stepDuration.
	newFrequency := function value: time asSeconds.
	wobble > 0 ifTrue:
		[ newFrequency := (newFrequency * (1 + (wobble / 100.0 * (random next * 2.0 - 1.0)))) rounded ].
	newFrequency = frequency ifFalse:
		[ frequency := newFrequency.
		generator channel: channelNumber frequency: newFrequency].
	voltage = self generatorChannel amplitude ifFalse: 
		[ generator channel: channelNumber amplitude: voltage ].
	announcer announce: Spooky2Step new.