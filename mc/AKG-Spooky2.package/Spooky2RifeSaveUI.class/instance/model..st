accessing
model: aSpooky2RifeModel

	model := aSpooky2RifeModel.
	model announcer when: Spooky2Loaded send: #updateState to: self.
