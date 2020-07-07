initialization
initialize

	super initialize.
	tempDir := '/dev/shm/' asFileReference.
	printOptions := { 'fit-to-page' }.
	printerHost := '192.168.0.41:6631'.
	printerName := 'lbp6020'.
	enscriptOptions := { }.
	pandocOptions := #().