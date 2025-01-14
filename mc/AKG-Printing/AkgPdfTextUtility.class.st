Class {
	#name : #AkgPdfTextUtility,
	#superclass : #Object,
	#category : #'AKG-Printing'
}

{ #category : #api }
AkgPdfTextUtility >> pdfToText: aFileReference [
	"Convert the supplied pdf file to text.
	By default it attempts to keep the layout."
	| command arguments inFile outFile builder status |

	inFile := aFileReference asFileReference.
	self assert: inFile extension = 'pdf'.
	outFile := inFile withExtension: 'txt'.
	command := 'pdftotext'.
	arguments := Array streamContents: [ :stream |
		stream
			nextPut: '-layout';
			nextPut: inFile fullName;
			nextPut: outFile fullName ].
	builder := GtExternalProcessBuilder new
		command: command;
		arguments: arguments;
		pipeStdout;
		pipeStderr.
	command := builder createNativeCommand.
	status := command status.
	status isSuccess ifFalse: [ self error: 'phooey' ].
	^ outFile.
]
