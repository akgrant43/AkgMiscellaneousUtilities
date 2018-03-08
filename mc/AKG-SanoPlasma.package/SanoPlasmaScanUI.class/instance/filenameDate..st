private
filenameDate: aFileReference

	^aFileReference isDirectory ifTrue:
		[ aFileReference modificationTime asDate printString ]
	ifFalse:
		[ (SanoPlasmaScanResults fileNameDate: aFileReference) printString ]