instance creation
fromFileNames: aFileNameCollection

	| set |
	
	set := self new.
	aFileNameCollection do: [ :each |
		set add: (HashDeepFiles fromFileName: each) ].
	^set