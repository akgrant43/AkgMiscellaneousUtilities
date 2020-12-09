actions
markdownStringToPDF: aString
	| odtFile |

	odtFile := self markdownStringToODT: aString.
	^ self odtToPDF: odtFile.