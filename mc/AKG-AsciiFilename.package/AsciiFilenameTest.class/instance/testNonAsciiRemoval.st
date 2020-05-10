tests
testNonAsciiRemoval
	"Confirm that non-ascii characters are removed (default behaviour)"
	
	| af |
	
	af := AsciiFilename new.
	af decodeName: false.
	self assert: (af clean: 'love ❤ it.txt') equals: 'love  it.txt'