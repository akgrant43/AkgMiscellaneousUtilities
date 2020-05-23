initialization
initialize

	super initialize.
	model := Spooky2RifeModel new.
	model announcer when: Spooky2Step send: #updateState to: self.