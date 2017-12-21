accessing
outDir: aDirectory

	outDir := aDirectory asFileReference.
	outDir isDirectory ifFalse: [ 
		outDir parent isDirectory ifFalse: 
			[self error: 'outDir parent must exist'].
		outDir ensureCreateDirectory ].