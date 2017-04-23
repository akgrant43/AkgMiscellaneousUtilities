tests
testDiacritics
	"Do a non-exhaustive test that diacritics are replaced"

	| af |
	
	af := AsciiFilename new.
	self assert: (af toAscii: 'ěščřžýáíé.txt') = 'escrzyaie.txt'