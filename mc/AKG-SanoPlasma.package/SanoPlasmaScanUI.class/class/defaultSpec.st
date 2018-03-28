specs
defaultSpec
	<spec: #default>

	^SpecColumnLayout composed
		newRow: [ :row | row add: #menu ] height: 30;
		newRow: [ :row | row 
			add: #directoryList width: 300;
			add: #reportInspector ].