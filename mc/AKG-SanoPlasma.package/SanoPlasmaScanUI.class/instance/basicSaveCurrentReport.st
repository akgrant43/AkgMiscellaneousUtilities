private
basicSaveCurrentReport
	"Save the currently selected report"

	| cmdString |

	currentReport ifNil: [ ^self ].
	processSemaphore ifNotNil: [ self error: 'Already processing' ].
	processSemaphore := Semaphore new.
	currentReport saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { currentReport reportFilename }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: currentReport reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted report to pdf'.
					processSemaphore signal. ]
				ifFalse: [ self halt: 'Something went wrong' ].
			processSemaphore := nil. ] ] forkNamed: 'SanoPlasma PDF conversion'.