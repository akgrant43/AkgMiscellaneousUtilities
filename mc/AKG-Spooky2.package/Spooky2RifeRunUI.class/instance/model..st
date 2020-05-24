initialization
model: aSpooky2RifeModel

	model := aSpooky2RifeModel.
	model announcer when: Spooky2Step send: #updateState to: self.
	model announcer when: Spooky2Loaded send: #updateModel to: self.
