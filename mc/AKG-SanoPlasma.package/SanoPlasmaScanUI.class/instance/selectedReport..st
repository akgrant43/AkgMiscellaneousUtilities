private
selectedReport: aFileReference
	"Display the selected scan results"

	| inspector |

	currentReport := SanoPlasmaScanResults on: aFileReference.
	inspector := GlamourPresentationModel new.
	inspector presentationClass: GTInspector startOn: currentReport.
	reportInspector := inspector.
	inRebuild := true.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.
	"self applyCurrentSelection."
	inRebuild := false.