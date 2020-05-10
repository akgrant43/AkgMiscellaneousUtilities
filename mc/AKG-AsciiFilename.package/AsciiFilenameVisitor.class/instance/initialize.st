initialization
initialize

	super initialize.
	asciiFilename := AsciiFilename new 
		includeDiacritics: false;
		dryRun: true;
		windowsCompatible: true;
		replacementString: '.';
		yourself.
