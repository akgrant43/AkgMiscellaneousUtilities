inspecting
gtInspect32BitVMsIn: composite
	<gtInspectorPresentationOrder: 2>

	^composite fastTable 
		title: '32bit VMs';
		display: [ self recentVMsAt: self vm32URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm32URL ] 
			entitled: 'Download'.
