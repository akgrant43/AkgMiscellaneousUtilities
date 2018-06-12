actions
printProblems
	"Print the receiver"

	| problems |

	problems := String streamContents: [ :stream | self printOn: stream ].
	AKGPrintStream printStream: problems readStream.
