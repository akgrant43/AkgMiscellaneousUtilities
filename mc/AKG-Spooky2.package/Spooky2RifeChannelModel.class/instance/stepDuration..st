private
stepDuration: stepDuration
	| localTime newFrequency |

	localTime := rifeModel time + timeOffset.
	newFrequency := function value: localTime asSeconds.
	(rifeModel isWobbling and: [ channelNumber = 1 ]) ifTrue:
		[ newFrequency := (newFrequency + (50 * (rifeModel wobbleFunction at: Time now asDuration))) rounded ].
	newFrequency = frequency ifFalse:
		[ frequency := newFrequency.
		generator channel: channelNumber frequency: newFrequency].
	voltage = self generatorChannel amplitude ifFalse: 
		[ generator channel: channelNumber amplitude: voltage ].
	announcer announce: Spooky2Step new.