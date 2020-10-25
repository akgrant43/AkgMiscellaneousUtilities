operating
start 

	process ifNotNil: [ self error: 'Existing process' ].
	state = #stopped ifFalse: [ self error: 'Already running' ].

	self reset.
	lastStepTime := DateAndTime now.
	state := #running.
	channelModels do: #start.
	self configureGenerator.
	process := [ 
		[ state = #stopped ] whileFalse:
			[ self step.
			(Delay forSeconds: 1) wait.
			time > runTime ifTrue: [ self stop ] ].
		self stopGenerator.
		process := nil. ] forkNamed: 'Spooky2 Runner'.
