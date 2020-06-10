private - button actions
doPlay

	rifeModel isStopped ifTrue: 
		[ rifeModel start.
		play label: 'Hold'.
		^ self ].

	rifeModel pause.
	play label: (rifeModel isPaused 
		ifTrue: [ 'Resume' ]
		ifFalse: [ 'Hold' ]).
