stepping
step 
	| now stepDuration |

	state = #stopped ifTrue: [ ^self ].
	now := DateAndTime now.
	stepDuration := now - lastStepTime.
	lastStepTime := now.

	self stepChannel: 1 stepDuration: stepDuration.
	self stepChannel: 2 stepDuration: stepDuration.

	( state = #running and: [ times min > runTime ]) ifTrue: 
		[ state := #stopped ].
	voltages second = generator channel2 amplitude ifFalse: 
		[ generator channel: 2 amplitude: voltages second  ].
	announcer announce: Spooky2Step new.