visiting
visitReference: anEntry
	| oldBasename newBasename |

	oldBasename := anEntry basename.
	newBasename := asciiFilename clean: oldBasename.
	newBasename = oldBasename ifTrue: [ ^self ].

	AsciiFilenameSignal new 
		oldName: anEntry reference;
		newBasename: newBasename;
		emit.
	self halt.
	anEntry reference renameTo: newBasename.