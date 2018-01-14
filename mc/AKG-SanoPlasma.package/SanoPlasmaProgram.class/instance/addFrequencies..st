accessing
addFrequencies: aString
	"Add the list of frequency ranges encoded in the supplied string"

	(',' split: aString) do: [ :range |
		self addFrequency: (SanoPlasmaFrequencyRange fromString: range) ].