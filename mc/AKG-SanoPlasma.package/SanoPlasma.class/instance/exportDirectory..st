accessing
exportDirectory: aFileReference
	"Set the export directory to the supplied reference.
	Ensure the directory exists and update the report directory."

	exportDirectory := aFileReference asFileReference.
	self assert: exportDirectory exists.
	self assert: exportDirectory isDirectory.
	self reportDirectory: exportDirectory / 'Reports'.
