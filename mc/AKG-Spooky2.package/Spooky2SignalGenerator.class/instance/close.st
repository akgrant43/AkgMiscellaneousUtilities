initialize-release
close 

	serialPort ifNotNil:
		[ serialPort close.
		readProcess ifNotNil: [ readProcess terminate. ].
		serialPort := nil.
		readProcess := nil. ].