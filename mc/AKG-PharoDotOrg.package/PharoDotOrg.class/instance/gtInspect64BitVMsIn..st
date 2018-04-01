inspecting
gtInspect64BitVMsIn: composite
	<gtInspectorPresentationOrder: 1>

	^composite fastTable 
		title: '64bit VMs';
		display: [ self recentVMsAt: self vm64URL ];
		column: 'Name' evaluated: [ :each | each first ] width: 400;
		column: 'Date' evaluated: [ :each | each second ];
		column: 'Size' evaluated: [ :each | each third ];
		selectionAct: [ :table | self download: table selection first from: self vm64URL ] 
			entitled: 'Download'.
