accessing
deviceName

	^ deviceName ifNil: 
		[ deviceName := self class findPort.
		deviceName ifNil: [ self error: 'Unable to find Spooky2 serial port' ].
		deviceName. ]