specs
defaultSpec
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row add: #menuBar ] height: 30;
		newRow: [ :row | row 
			add: #dtLabel;
			add: #flLabel] height: tfh;
		newRow: [ :row | row
			add: #directoryTree;
			add: #filesList;
			add: #chainUI ].