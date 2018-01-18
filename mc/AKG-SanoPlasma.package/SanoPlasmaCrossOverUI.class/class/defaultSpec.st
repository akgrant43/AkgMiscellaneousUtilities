specs
defaultSpec
	<spec: #default>
	| tfh |

	tfh := StandardFonts defaultFont height + 10.
	^SpecColumnLayout composed
		newRow: [ :row | row add: #menu ] height: self toolbarHeight;
		newRow: [ :row | row
			add: #labelCrossoverFreq;
			add: #inputCrossoverFreq ] height: tfh;
		newRow: [ :row | row 
			add: #labelRange;
			add: #inputRange ] height: tfh;
		newRow: [ :row | row 
			add: #labelTime;
			add: #inputTime ] height: tfh;
		newRow: [ :row | row
			add: #labelName;
			add: #inputName ] height: tfh;
		newRow: [ :row | row 
			add: #labelLocation;
			add: #inputLocation ] height: tfh;
		newRow: [ :row | row add: #summaryText ] height: tfh * 10;
		newRow: [ :row | row add: #createButton ] height: tfh.