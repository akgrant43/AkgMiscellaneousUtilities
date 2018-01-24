private - changed
applyCurrentSelection
	"All the widgets have probably been reset.
	Set the selected item in each one."

	filesList setSelectedItem: (currentSelection at: 2).
	presetsList setSelectedItem: (currentSelection at: 3).
	programsSettingsList setSelectedItem: (currentSelection at: 4).
