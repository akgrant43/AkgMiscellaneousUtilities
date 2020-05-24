private
pauseGenerator

	model pause.
	model paused
		ifTrue: [ pause label: 'Resume' ]
		ifFalse: [ pause label: 'Pause' ]