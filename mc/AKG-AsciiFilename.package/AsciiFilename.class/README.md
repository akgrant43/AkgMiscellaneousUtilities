AsciiFilename takes a an input string, normally a filename and removes diacritical marks, non-printable characters, non-ascii characters (asciiValue >= 127) and optionally Windows restricted characters.

E.g. to convert just the filename

	^AsciiFilename new
		windowsCompatible: true;
		toAscii: 'I ❤: this utility.txt'

To rename the file:

	AsciiFilename new
		windowsCompatible: true;
		rename: 'I ❤: this utility.txt'
