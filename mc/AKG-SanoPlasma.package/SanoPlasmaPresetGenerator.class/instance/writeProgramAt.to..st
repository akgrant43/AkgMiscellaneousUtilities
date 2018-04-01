private
writeProgramAt: freq to: customCsvStream
	"Add an entry to the supplied CSV stream"

	customCsvStream 
		nextPut: $";
		<< (self programNameAt: freq);
		<< '",CUST,,"","';
		<< freq asString;
		<< '-';
		<< (freq + freqRange) asString;
		<< '",,,';
		<< programSeconds asString;
		crlf.
