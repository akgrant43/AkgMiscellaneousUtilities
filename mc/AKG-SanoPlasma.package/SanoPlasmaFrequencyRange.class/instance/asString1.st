converting
asString1
	"Don't really understand this format yet (thus the meaningless name)"

	^String streamContents: [ :stream |
		stream
			<< fromFrequency asString;
			<< ';'.
		toFrequency ifNotNil: [ stream << toFrequency asString ].
		stream << ';'.
		dwell ifNotNil: [ stream << dwell asString ].
		stream << ';;;;;;;;;;;;;;;;;;' ]