commands
pWaveformCommand: aNumber
	| commandString |

	self assert: (aNumber between: 1 and: 15).
	commandString := String streamContents: [ :stream |
		stream 
			<< ':a';
			<< (aNumber printPaddedWith: $0 to: 2).
		(pWaveforms at: aNumber)
			do: [ :value | stream print: value ]
			separatedBy: [ stream nextPut: $, ] ].
	^ commandString.