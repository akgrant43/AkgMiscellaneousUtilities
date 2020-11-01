accessing
at: anInteger putValueHolder: aValueHolder
	"Assign the value holder for each marker"

	xValueHolders at: anInteger put: aValueHolder.
	^ aValueHolder