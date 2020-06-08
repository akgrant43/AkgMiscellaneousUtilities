private
stepChannel: channelNumber stepDuration: stepDuration
	| newFrequency wobble |

	state = #running ifTrue:
		[ times at: channelNumber put: (times at: channelNumber) + stepDuration ].
	newFrequency := (functions at: channelNumber) value: (times at: channelNumber) asSeconds.
	wobble := wobbles at: channelNumber.
	wobble > 0 ifTrue:
		[ newFrequency := (newFrequency * (1 + (wobble / 100.0 * (random next * 2.0 - 1.0)))) rounded ].
	newFrequency = (frequencies at: channelNumber) ifFalse:
		[ frequencies at: channelNumber put: newFrequency.
		generator channel: channelNumber frequency: newFrequency].
