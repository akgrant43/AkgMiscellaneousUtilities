saving
writeOn: aStream
	"Write the receiver on aStream in SanoPlasma text format"

	self class validKeyNames do: [ :keyName |
		aStream
			<< '"';
			<< keyName;
			<< '=';
			print: (self at: keyName);
			<< '"';
			cr ].