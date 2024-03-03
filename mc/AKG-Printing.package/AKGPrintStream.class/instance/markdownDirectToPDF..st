private
markdownDirectToPDF: markdownFileReference
	"Convert the supplied markdown file to pdfTemporary"
	| proc cmd args pdfFileReference |

	self assert: markdownFileReference extension = 'md'
		description: 'pandoc uses the extension to determine contents'.
	pdfFileReference := markdownFileReference withExtension: 'pdf'.
	cmd := 'pandoc'.
	args := Array streamContents: [ :argsStream |
		argsStream 
			nextPut: markdownFileReference fullName.
		pandocOptions do: [ :pOption |
			argsStream nextPut: pOption ].
		argsStream
			nextPut: '-o';
			nextPut: pdfFileReference fullName ].
	proc := GtSubprocessWithInMemoryOutput command: cmd arguments: args.
	proc workingDirectory: markdownFileReference parent.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to pdf' ]
	ifFalse: 
		[ self error: 'PDF conversion error: ', proc stderr printString ].
	^ pdfFileReference