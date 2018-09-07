accessing
addEnscriptOption: aString
	"Add the supplied option to the enscript command (unchecked)"

	enscriptOptions := enscriptOptions copyWith: aString.