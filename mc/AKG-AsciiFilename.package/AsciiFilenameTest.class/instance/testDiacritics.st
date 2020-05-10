tests
testDiacritics
	"Do a non-exhaustive test that diacritics are replaced"

	| af |
	
	af := AsciiFilename new.
	af 
		includeDiacritics: false;
		decodeName: false.
	self assert: (af clean: 'ěščřžýáíé.txt') equals: 'escrzyaie.txt'