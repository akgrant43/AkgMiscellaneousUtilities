private - accessing
frequenciesDefinition
	"Answer a string defining the frequencies in the program in SanoPlasma program string format"

	^String streamContents: [ :stream |
		stream
			<< self fromFrequency asString;
			<< '-';
			<< self toFrequency asString;
			<< '=';
			<< self timeInSeconds asString ]
