private
printPDF: pdfFileReference
	"Print the PDF file"

	| proc cmd args |

	cmd := '/usr/bin/lp'.
	args := Array streamContents: [ :argsStream |
		argsStream
			nextPut: '-d';
			nextPut: self printerName;
			nextPut: '-h';
			nextPut: self printerHost.
		self printOptions do: [ :option |
			argsStream
				nextPut: '-o';
				nextPut: option ].
		argsStream nextPut: pdfFileReference fullName ].

	proc := GtSubprocessWithInMemoryOutput command: cmd arguments: args.
	proc workingDirectory: self tempDir.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully submitted print job' ]
	ifFalse: 
		[ self error: 'print submission error: ', proc stderr printString ].
