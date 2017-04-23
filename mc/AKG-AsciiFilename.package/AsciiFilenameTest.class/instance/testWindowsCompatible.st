tests
testWindowsCompatible

	| af |
	
	af := AsciiFilename new
		windowsCompatible: true.
	self assert: (af toAscii: 'a <>:"\|?* filename.txt') equals: 'a  filename.txt'