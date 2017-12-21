accessing
programNameAt: frequency

	| freqString startFreqName endFreqName |

	freqString := frequency asString.
	startFreqName := freqString copyFrom: 1 to: 3.
	(freqString at: 4) ~= $0 ifTrue:
		[ startFreqName := startFreqName, '.', (freqString at: 4) asString ].
	freqString := (frequency + freqRange) asString.
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
