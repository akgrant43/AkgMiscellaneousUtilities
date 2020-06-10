private - button actions
doStop

	rifeModel isStopped ifTrue: [ ^self ].

	rifeModel stop.
	play label: 'Play'.
