private - events
spSelected: settingsOrProgram
	"Update the UI with the editor for the supplied Settings or Program"

	| widget |

	settingsOrProgram ifNil: [ ^self ].
	currentSelection at: 2 put: settingsOrProgram.
	widget := GlamourPresentationModel new.
	widget presentationClass: GTInspector startOn: settingsOrProgram.
	programSettingsEditor := widget.
	inRebuild := true.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.
	self applyCurrentSelection.
	inRebuild := false.