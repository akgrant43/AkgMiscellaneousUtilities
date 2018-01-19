specs
defaultSpec
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row
			add: #o2vmLabel;
			add: #inputOut2VoltageMultiplier ] height: tfh.
