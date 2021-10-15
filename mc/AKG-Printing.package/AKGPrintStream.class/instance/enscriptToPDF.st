converting
enscriptToPDF
	"Convert #textTemporary to a #pdfTemporary"
	| cmdString |

	cmdString := 'enscript -B {1} -o - | ps2pdf - {2}' format: 
		{ self textTemporary fullName. self pdfTemporary fullName. }.
	GtSubprocessWithInMemoryOutput new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		errorBlock: [ self error: 'Unable to convert to PDF' ];
		runAndWait.
	UIManager default inform: 'Successfully converted report to pdf'.