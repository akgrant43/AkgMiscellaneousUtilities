private
createMenu

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		group addItem: [ :item |
			item
				name: 'Inspect';
				icon: (Smalltalk ui icons iconNamed: #smallObjects);
				action: [ self inspect ] ] ].
	newMenu applyTo: self.
	^newMenu