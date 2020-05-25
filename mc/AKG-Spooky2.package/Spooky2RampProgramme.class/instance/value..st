accessing
value: time 
	"Answer the frequency at the given time (in seconds)"
	| offset |

	offset := ((endFrequency - startFrequency) * ((time - 1) / duration \\ 1)) rounded.
	^ up 
		ifTrue: [ startFrequency + offset ]
		ifFalse: [ endFrequency - offset ].