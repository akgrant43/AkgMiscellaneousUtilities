accessing
deviceName

	^ deviceName ifNil: [ deviceName := self findPort ]