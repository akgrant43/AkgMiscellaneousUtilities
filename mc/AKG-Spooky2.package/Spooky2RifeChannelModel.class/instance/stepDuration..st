private
stepDuration: stepDuration
	| newFrequency |

	newFrequency := function value: (rifeModel time + timeOffset) asSeconds.
	wobble > 0 ifTrue:
		[ newFrequency := (newFrequency + (wobble * (random next * 2.0 - 1.0))) rounded ].
	newFrequency = frequency ifFalse:
		[ frequency := newFrequency.
		generator channel: channelNumber frequency: newFrequency].
	voltage = self generatorChannel amplitude ifFalse: 
		[ generator channel: channelNumber amplitude: voltage ].
	announcer announce: Spooky2Step new.