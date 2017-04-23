tests
testNonAsciiReplacement
	"Confirm that non-ascii characters are replaced as requested"
	
	| af |
	
	af := AsciiFilename new
		replacementString: '-'.
	self assert: (af toAscii: 'love ❤ it.txt') equals: 'love - it.txt'