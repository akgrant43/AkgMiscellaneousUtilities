Class {
	#name : #AsciiFilenameTest,
	#superclass : #TestCase,
	#category : 'AKG-AsciiFilename-Test'
}

{ #category : #tests }
AsciiFilenameTest >> testDiacritics [
	"Do a non-exhaustive test that diacritics are replaced"

	| af |
	
	af := AsciiFilename new.
	af 
		includeDiacritics: false;
		decodeName: false.
	self assert: (af clean: 'ěščřžýáíé.txt') equals: 'escrzyaie.txt'
]

{ #category : #tests }
AsciiFilenameTest >> testNonAsciiRemoval [
	"Confirm that non-ascii characters are removed (default behaviour)"
	
	| af |
	
	af := AsciiFilename new.
	af decodeName: false.
	self assert: (af clean: 'love ❤ it.txt') equals: 'love  it.txt'
]

{ #category : #tests }
AsciiFilenameTest >> testNonAsciiReplacement [
	"Confirm that non-ascii characters are replaced as requested"
	
	| af |
	
	af := AsciiFilename new
		replacementString: '-';
		decodeName: false;
		yourself.
	self assert: (af clean: 'love ❤ it.txt') equals: 'love - it.txt'
]

{ #category : #tests }
AsciiFilenameTest >> testWindowsCompatible [

	| af |
	
	af := AsciiFilename new
		windowsCompatible: true.
	self assert: (af clean: 'a <>:"\|?* filename.txt') equals: 'a  filename.txt'
]
