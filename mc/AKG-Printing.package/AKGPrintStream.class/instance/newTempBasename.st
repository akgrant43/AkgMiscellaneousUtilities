private
newTempBasename

	| random newBasename |

	[ 
		random := UUID new asInteger asString.
		newBasename := 'AKGPrintStream-', random.
		self tempDir entries 
			detect: [ :each | each reference basenameWithoutExtension = newBasename ]
			ifFound: [ true ]
			ifNone: [ false ] ] whileTrue.
	^self tempDir / newBasename