private
createMenu

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ].
		group addItem: [ :item |
			item
				name: 'Chain';
				icon: (Smalltalk ui icons iconNamed: #add);
				action: [ self newChain ] ] ].
	newMenu applyTo: self.
	^newMenu