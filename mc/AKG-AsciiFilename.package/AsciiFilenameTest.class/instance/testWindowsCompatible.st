tests
testWindowsCompatible

	| af |
	
	af := AsciiFilename new
		windowsCompatible: true.
	self assert: (af clean: 'a <>:"\|?* filename.txt') equals: 'a  filename.txt'