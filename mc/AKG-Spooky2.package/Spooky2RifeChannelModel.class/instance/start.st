operating
start 

	process ifNotNil: [ self error: 'Existing process' ].
	(channelNumber between: 1 and: 2) ifFalse: 
		[ self error: 'Invalid Channel Number' ].
	state = #stopped ifFalse: [ self error: 'Already running' ].

	time := Duration zero.
	lastStepTime := DateAndTime now.
	state := #running.
	self configureGenerator.
	process := [ 
		[ state = #stopped ] whileFalse:
			[ self step.
			(Delay forSeconds: 1) wait. ].
		self stopGenerator.
		process := nil. ] forkNamed: 'Spooky2 Runner ', channelNumber asString.
