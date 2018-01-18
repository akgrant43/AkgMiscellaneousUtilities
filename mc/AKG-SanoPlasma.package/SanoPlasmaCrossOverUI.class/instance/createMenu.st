private
createMenu

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Settings';
				icon: (Smalltalk ui icons iconNamed: #smallCogState2);
				action: [ self settings inspect ] ].
		group addItem: [ :item |
			item
				name: 'Program';
				icon: (Smalltalk ui icons iconNamed: #book);
				action: [ self program inspect ] ].
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ] ].
	newMenu applyTo: self.
	^newMenu