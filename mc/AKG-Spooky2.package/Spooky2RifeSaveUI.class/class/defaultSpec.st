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
				newRow: [ :row | row 
					add: #saveButton;
					add: #loadButton ] height: oneLine * 2 ] width: 100;
		newColumn: [ :col |
			col
				newRow: [ :row | row add: #name ] height: oneLine;
				newRow: [ :row | row add: #description ];
				newRow: [ :row | ] height: oneLine * 2 ] ].
