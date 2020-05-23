private
startReadProcess

	self
		assert: readProcess isNil
		description: 'Read process is already running'.

	readProcess := [ | buf |
		[ serialPort isNotNil ] whileTrue: [ 
			buf := serialPort readString.
			buf ifNotEmpty: [ self processReadString: buf ].
			(Delay forMilliseconds: 100) wait. ] ] forkNamed: 'Spooky2 Read Process'.
