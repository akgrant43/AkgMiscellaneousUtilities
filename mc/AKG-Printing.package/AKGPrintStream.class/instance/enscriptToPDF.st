as yet unclassified
enscriptToPDF
	"Convert #textTemporary to a #pdfTemporary"
	| cmdString |

	cmdString := 'enscript -B {1} -o - | ps2pdf - {2}' format: 
		{ self textTemporary fullName. self pdfTemporary fullName. }.
	OSSUnixSubprocess new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		redirectStderr;
		redirectStdout;
		runAndWaitOnExitDo: [ :cmd :stdout :stderr | 
			cmd isSuccess 
				ifTrue: [ 
					UIManager default inform: 'Successfully converted report to pdf'. ]
				ifFalse: [ self error: 'Something went wrong' ] ].