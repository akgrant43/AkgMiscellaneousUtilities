operating
step 
	| now stepDuration |

	state = #stopped ifTrue: [ ^self ].
	now := DateAndTime now.
	stepDuration := now - lastStepTime.
	lastStepTime := now.

	self stepDuration: stepDuration.
