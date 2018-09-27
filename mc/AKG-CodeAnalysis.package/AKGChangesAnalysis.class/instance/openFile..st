instance creation
openFile: aFilename

	| changeSet |
	
	fileName := aFilename asFileReference.
	changeSet := CodeImporter fileNamed: fileName.
	changeSet parseChunks.
	externalChanges := changeSet codeDeclarations.
