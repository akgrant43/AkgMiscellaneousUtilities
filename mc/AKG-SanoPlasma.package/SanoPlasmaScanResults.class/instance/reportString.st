printing
reportString
	"Answer the top 30 matches"

	| data maxRecords numRecords sortedByMagnitude sortedByFrequency report |

	maxRecords := 55.
	data := self scanData.
	data ifNil:
		[ ^self fileReference fullName, ' is not a valid scan results file' ].
	numRecords := maxRecords min: data size.
	sortedByMagnitude := data sorted: [ :a :b | (a at: 3) > (b at: 3) ].
	sortedByMagnitude := sortedByMagnitude first: numRecords.
	sortedByFrequency := sortedByMagnitude sorted: [ :a :b | (a at: 2) < (b at: 2) ].
	report := String streamContents: [ :stream |
		stream
			<< 'Filename: ';
			<< self fileReference basename;
			cr;
			<< 'Date:     ';
			<< (self class fileNameDate: self fileReference) printString;
			cr;
			<< 'ID:       ';
			<< (self class fileNameID: self fileReference);
			cr;
			cr; cr.
		stream
			<< 'Results by Magnitude                  Results by Frequency'; cr;
			<< '====================                  ===================='; cr;
			cr;
			<< 'Freq(Hz)   MonitoredValue             Freq(Hz)   MonitoredValue'; cr;
			<< '--------   --------------             --------   --------------';
			cr.
		1 to: numRecords do: [ :index | | magnitude frequency |
			magnitude := sortedByMagnitude at: index.
			frequency := sortedByFrequency at: index.
			stream
				<< (magnitude second asNumber printPaddedWith: Character space to: 8);
				<< ((magnitude third asNumber printShowingDecimalPlaces: 2) padLeftTo: 8);
				<< (frequency second asNumber printPaddedWith: Character space to: 28);
				<< ((frequency third asNumber printShowingDecimalPlaces: 2) padLeftTo: 10);
				cr ].
		 ].
	^report