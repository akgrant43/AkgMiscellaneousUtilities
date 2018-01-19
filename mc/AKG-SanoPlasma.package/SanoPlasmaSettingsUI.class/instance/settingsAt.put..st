private
settingsAt: key put: value

	self settings at: key put: value.
	settingsChangedBlock ifNotNil: [ settingsChangedBlock value: self ].
	^value