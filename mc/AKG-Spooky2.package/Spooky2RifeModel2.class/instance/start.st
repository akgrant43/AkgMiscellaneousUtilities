operating
start 

	process ifNotNil: [ self error: 'Existing process' ].
	state = #stopped ifFalse: [ self error: 'Already running' ].
	runTime asSeconds > 0 ifFalse: [ self error: 'Invalid runTime' ].

	self configureGenerator.
	times
		at: 1 put: Duration zero;
		at: 2 put: Duration zero.
	lastStepTime := DateAndTime now.
	state := #running.
	process := [ 
		[ state = #stopped ] whileFalse:
			[ self step.
			(Delay forSeconds: 1) wait. ].
		self stopGenerator.
		process := nil. ] forkNamed: 'Spooky2 Runner'.
