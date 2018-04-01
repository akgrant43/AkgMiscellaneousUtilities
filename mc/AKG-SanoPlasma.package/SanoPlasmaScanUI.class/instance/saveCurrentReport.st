private
saveCurrentReport
	"Save the currently selected report"

	| cmdString |

	currentReport ifNil: [ ^self ].
	currentReport saveReportString.
	cmdString := 'enscript -B {1} -o - | ps2pdf - {1}.pdf' format: { currentReport reportFilename }.
	OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: currentReport reportDirectory;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | self halt. ]