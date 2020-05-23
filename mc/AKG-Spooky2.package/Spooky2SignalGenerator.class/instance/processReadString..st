private
processReadString: aString
	| contents |

	contents := aString trimBoth.
	contents size > 0 ifTrue: 
		[ Stdio stdout << contents; lf.
		contents lines do: [ :line |
			line trimBoth = 'ok'
				ifTrue: [ writeSemaphore signal ]
				ifFalse: [ self error: 'Unexpected input' ] ] ].
