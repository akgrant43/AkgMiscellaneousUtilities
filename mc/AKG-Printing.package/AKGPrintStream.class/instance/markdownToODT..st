private
markdownToODT: markdownFileReference
	"Convert the supplied markdown file to pdfTemporary"

	| proc cmd args odtFileReference |

	self assert: markdownFileReference extension = 'md'
		description: 'pandoc uses the extension to determine contents'.
	odtFileReference := markdownFileReference withExtension: 'odt'.
	cmd := '/usr/bin/pandoc'.
	args := Array streamContents: [ :argsStream |
		argsStream 
			nextPut: markdownFileReference fullName.
		pandocOptions do: [ :pOption |
			argsStream nextPut: pOption ].
		argsStream
			nextPut: '-o';
			nextPut: odtFileReference fullName ].
	proc := GtUnixSubprocess command: cmd arguments: args.
	proc workingDirectory: markdownFileReference parent.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to odt' ]
	ifFalse: 
		[ self error: 'ODT conversion error: ', proc stderr printString ].
	^ odtFileReference
