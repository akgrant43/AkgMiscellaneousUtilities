accessing
fileNameID: aFileReference
	"Answer the date encoded in the supplied file.
	The filename is assumed to be DDMMYYYYxxxx"

	| basename extensionStart |

	basename := aFileReference basename.
	extensionStart := basename indexOfSubCollection: '.csv'.
	^basename copyFrom: 9 to: extensionStart-1.