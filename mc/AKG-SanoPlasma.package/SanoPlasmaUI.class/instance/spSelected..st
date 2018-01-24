private - changed
spSelected: settingsOrProgram
	"Update the UI with the editor for the supplied Settings or Program"

	| widget |

	Transcript show: 'spSelected: ', settingsOrProgram displayString; cr.
	settingsOrProgram ifNil: [ ^self ].
	widget := GlamourPresentationModel new.
	widget presentationClass: GTInspector startOn: settingsOrProgram.
	programSettingsEditor := widget.
	self needRebuild: false.
	self buildWithSpecLayout: self class defaultSpec.