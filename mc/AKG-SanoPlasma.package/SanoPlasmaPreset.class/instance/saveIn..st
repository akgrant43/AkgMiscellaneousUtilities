writing
saveIn: aDirectory
	"Save the receiver in the supplied directory"

	| fileName |

	self assert: aDirectory parent isDirectory description: 'Parent directory must exist'.
	aDirectory ensureCreateDirectory.
	fileName := self fileNameIn: aDirectory.

	fileName writeStreamDo: [ :stream | self writeOn: stream ].
