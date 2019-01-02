inspecting
gtInspectArmV632BitVMsIn: composite
	<gtInspectorPresentationOrder: 10>

	^composite fastTable 
		title: 'ARM v6 32bit VMs';
		display: [ self recentVMsAt: self armv632URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm32URL ] 
			entitled: 'Download'.
