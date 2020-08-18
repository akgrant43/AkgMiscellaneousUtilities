accessing
rifeModel: aRifeModel

	rifeModel ifNotNil: 
		[ rifeModel announcer unsubscribe: self ].
	rifeModel := aRifeModel
	rifeModel announcer 
			when: Spooky2Step 
			do: [ self halt. timeProportionHolder value: (rifeModel time asSeconds / rifeModel runTime asSeconds) ]
			for: self