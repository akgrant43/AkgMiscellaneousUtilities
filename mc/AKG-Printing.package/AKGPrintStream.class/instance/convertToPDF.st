private
convertToPDF
	"Convert textTemporary to pdfTemporary"

	| process cmdString |

	cmdString := String streamContents: [ :stream |
		stream << 'paps'.
		enscriptOptions do: [ :option | 
			stream 
				<< ' ';
				<< option ].
		stream << ' {1} | ps2pdf - {2}' ].
	cmdString := cmdString format: { 
		self textTemporary fullName.
		self pdfTemporary fullName }.
	process := GtSubprocessWithInMemoryOutput new 
		shellCommand: cmdString;
		workingDirectory: self tempDir fullName;
		errorBlock: [ :proc | self error: 'Failed to convert to pdf' ];
		runAndSignal.
	process waitTimeoutMSecs: 15000.
	UIManager default inform: 'Successfully converted text to pdf'.
