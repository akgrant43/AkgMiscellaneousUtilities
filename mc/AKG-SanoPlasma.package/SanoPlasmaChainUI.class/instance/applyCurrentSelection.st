private - events
applyCurrentSelection
	"All the widgets have probably been reset.
	Set the selected item in each one."

	presetList setSelectedItem: (currentSelection at: 1).
	programsSettingsList setSelectedItem: (currentSelection at: 2).
