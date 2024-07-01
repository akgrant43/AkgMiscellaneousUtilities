"
AsciiFilename takes a an input string, normally a filename and removes diacritical marks, non-printable characters, non-ascii characters (asciiValue >= 127) and optionally Windows restricted characters.

E.g. to convert just the filename

	^AsciiFilename new
		windowsCompatible: true;
		toAscii: 'I ❤: this utility.txt'

To rename the file:

	AsciiFilename new
		windowsCompatible: true;
		rename: 'I ❤: this utility.txt'

"
Class {
	#name : #AsciiFilename,
	#superclass : #Object,
	#instVars : [
		'encoders',
		'replacementString',
		'windowsCompatible',
		'dryRun',
		'includeDiacritics',
		'decodeName',
		'asciiOnly'
	],
	#category : 'AKG-AsciiFilename'
}

{ #category : #fixing }
AsciiFilename class >> fixFile: inFile to: outFile [
	"Read each line of the supplied file and fix the basename"
	| asciiFilename lf line basename newName segments fullName |

	lf := Character lf asciiValue.
	asciiFilename := self new 
		includeDiacritics: false;
		dryRun: true;
		windowsCompatible: true;
		replacementString: '.';
		yourself.
	inFile asFileReference binaryReadStreamDo: [ :readStream |
		outFile asFileReference writeStreamDo: [ :writeStream |
			[ readStream atEnd ] whileFalse:
				[ line := readStream upTo: lf.
				segments := $/ split: line asString.
				segments ifNotEmpty: 
					[ basename := segments last.
					newName := asciiFilename clean: basename.
					segments at: segments size put: newName.
					fullName := $/ join: segments.
					writeStream 
						<< fullName;
						lf ] ].
				writeStream truncate. ] ].
]

{ #category : #private }
AsciiFilename >> clean: aFilename [
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
]

{ #category : #converting }
AsciiFilename >> decode: aByteArray [
	"Attempt to decode the supplied byte array"

	encoders do: [ :encoder |
		[ ^encoder decodeBytes: aByteArray ] 
			on: Error do: [ nil ] ].
	^ aByteArray asString.
]

{ #category : #accessing }
AsciiFilename >> decodeName [
	^ decodeName
]

{ #category : #accessing }
AsciiFilename >> decodeName: anObject [
	decodeName := anObject
]

{ #category : #accessing }
AsciiFilename >> dryRun [
	^ dryRun
]

{ #category : #accessing }
AsciiFilename >> dryRun: anObject [
	dryRun := anObject
]

{ #category : #accessing }
AsciiFilename >> includeDiacritics [
	^ includeDiacritics
]

{ #category : #accessing }
AsciiFilename >> includeDiacritics: anObject [
	includeDiacritics := anObject
]

{ #category : #initialize }
AsciiFilename >> initialize [

	super initialize.
	replacementString := ''.
	windowsCompatible := true.
	dryRun := false.
	includeDiacritics := false.
	asciiOnly := true.
	decodeName := false.
	encoders := { 
		ZnCharacterEncoder utf8.
		ZnCharacterEncoder latin1.
		ZnCharacterEncoder iso88591. }.

]

{ #category : #executing }
AsciiFilename >> rename: aFilename [
	"Rename the supplied file to an ascii only equivalent"

	| newFilename |

	newFilename := self clean: aFilename.
	dryRun ifFalse: 
		[ aFilename asFileReference renameTo: newFilename ].
	^newFilename
]

{ #category : #accessing }
AsciiFilename >> replacementString [
	^ replacementString
]

{ #category : #accessing }
AsciiFilename >> replacementString: anObject [
	replacementString := anObject
]

{ #category : #accessing }
AsciiFilename >> windowsCompatible [
	^ windowsCompatible
]

{ #category : #accessing }
AsciiFilename >> windowsCompatible: anObject [
	windowsCompatible := anObject
]
