private
printPDF
	"Print the PDF file"

	| cmdString |

	cmdString := 'lp -d {printerName} -h {printerHost} ' format: 
		{ 'printerName' -> self printerName.
			'printerHost' -> self printerHost. } asDictionary.
	self printOptions do: [ :option |
		cmdString := cmdString, '-o ', option, ' ' ].
	cmdString := cmdString, self pdfTemporary fullName.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ UIManager default inform: 'Successfully printed stream' ]
				ifFalse: [ self error: 'Something went wrong' ] ] ] forkNamed: 'AKGPrintStream print'.