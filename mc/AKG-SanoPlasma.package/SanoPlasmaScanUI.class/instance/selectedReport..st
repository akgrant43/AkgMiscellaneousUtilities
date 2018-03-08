private
selectedReport: aFileReference
	"Display the selected scan results"

	currentReport := SanoPlasmaScanResults on: aFileReference.
	self reportText text: currentReport reportText.