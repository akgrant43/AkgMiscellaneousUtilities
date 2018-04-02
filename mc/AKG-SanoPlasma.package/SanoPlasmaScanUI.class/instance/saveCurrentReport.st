private
saveCurrentReport
	"Save the currently selected report"

	| cmdString |

	currentReport ifNil: [ ^self ].
	currentReport saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { currentReport reportFilename }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: currentReport reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ UIManager default inform: 'Successfully converted report to pdf' ]
				ifFalse: [ self halt: 'Something went wrong' ] ] ] forkNamed: 'SanoPlasma Print'.