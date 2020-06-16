private - button actions
doPlay

	rifeModel isStopped ifFalse: [ ^ self ].

	rifeModel start.
	play enabled: false.
	stop enabled: true.
