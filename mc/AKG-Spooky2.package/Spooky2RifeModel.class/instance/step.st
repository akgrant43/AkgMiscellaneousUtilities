stepping
step 
	| now newC1 newC2 |

	state = #stopped ifTrue: [ ^self ].
	now := DateAndTime now.
	state ~= #paused ifTrue:
		[ time := time + (now - lastStepTime) ].
	lastStepTime := now.
	newC1 := c1Function value: time asSeconds.
	newC2 := c2Function value: time asSeconds.
	wobble > 0 ifTrue:
		[ newC1 := (newC1 * (1 + (wobble / 100.0 * (random next * 2.0 - 1.0)))) rounded.
		newC2 := (newC2 * (1 + (wobble / 100.0 * (random next * 2.0 - 1.0)))) rounded. ].
	newC1 = c1Frequency ifFalse:
		[ c1Frequency := newC1.
		generator channel: 1 frequency: c1Frequency].
	newC2 = c2Frequency ifFalse:
		[ c2Frequency := newC2.
		generator channel: 2 frequency: c2Frequency ].
	( state = #running and: [ time > runTime ]) ifTrue: 
		[ state := #stopped ].
	c2Voltage = generator channel2 amplitude ifFalse: 
		[ generator channel: 2 amplitude: c2Voltage  ].
	announcer announce: Spooky2Step new.