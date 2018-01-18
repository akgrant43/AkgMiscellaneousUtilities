initialization
settingsDictionaryFromPresetString: aString
	"Answer the list of valid keys from the supplied string (preset file contents)"

	| equalsIndex keyStart keyEnd fieldName valueStart valueEnd fieldValue settings |
	settings := Dictionary new.
	SanoPlasmaPreset template lines do: [ :each | 
			fieldName := nil.
			fieldValue := nil.
			equalsIndex := each indexOf: $=.
			equalsIndex > 0 ifTrue: [ 
				keyEnd := equalsIndex - 1.
				keyStart := each first = $"
					ifTrue: [ 2 ]
					ifFalse: [ 1 ].
				fieldName := each copyFrom: keyStart to: keyEnd.
				valueStart := equalsIndex + 1.
				valueEnd := each last = $"
					ifTrue: [ each size - 1 ]
					ifFalse: [ each size ].
				fieldValue := each copyFrom: valueStart to: valueEnd.
				settings at: fieldName put: fieldValue ].
			].
	^settings