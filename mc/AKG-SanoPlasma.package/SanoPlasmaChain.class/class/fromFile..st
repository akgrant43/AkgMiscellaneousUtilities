instance creation
fromFile: aFilename

	^aFilename asFileReference readStreamDo: [ :stream |
		self fromStream: stream ]