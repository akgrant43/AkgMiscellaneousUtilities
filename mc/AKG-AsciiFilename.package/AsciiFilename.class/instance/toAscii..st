private
toAscii: aFilename
	"Convert the supplied filename to its ascii equivalent.
	Remove any diacritic marks, remove / replace non-ascii characters
	and remove non-Windows compliant characters if requested"

	| result |

	"Remove diacritical marks"	
	result := aFilename asNonDiacritical.
	"Remove / replace non-ascii characters"
	result := String streamContents: [ :stream |
		result do: [ :char |
			((char asciiValue <= 31 or: [char asciiValue >= 127]) or:
				[ windowsCompatible and: [ '[<>:"?*\\|]' includes: char ]]) ifTrue:
					[ stream nextPutAll: replacementString ]
				ifFalse:
					[ stream nextPut: char ] ] ].
	^result