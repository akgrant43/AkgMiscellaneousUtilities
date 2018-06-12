initialization
initialize

	super initialize.
	tempDir := '/dev/shm/' asFileReference.
	textTemporary := self basename withExtension: 'txt'.
	pdfTemporary := self basename withExtension: 'pdf'.
	printOptions := { 'fit-to-page' }.
	printerHost := '192.168.0.41:6631'.
	printerName := 'lbp6020'.
