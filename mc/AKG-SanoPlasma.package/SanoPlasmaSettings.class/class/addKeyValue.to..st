instance creation
addKeyValue: aString to: settings

	| equalsIndex keyStart keyEnd fieldName valueStart valueEnd fieldValue |

	(aString includesSubstring: '[Preset]') ifTrue:
		"Ignore"
		[ ^self ].

	fieldName := nil.
	fieldValue := nil.
	equalsIndex := aString indexOf: $=.
	equalsIndex > 0 ifTrue: [ 
		keyEnd := equalsIndex - 1.
		keyStart := aString first = $"
			ifTrue: [ 2 ]
			ifFalse: [ 1 ].
		fieldName := aString copyFrom: keyStart to: keyEnd.
		valueStart := equalsIndex + 1.
		valueEnd := aString last = $"
			ifTrue: [ aString size - 1 ]
			ifFalse: [ aString size ].
		fieldValue := aString copyFrom: valueStart to: valueEnd.
		settings at: fieldName put: fieldValue ].
