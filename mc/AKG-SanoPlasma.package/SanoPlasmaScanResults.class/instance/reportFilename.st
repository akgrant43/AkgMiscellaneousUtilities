reports
reportFilename
	"Answer the receivers report filename"

	^self fileReference basenameWithoutExtension, '.txt'.
