printing
reportString
	"Answer the top 30 matches"

	| sortedByMagnitude sortedByFrequency report |

	sortedByMagnitude := self scanData sorted: [ :a :b | (a at: 3) > (b at: 3) ].
	sortedByMagnitude := sortedByMagnitude first: (30 min: sortedByMagnitude size).
	sortedByFrequency := sortedByMagnitude sorted: [ :a :b | (a at: 2) < (b at: 2) ].
	report := String streamContents: [ :stream |
		stream
			<< 'Filename: ';
			<< self fileReference basename;
			cr;
			<< 'Date: ';
			<< (self class fileNameDate: self fileReference) printString;
			cr;
			<< 'ID: ';
			<< (self class fileNameID: self fileReference);
			cr;
			cr; cr.
		stream
			<< 'Results by Magnitude'; cr;
			<< '===================='; cr;
			cr;
			<< '  Freq(Hz) MonitoredValue'; cr;
			<< '  -------- --------------';
			cr.
		sortedByMagnitude do: [ :each | 
			stream
				<< (each second asNumber printPaddedWith: Character space to: 8);
				<< '   ';
				<< (each third asNumber printShowingDecimalPlaces: 2);
				cr ].
		stream 
			cr; cr; cr;
			nextPut: (Character value: 12).
		stream
			<< 'Results by Frequency'; cr;
			<< '===================='; cr;
			cr;
			<< '  Freq(Hz) MonitoredValue'; cr;
			<< '  -------- --------------';
			cr.
		sortedByFrequency do: [ :each | 
			stream
				<< (each second asNumber printPaddedWith: Character space to: 8);
				<< '   ';
				<< (each third asNumber printShowingDecimalPlaces: 2);
				cr ].
		 ].
	^report