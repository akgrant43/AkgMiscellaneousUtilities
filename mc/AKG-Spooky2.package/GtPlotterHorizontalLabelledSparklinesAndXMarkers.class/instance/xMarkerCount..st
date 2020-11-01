configuration
xMarkerCount: aNumber
	"Set the number of X markers to use"

	self assert: xValueHolders isNil.
	xValueHolders := Array new: aNumber.