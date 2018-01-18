specs
defaultSpec
	<spec: #default>

	^SpecColumnLayout composed
		newRow: [ :row | row add: #menuBar ] height: 30;
		newRow: [ :row | row
			add: #directoryTree;
			add: #filesList;
			add: #presetsList;
			add: #programsSettingsList ].