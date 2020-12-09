private
odtToPDF: odtFileReference
	"Convert the supplied odt file to pdf"
	| proc cmd args |

	cmd := '/usr/bin/soffice'.
	args := Array streamContents: [ :argsStream |
		argsStream
			nextPut: '--headless';
			nextPut: '--convert-to';
			nextPut: 'pdf';
			nextPut: odtFileReference fullName ].
	proc := GtUnixSubprocess command: cmd arguments: args.
	proc workingDirectory: odtFileReference parent.
	proc removeLD_LIBRARY_PATH.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to pdf' ]
	ifFalse: 
		[ self error: 'pdf conversion error: ', proc stderr printString ].
	^ odtFileReference withExtension: 'pdf'