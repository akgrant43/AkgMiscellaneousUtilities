fixing
fixFile: inFile to: outFile
	"Read each line of the supplied file and fix the basename"
	| asciiFilename lf line basename newName segments fullName |

	lf := Character lf asciiValue.
	asciiFilename := self new 
		includeDiacritics: false;
		dryRun: true;
		windowsCompatible: true;
		replacementString: '.';
		yourself.
	inFile asFileReference binaryReadStreamDo: [ :readStream |
		outFile asFileReference writeStreamDo: [ :writeStream |
			[ readStream atEnd ] whileFalse:
				[ line := readStream upTo: lf.
				segments := $/ split: line asString.
				segments ifNotEmpty: 
					[ basename := segments last.
					newName := asciiFilename clean: basename.
					segments at: segments size put: newName.
					fullName := $/ join: segments.
					writeStream 
						<< fullName;
						lf ] ].
				writeStream truncate. ] ].