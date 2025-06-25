"
Convert the supplied PDF to a sequence of images and convert back to a PDF.

Useful when your printer doesn't handle PDFs very well (looking at HP).
"
Class {
	#name : #AkgPrintablePdf,
	#superclass : #Object,
	#instVars : [
		'inputPdf',
		'outputPdf',
		'tmpDir'
	],
	#category : #'AKG-Printing'
}

{ #category : #actions }
AkgPrintablePdf class >> input: inputPdf [

	^ self new
		inputPdf: inputPdf;
		convert.
]

{ #category : #actions }
AkgPrintablePdf class >> input: inputPdf outputPdf: outputPdf [

	^ self new
		inputPdf: inputPdf;
		outputPdf: outputPdf;
		convert.
]

{ #category : #actions }
AkgPrintablePdf >> cleanTmpDir [

	tmpDir deleteAllChildren
]

{ #category : #actions }
AkgPrintablePdf >> convert [

	tmpDir := self createTmpDir.
	self cleanTmpDir.
	self convertToImages.
	self convertImagesToPdf.
	^ outputPdf
]

{ #category : #private }
AkgPrintablePdf >> convertImagesToPdf [
	| proc output status cmd |

	cmd := String streamContents: [ :stream | 
		stream
			<< 'img2pdf *.png -o';
			print: self outputPdf fullName;
			<< ' --pagesize A4' ].
	proc := GtExternalProcessBuilder new
			command: 'bash';
			arguments: 
					{'-c'.
					cmd};
			workingDirectory: tmpDir fullName;
			pipeStderr;
			pipeStdout.

	output := proc asyncOutput wait.
	status := output status.
	status isSuccess
		ifFalse: [ | message |
			message := output stderr trimBoth
					ifEmpty: [ 'Exception while running command' ].
			self error: message ]
]

{ #category : #private }
AkgPrintablePdf >> convertToImages [
	"Convert the input PDF to a sequence of images.
	Requires gs (ghostscript) to be in the path."
	| proc output status |
	proc := GtExternalProcessBuilder new
			command: 'magick';
			arguments: {'-density'.
					'300'.
					self inputPdf fullName.
					'out.png'};
			workingDirectory: tmpDir fullName;
			pipeStderr;
			pipeStdout.

	output := proc asyncOutput wait.
	status := output status.
	status isSuccess ifFalse:
		[ | message |
		message := output stderr trimBoth ifEmpty:
			[ 'Exception while running command' ].
		self error: message ].
]

{ #category : #actions }
AkgPrintablePdf >> createTmpDir [

	^ (FileLocator temp / 'akg-printable-pdf') resolve ensureCreateDirectory
]

{ #category : #private }
AkgPrintablePdf >> generateOutputPdf [
	| newBasename |

	newBasename := inputPdf basenameWithoutExtension, ' printable.pdf'.
	^ inputPdf parent / newBasename
]

{ #category : #accessing }
AkgPrintablePdf >> inputPdf [
	^ inputPdf
]

{ #category : #accessing }
AkgPrintablePdf >> inputPdf: aFileReference [

	inputPdf := aFileReference asFileReference.
	self assert: inputPdf extension asLowercase = 'pdf'.
]

{ #category : #accessing }
AkgPrintablePdf >> outputPdf [
	^ outputPdf ifNil: [ outputPdf := self generateOutputPdf ]
]

{ #category : #accessing }
AkgPrintablePdf >> outputPdf: aFileReference [

	outputPdf := aFileReference asFileReference.
	self assert: outputPdf extension asLowercase = 'pdf'.
]
