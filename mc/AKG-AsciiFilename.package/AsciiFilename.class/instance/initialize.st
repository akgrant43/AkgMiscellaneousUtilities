initialize
initialize

	super initialize.
	replacementString := ''.
	windowsCompatible := true.
	dryRun := false.
	includeDiacritics := false.
	asciiOnly := true.
	decodeName := false.
	encoders := { 
		ZnCharacterEncoder utf8.
		ZnCharacterEncoder latin1.
		ZnCharacterEncoder iso88591. }.
