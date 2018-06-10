private
newTempBasename

	| random newBasename |
	self halt.
	[ 
		random := UUID new asInteger asString.
		newBasename := 'AKGPrintStream-', random.
		self tempDir entries 
			detect: [ :each | each basenameWithoutExtension = newBasename ]
			ifFound: [ true ]
			ifNone: [ false ] ] whileTrue.
	^self tempDir / newBasename