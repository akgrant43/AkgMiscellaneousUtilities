private
createMenu

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Print Report';
				icon: (Smalltalk ui icons iconNamed: #smallPrint);
				action: [ self printCurrentReport ] ].
		group addItem: [ :item |
			item
				name: 'Save Report';
				icon: (Smalltalk ui icons iconNamed: #smallSave);
				action: [ self saveCurrentReport ] ].
		group addItem: [ :item |
			item
				name: 'Refresh';
				icon: (Smalltalk ui icons iconNamed: #glamorousRefresh);
				action: [ self refreshDirectory ] ].
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ].
		group addItem: [ :item |
			item
				name: 'Report';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self currentReport inspect ] ] ].
	newMenu applyTo: self.
	^newMenu