actions
markdownStringToODT: aString
	"Print the supplied markdown string"
	| mdFile |

	mdFile := self mdTemporary.
	mdFile writeStreamDo: [ :stream |
		stream asNewLineStream nextPutAll: aString ].
	^ self markdownToODT: mdFile