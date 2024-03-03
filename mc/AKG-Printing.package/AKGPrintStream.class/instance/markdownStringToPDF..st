actions
markdownStringToPDF: aString
	| mdFile |

	mdFile := self mdTemporary.
	mdFile ensureDelete.
	mdFile writeStreamDo: [ :stream |
		stream asNewLineStream nextPutAll: aString ].
	^ self markdownDirectToPDF: mdFile.