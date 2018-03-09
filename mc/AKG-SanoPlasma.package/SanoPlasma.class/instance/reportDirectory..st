accessing
reportDirectory: aFileReference
	"Set the report directory to the supplied reference.
	Ensure the parent directory exists and create if necessary."

	reportDirectory := aFileReference asFileReference.
	self assert: reportDirectory parent exists.
	reportDirectory ensureCreateDirectory