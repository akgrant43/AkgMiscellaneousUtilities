specs
defaultSpec 
	<spec: #default>
	| oneLine |
	
	oneLine := 30.
	^ SpecLayout composed
		newRow: [ :row1 | row1
		newColumn: [ :col |
			col
				newRow: [ :row | row add: #nameLabel ] height: oneLine;
				newRow: [ :row | row add: #descriptionLabel ];
				newRow: [ :row | ];
				newRow: [ :row | ];
				newRow: [ :row | row add: #runTimeLabel ] height: oneLine;
				newRow: [ :row | row add: #c1FreqLabel ] height: oneLine;
				newRow: [ :row | row add: #c2FreqLabel ] height: oneLine;
				newRow: [ :row | row add: #timeLabel ] height: oneLine;
				newRow: [ :row | row 
					add: #saveButton;
					add: #loadButton ] ] width: 100;
		newColumn: [ :col |
			col
				newRow: [ :row | row add: #name ] height: oneLine;
				newRow: [ :row | row add: #description ];
				newRow: [ :row | row add: #c1Function ];
				newRow: [ :row | row add: #c2Function ];
				newRow: [ :row | row add: #runTime ] height: oneLine;
				newRow: [ :row | row add: #c1Freq ] height: oneLine;
				newRow: [ :row | row add: #c2Freq ] height: oneLine;
				newRow: [ :row | row add: #time ] height: oneLine;
				newRow: [ :row | row 
					add: #start;
					add: #pause;
					add: #stop ] ] ].
