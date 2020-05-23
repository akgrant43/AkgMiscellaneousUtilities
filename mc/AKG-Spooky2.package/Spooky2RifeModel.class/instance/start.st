operating
start 

	process ifNotNil: [ self error: 'Already running' ].
	runTime asSeconds > 0 ifFalse: [ self error: 'Invalid runTime' ].

	self configureGenerator.
	time := Duration zero.
	lastStepTime := DateAndTime now.
	process := [ 
		[ time > runTime ] whileFalse:
			[ self step.
			(Delay forSeconds: 1) wait. ].
		self stopGenerator.
		process := nil. ] forkNamed: 'Spooky2 Runner'.
	