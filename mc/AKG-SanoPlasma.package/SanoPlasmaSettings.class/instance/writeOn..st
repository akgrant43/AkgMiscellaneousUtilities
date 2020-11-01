saving
writeOn: aStream
	"Write the receiver on aStream in SanoPlasma text format"

	"Strings should be written without quotes"
	self class validKeyNames do: [ :keyName |
		aStream
			<< '"';
			<< keyName;
			<< '=';
			<< (self at: keyName) asString;
			<< '"';
			cr ].