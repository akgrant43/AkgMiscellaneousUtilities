private
addGlobalMenuItemsTo: group

	group addItem: [ :item |
			item
				name: 'Exit';
				icon: (Smalltalk ui icons iconNamed: #smallQuit);
				action: [ Smalltalk image exit: 0 ] ].
	group addItem: [ :item |
			item
				name: 'Refresh';
				icon: (Smalltalk ui icons iconNamed: #glamorousRefresh);
				action: [ self refreshDirectory ] ].
