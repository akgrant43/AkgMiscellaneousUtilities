initialization
keysFromPresetString: aString
	"Answer the list of valid keys from the supplied string (preset file contents)"

	| equalsIndex start end fieldName keys |
	keys := SanoPlasmaPreset template lines
		collect: [ :each | 
			fieldName := nil.
			equalsIndex := each indexOf: $=.
			equalsIndex > 0
				ifTrue: [ end := equalsIndex - 1.
					start := each first = $"
						ifTrue: [ 2 ]
						ifFalse: [ 1 ].
					fieldName := each copyFrom: start to: end ].
			fieldName ].
	keys := keys select: [ :each | each isNotNil ].
	^keys storeString