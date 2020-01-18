private
markdownToPDF
	"Convert textTemporary (in markdown format) to pdfTemporary"

	| processSemaphore cmdString |

	processSemaphore := Semaphore new.
	cmdString := String streamContents: [ :stream |
		stream << 'pandoc'.
		pandocOptions do: [ :option | 
			stream 
				<< ' ';
				<< option ].
		stream << ' {1} -o {2}' ].
	cmdString := cmdString format: { 
		self textTemporary fullName.
		self pdfTemporary fullName }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted pillar to pdf'.
					processSemaphore signal. ]
				ifFalse: [ self error: 'PDF conversion error: ', stderr printString ].
			processSemaphore := nil. ] ] forkNamed: 'AKGPrintStream PDF conversion'.
	(processSemaphore waitTimeoutSeconds: 15) ifTrue: 
		[ self error: 'Timeout on pdf conversion' ].
