accessing
addFrequencies: aString
	"Add the list of frequency ranges encoded in the supplied string"

	aString ifNil: [ ^self ].
	(',' split: aString) do: [ :range |
		self addFrequency: (SanoPlasmaFrequencyRange fromString: range) ].