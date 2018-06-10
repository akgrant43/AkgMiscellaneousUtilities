actions
printProblems
	"Save the receiver to a temporary file, convert to pdf and print"

	| fileReference |

	fileReference := '/dev/shm/problems.txt' asFileReference.
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :stream |
		self printOn: (ZnNewLineWriterStream on: stream) ].
	