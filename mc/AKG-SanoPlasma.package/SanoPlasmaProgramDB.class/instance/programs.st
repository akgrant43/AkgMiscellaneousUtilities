accessing
programs
	^ programs ifNil: [ programs := self loadPrograms ]