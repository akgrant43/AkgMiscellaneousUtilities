private
createMenu

	| newMenu |

	newMenu := MenuPresenter new.

	newMenu addGroup: [ :group |
		self addGlobalMenuItemsTo: group.
		OSPlatform current isWindows ifFalse: 
			[ self addUnixMenuItemsTo: group ] ].
	newMenu applyTo: self.
	^newMenu