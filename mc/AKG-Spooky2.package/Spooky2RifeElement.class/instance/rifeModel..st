accessing
rifeModel: aRifeModel

	rifeModel := aRifeModel.
	rifeModel announcer when: Spooky2Step send: #safelyUpdateModel to: self.
	rifeModel announcer when: Spooky2ParameterChanged send: #safelyUpdateParameters to: self.
