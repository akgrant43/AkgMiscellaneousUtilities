tests
testNonAsciiReplacement
	"Confirm that non-ascii characters are replaced as requested"
	
	| af |
	
	af := AsciiFilename new
		replacementString: '-';
		decodeName: false;
		yourself.
	self assert: (af clean: 'love ❤ it.txt') equals: 'love - it.txt'