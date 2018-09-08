accessing
addPandocOption: aString
	"Add the supplied option to the enscript command (unchecked)"

	pandocOptions := enscriptOptions copyWith: aString.