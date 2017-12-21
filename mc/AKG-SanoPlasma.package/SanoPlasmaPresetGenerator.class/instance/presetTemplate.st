accessing
presetTemplate
	^ presetTemplate ifNil: [ presetTemplate := self class defaultTemplate ]