executing
rename: aFilename
	"Rename the supplied file to an ascii only equivalent"

	| newFilename |

	newFilename := self clean: aFilename.
	dryRun ifFalse: 
		[ aFilename asFileReference renameTo: newFilename ].
	^newFilename