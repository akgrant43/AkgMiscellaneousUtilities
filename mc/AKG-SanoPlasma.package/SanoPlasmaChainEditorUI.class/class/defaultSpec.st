specs
defaultSpec
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row 
			add: #nameLabel;
			add: #nameInput ] height: tfh;
		newRow: [ :row | row add: #presetList ] height: tfh * 4;
		newRow: [ :row | row add: #summaryText ];
		newRow: [ :row | row 
			add: #upButton;
			add: #downButton;
			add: #saveChainButton;
			add: #inspectButton ] height: tfh.