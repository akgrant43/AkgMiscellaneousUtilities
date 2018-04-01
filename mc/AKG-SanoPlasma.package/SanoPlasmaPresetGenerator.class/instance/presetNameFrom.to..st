accessing
presetNameFrom: startFrequency to: endFrequency
	"Generate the program name from the frequency in the form:
			<namePrefix> <startFrequency>-<endFrequency>
	frequency is assumed to be less than 1 million"
	^String streamContents: [ :stream | | freqString |
		"Put the prefix"
		stream
			<< namePrefix;
			<< ' '.

		"Next the startFreq.
		If possible, represent as an integer number of kHz, otherwise as decimal"
		freqString := startFrequency printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3).
		(freqString endsWith: '000') ifFalse: [ 
			stream
				<< '.';
				<< (freqString copyFrom: 4 to: 6) ].

		stream << '-'.

		"Next the endFreq.
		If possible, represent as an integer number of kHz, otherwise as decimal"
		freqString := endFrequency printPaddedWith: $0 to: 6.
		stream
			<< (freqString copyFrom: 1 to: 3).
		(freqString endsWith: '000') ifFalse: [ 
			stream
				<< '.';
				<< (freqString copyFrom: 4 to: 6) ] ].
