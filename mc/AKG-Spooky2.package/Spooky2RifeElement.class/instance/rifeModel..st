accessing
rifeModel: aRifeModel

	rifeModel := aRifeModel.
	rifeModel announcer when: Spooky2Step send: #safelyUpdateModel to: self.
