private
writeProgramAt: freq to: customCsvStream
	"Add an entry to the supplied CSV stream"

	| fromFreq toFreq |

	fromFreq := freq.
	fromFreq = 0 ifTrue: [ fromFreq := 1 ].
	toFreq := freq + freqRange.
	toFreq = 0 ifTrue: [ toFreq := 1 ].
	customCsvStream 
		nextPut: $";
		<< (self programNameAt: freq);
		<< '",CUST,,"","';
		<< fromFreq asString;
		<< '-';
		<< toFreq asString;
		<< '",,,';
		<< programSeconds asString;
		crlf.
