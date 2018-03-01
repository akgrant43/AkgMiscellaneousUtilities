accessing
programNameAt: frequency
	"Generate the program name from the frequency in the form:
			<namePrefix> <startFreq>-<endFreq>
	frequency is assumed to be less than 1 million"
	| freqString startFreqName endFreqName |

	freqString := frequency printPaddedWith: $0 to: 6.
	startFreqName := freqString copyFrom: 1 to: 3.
	(freqString at: 4) ~= $0 ifTrue:
		[ startFreqName := startFreqName, '.', (freqString at: 4) asString ].
	freqString := (frequency + freqRange) printPaddedWith: $0 to: 6.
	endFreqName := freqString copyFrom: 1 to: 3.
	(freqString at: 4) ~= $0 ifTrue:
		[ endFreqName := endFreqName, '.', (freqString at: 4) asString ].

	^String streamContents: [ :stream |
		stream
			<< namePrefix;
			<< ' ';
			<< startFreqName;
			<< '-';
			<< endFreqName ].
