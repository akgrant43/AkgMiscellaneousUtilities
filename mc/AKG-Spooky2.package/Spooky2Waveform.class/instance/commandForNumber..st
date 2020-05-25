as yet unclassified
commandForNumber: aNumber
	"Answer the command string to program the receiver's waveform"
	| commandString |

	self assert: (aNumber between: 1 and: 15).
	commandString := String streamContents: [ :stream |
		stream 
			<< ':a';
			<< (aNumber printPaddedWith: $0 to: 2).
		self array
			do: [ :value | stream print: value ]
			separatedBy: [ stream nextPut: $, ] ].
	^ commandString.