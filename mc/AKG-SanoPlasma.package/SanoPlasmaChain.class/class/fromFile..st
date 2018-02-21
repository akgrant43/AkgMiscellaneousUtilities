instance creation
fromFile: aFilename

	^aFilename asFileReference readStreamDo: [ :stream |
		(self fromStream: stream)
			name: aFilename basename;
			yourself ]