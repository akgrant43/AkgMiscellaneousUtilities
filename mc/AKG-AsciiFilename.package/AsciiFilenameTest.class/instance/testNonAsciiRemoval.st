tests
testNonAsciiRemoval
	"Confirm that non-ascii characters are removed (default behaviour)"
	
	| af |
	
	af := AsciiFilename new.
	self assert: (af toAscii: 'love ❤ it.txt') equals: 'love  it.txt'