inspecting
gtInspectMac32BitVMsIn: composite
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'Mac 32bit VMs';
		display: [ self recentVMsAt: self mac32URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm64URL ] 
			entitled: 'Download'.
