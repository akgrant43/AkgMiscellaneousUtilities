accessing
at: aTime 
	"Answer the value (-1 to 1) for the given time"
	| baseTime |

	baseTime := aTime \\ period.

	baseTime <= (period * 0.25) ifTrue:
		[ ^ baseTime * 4 / period ].
	baseTime < (period * 0.75) ifTrue: 
		[ ^ (period / 2 - baseTime) * 4 / period ].
	^ (baseTime - (period * 0.75)) * 4 / period - 1.