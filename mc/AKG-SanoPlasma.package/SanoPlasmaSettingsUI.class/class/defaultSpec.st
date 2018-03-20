specs
defaultSpec
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row
			add: #o2vmLabel;
			add: #inputOut2VoltageMultiplier ] height: tfh;
		newRow: [ :row | row
			add: #repeatProgramLabel;
			add: #repeatProgramWidget ] height: tfh;
		newRow: [ :row | row
			add: #repeatChainLabel;
			add: #repeatChainWidget ] height: tfh;
		newRow: [ :row | row 
			add: #harmonicWobbleLabel;
			add: #harmonicWobbleWidget ] height: tfh.
