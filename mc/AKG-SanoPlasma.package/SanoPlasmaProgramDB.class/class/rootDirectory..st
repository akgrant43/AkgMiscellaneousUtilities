instance creation
rootDirectory: rootDir

	^self new 
		fileName: rootDir / 'custom.csv';
		yourself