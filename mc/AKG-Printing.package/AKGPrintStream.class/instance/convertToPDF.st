private
convertToPDF
	"Convert textTemporary to pdfTemporary"

	| processSemaphore cmdString |

	processSemaphore := Semaphore new.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { self textTemporary fullName }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted text to pdf'.
					processSemaphore signal. ]
				ifFalse: [ self error: 'Something went wrong' ].
			processSemaphore := nil. ] ] forkNamed: 'AKGPrintStream PDF conversion'.
	(processSemaphore waitTimeoutSeconds: 15) ifTrue: 
		[ self error: 'Timeout on pdf conversion' ].
