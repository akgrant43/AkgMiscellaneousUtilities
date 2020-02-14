reports
savePDF
	"Save the currently selected report"

	| cmdString |

	self saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - latest.pdf' format: { self reportFilename }.
	[ OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self reportDirectory fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted report to pdf'. ]
				ifFalse: [ self error: 'Something went wrong' ] ] ] 
					forkNamed: 'SanoPlasma PDF conversion'.