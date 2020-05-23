stepping
step 
	| now paused |

	now := DateAndTime now.
	pauseBoolean ifTrue: 
		[ pauseSemaphore wait.
		paused := DateAndTime now. ].
	time := time + (now - lastStepTime).
	lastStepTime := paused
							ifNil: [ now ]
							ifNotNil: [ paused ].
	c1Frequency := c1Function value: time asSeconds.
	c2Frequency := c2Function value: time asSeconds.
	generator
		channel: 1 frequency: c1Frequency;
		channel: 2 frequency: c2Frequency.
	announcer announce: Spooky2Step new.