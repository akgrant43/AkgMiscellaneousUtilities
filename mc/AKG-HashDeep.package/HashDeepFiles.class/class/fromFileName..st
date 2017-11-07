instance creation
fromFileName: fileReferenceOrString

	| fileReference |

	fileReference := fileReferenceOrString asFileReference.
	^fileReference readStreamDo: [ :stream |
		self fromName: fileReference stream: stream ]