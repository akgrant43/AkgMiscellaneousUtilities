private
clean: aFilename
	"Convert the supplied filename string to its ascii equivalent.
	Remove any diacritic marks, remove / replace non-ascii characters
	and remove non-Windows compliant characters if requested"

	| result |

	"First try to decode the filename"
	result := decodeName 
		ifTrue: [ self decode: aFilename asByteArray ]
		ifFalse: [ aFilename ].

	"Remove diacritical marks"
	includeDiacritics ifFalse:
		[ result := result asNonDiacritical ].

	"Remove / replace non-printable characters"
	result := String streamContents: [ :stream |
			result do: [ :char |
				char asciiValue <= 31 ifTrue:
						[ stream nextPutAll: replacementString ]
					ifFalse:
						[ stream nextPut: char ] ] ].

	"Remove / replace non-ascii characters"
	asciiOnly ifTrue:
		[ result := String streamContents: [ :stream |
			result do: [ :char |
				char asciiValue >= 127 ifTrue:
						[ stream nextPutAll: replacementString ]
					ifFalse:
						[ stream nextPut: char ] ] ] ].

	"Ensure windows compatibility, if requested"
	windowsCompatible ifTrue:
		[ result := String streamContents: [ :stream |
			result do: [ :char |
				('[<>:"?*\\|]' includes: char) ifTrue:
					[ stream nextPutAll: replacementString ]
				ifFalse:
					[ stream nextPut: char ] ] ] ].

	^result