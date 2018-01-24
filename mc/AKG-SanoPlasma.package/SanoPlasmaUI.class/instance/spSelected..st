private - changed
spSelected: settingsOrProgram
	"Update the UI with the editor for the supplied Settings or Program"

	| widget |

	Transcript show: 'spSelected: ', settingsOrProgram displayString; cr.
	settingsOrProgram ifNil: [ ^self ].
	currentSelection at: 4 put: settingsOrProgram.
	widget := GlamourPresentationModel new.
	widget presentationClass: GTInspector startOn: settingsOrProgram.
	programSettingsEditor := widget.
	inRebuild := true.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.
	self applyCurrentSelection.
	inRebuild := false.