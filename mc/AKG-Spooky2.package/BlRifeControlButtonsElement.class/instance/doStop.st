private - button actions
doStop

	rifeModel isStopped ifTrue: [ ^self ].

	rifeModel stop.
	stop enabled: false.
	play enabled: true.
