actions
preorder

	| guide |

	guide := PreorderGuide for: self.
	guide selectChildren: [ :parentEntry | 
		parentEntry isSymlink not and:
			"Don't index git internal directories"
			[ parentEntry basename ~= '.git' and:
			"Don't index Jekyll site directory"
			[ parentEntry basename ~= '_site' ] ] ].
	^self visit: rootDirectory with: guide.