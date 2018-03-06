printing
reportString
	"Answer the top 30 matches"

	| sortedData report |

	sortedData := self scanData sorted: [ :a :b | (a at: 3) > (b at: 3) ].
	sortedData := sortedData first: (30 min: sortedData size).
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
			<< '  Freq(Hz) MonitoredValue'; cr;
			<< '  ======== ==============';
			cr.
		sortedData do: [ :each | 
			stream
				<< (each second asNumber printPaddedWith: Character space to: 8);
				<< '   ';
				<< (each third asNumber printShowingDecimalPlaces: 2);
				cr ] ].
	^report