instance creation
fromString: aString
	"Create an instance of the receiver from the supplied string in SanoPlasma format"

	| regex match newRange waveform gating |

	regex := '([.\d]+)-?([.\d]+)?=?(\d+)?(W\d)?(G\d)?' asRegex.
	match := regex matches: aString.
	self assert: match description: aString, ' doesn''t parse as frequency range'.
	newRange := self new
		fromFrequency: (regex subexpression: 2) asNumber;
		toFrequency: (regex subexpression: 3) asNumberOrNil;
		dwell: (regex subexpression: 4) asNumberOrNil.
	waveform := regex subexpression: 5.
	waveform ifNotNil: [ 
		newRange waveform: (waveform at: 2) asString asNumber ].
	gating := regex subexpression: 6.
	gating ifNotNil: [ 
		newRange gating: (gating at: 2) asString asNumber ].
	^newRange