private
step 
	| now stepDuration |

	state = #stopped ifTrue: [ ^self ].
	now := DateAndTime now.
	stepDuration := now - lastStepTime.
	lastStepTime := now.

	self stepDuration: stepDuration.

	voltage = self generatorChannel amplitude ifFalse: 
		[ generator channel: channelNumber amplitude: voltage ].
	announcer announce: Spooky2Step new.