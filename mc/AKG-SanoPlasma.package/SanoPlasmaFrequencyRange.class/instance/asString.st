converting
asString
	"Conver the receiver to it's SanoPlasma string representation"

	^String streamContents: [ :stream |
		stream << fromFrequency asString.
		toFrequency ifNotNil: [ 
			stream
				<< '-';
				<< toFrequency asString ].
		dwell ifNotNil: [ 
			stream
				<< '=';
				<< dwell asString ].
		waveform ~= 1 ifTrue: [ 
			stream
				<< 'W';
				<< waveform asString ].
		gating ~= 0 ifTrue: [ 
			stream
				<< 'G';
				<< gating asString ] ]