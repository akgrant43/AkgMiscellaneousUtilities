"
AKGPrintStream provides a simple way of printing a stream (specific to my home).

The process is: 

- Write the stream to a temporary text file (textTemporary)
- Convert the text file to a pdf (pdfTemporary)
- Print the pdf file to the specified printer (lp -h {printerIp} -d {printerName})


Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AKGPrintStream,
	#superclass : #Object,
	#instVars : [
		'basename',
		'printerHost',
		'printerName',
		'printOptions',
		'enscriptOptions',
		'pandocOptions',
		'tempDir'
	],
	#category : 'AKG-Printing'
}

{ #category : #accessing }
AKGPrintStream >> addEnscriptOption: aString [
	"Add the supplied option to the enscript command (unchecked)"

	enscriptOptions := enscriptOptions copyWith: aString.
]

{ #category : #accessing }
AKGPrintStream >> addPandocOption: aString [
	"Add the supplied option to the enscript command (unchecked)"

	pandocOptions := pandocOptions copyWith: aString.
]

{ #category : #private }
AKGPrintStream >> basename [

	^basename ifNil: [ basename := self newTempBasename ]
]

{ #category : #accessing }
AKGPrintStream >> basename: anObject [

	basename := anObject
]

{ #category : #private }
AKGPrintStream >> convertToPDF [
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

]

{ #category : #converting }
AKGPrintStream >> enscriptToPDF [
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
]

{ #category : #initialization }
AKGPrintStream >> initialize [

	super initialize.
	tempDir := '/dev/shm/' asFileReference.
	printOptions := { 'fit-to-page' }.
	printerHost := '192.168.0.41:6631'.
	printerName := 'lbp6020'.
	enscriptOptions := { }.
	pandocOptions := #().
]

{ #category : #private }
AKGPrintStream >> markdownDirectToPDF: markdownFileReference [
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
]

{ #category : #actions }
AKGPrintStream >> markdownStringToODT: aString [
	"Print the supplied markdown string"
	| mdFile |

	mdFile := self mdTemporary.
	mdFile ensureDelete.
	mdFile writeStreamDo: [ :stream |
		stream asNewLineStream nextPutAll: aString ].
	^ self markdownToODT: mdFile
]

{ #category : #actions }
AKGPrintStream >> markdownStringToPDF: aString [
	| mdFile |

	mdFile := self mdTemporary.
	mdFile ensureDelete.
	mdFile writeStreamDo: [ :stream |
		stream asNewLineStream nextPutAll: aString ].
	^ self markdownDirectToPDF: mdFile.
]

{ #category : #private }
AKGPrintStream >> markdownToODT: markdownFileReference [
	"Convert the supplied markdown file to pdfTemporary"

	| proc cmd args odtFileReference |

	self assert: markdownFileReference extension = 'md'
		description: 'pandoc uses the extension to determine contents'.
	odtFileReference := markdownFileReference withExtension: 'odt'.
	cmd := 'pandoc'.
	args := Array streamContents: [ :argsStream |
		argsStream 
			nextPut: markdownFileReference fullName.
		pandocOptions do: [ :pOption |
			argsStream nextPut: pOption ].
		argsStream
			nextPut: '-o';
			nextPut: odtFileReference fullName ].
	proc := GtSubprocessWithInMemoryOutput command: cmd arguments: args.
	proc workingDirectory: markdownFileReference parent.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to odt' ]
	ifFalse: 
		[ self error: 'ODT conversion error: ', proc stderr printString ].
	^ odtFileReference

]

{ #category : #private }
AKGPrintStream >> markdownToPDF: markdownFileReference [
	"Convert the supplied markdown file to pdfTemporary"
	| odtFileReference |

	odtFileReference := self markdownToODT: markdownFileReference.
	^ self odtToPDF: odtFileReference.
]

{ #category : #accessing }
AKGPrintStream >> mdTemporary [
	^ self basename withExtension: 'md'
]

{ #category : #private }
AKGPrintStream >> newTempBasename [

	| random newBasename |

	[ 
		random := UUID new asInteger asString.
		newBasename := 'AKGPrintStream-', random.
		self tempDir entries 
			detect: [ :each | each reference basenameWithoutExtension = newBasename ]
			ifFound: [ true ]
			ifNone: [ false ] ] whileTrue.
	^self tempDir / newBasename
]

{ #category : #accessing }
AKGPrintStream >> odtTemporary [
	^ self basename withExtension: 'odt'
]

{ #category : #private }
AKGPrintStream >> odtToPDF: odtFileReference [
	"Convert the supplied odt file to pdf"
	| proc cmd args |

	cmd := 'soffice'.
	args := Array streamContents: [ :argsStream |
		argsStream
			nextPut: '--headless';
			nextPut: '--convert-to';
			nextPut: 'pdf';
			nextPut: odtFileReference fullName ].
	proc := GtSubprocessWithInMemoryOutput command: cmd arguments: args.
	proc workingDirectory: odtFileReference parent.
	proc removeLD_LIBRARY_PATH.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully converted markdown to pdf' ]
	ifFalse: 
		[ self error: 'pdf conversion error: ', proc stderr printString ].
	^ odtFileReference withExtension: 'pdf'
]

{ #category : #accessing }
AKGPrintStream >> pdfTemporary [
	^ self basename withExtension: 'pdf'
]

{ #category : #printing }
AKGPrintStream >> printMarkdownFile: aFileReference [
	"Print the supplied markdown file"

	self markdownToPDF: aFileReference.
	self printPDF: self pdfTemporary.
]

{ #category : #printing }
AKGPrintStream >> printMarkdownString: aString [
	| pdfFile |

	pdfFile := self markdownStringToPDF: aString.
	self printPDF: pdfFile.
]

{ #category : #accessing }
AKGPrintStream >> printOptions [
	^ printOptions
]

{ #category : #accessing }
AKGPrintStream >> printOptions: anObject [
	printOptions := anObject
]

{ #category : #private }
AKGPrintStream >> printPDF: pdfFileReference [
	"Print the PDF file"

	| proc cmd args |

	cmd := '/usr/bin/lp'.
	args := Array streamContents: [ :argsStream |
		argsStream
			nextPut: '-d';
			nextPut: self printerName;
			nextPut: '-h';
			nextPut: self printerHost.
		self printOptions do: [ :option |
			argsStream
				nextPut: '-o';
				nextPut: option ].
		argsStream nextPut: pdfFileReference fullName ].

	proc := GtSubprocessWithInMemoryOutput command: cmd arguments: args.
	proc workingDirectory: self tempDir.
	proc runAndWait.
	proc isSuccess ifTrue: 
		[ UIManager default inform: 'Successfully submitted print job' ]
	ifFalse: 
		[ self error: 'print submission error: ', proc stderr printString ].

]

{ #category : #actions }
AKGPrintStream >> printTextStream: aStream [
	"Print the supplied stream, converting to postscript using enscript and then to pdf with ps2pdf"

	self 
		writeToText: aStream;
		enscriptToPDF;
		printPDF: self pdfTemporary.
]

{ #category : #accessing }
AKGPrintStream >> printerHost [
	^ printerHost
]

{ #category : #accessing }
AKGPrintStream >> printerHost: anObject [
	printerHost := anObject
]

{ #category : #accessing }
AKGPrintStream >> printerName [
	^ printerName
]

{ #category : #accessing }
AKGPrintStream >> printerName: anObject [
	printerName := anObject
]

{ #category : #accessing }
AKGPrintStream >> tempDir [
	^ tempDir
]

{ #category : #accessing }
AKGPrintStream >> tempDir: anObject [
	tempDir := anObject
]

{ #category : #accessing }
AKGPrintStream >> textTemporary [
	^ self basename withExtension: 'txt'
]

{ #category : #private }
AKGPrintStream >> writeToText: aStream [
	"Write the supplied stream to textTemporary"

	| buffer |

	self textTemporary ensureDelete.
	self textTemporary writeStreamDo: [ :stream | | znstream |
		znstream := ZnNewLineWriterStream on: stream.
		[ aStream atEnd ] whileFalse: [ 
			buffer := aStream next: 1024.
			buffer isEmpty ifFalse:
				[ znstream nextPutAll: buffer ] ] ]
]
