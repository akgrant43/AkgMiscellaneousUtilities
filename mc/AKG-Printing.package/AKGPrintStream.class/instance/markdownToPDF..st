private
markdownToPDF: markdownFileReference
	"Convert the supplied markdown file to pdfTemporary"

	| proc cmd args |

	self assert: markdownFileReference extension = 'md'
		description: 'pandoc uses the extension to determine contents'.
	cmd := '/usr/bin/pandoc'.
	args := Array streamContents: [ :argsStream |
		argsStream 
			nextPut: markdownFileReference fullName.
		pandocOptions do: [ :pOption |
			argsStream nextPut: pOption ].
		argsStream
			nextPut: '-o';
			nextPut: self odtTemporary fullName ].
	proc := GtUnixSubprocess command: cmd arguments: args.
	proc workingDirectory: self tempDir.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to odt' ]
	ifFalse: 
		[ self error: 'ODT conversion error: ', proc stderr printString ].


	cmd := '/usr/bin/soffice'.
	args := Array streamContents: [ :argsStream |
		argsStream
			nextPut: '--headless';
			nextPut: '--convert-to';
			nextPut: 'pdf';
			nextPut: self odtTemporary fullName ].
	proc := GtUnixSubprocess command: cmd arguments: args.
	proc workingDirectory: self tempDir.
	proc removeLD_LIBRARY_PATH.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to pdf' ]
	ifFalse: 
		[ self error: 'pdf conversion error: ', proc stderr printString ].
