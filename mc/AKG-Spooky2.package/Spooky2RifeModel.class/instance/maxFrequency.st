accessing
maxFrequency

	^ (channelModels collect: [ :each | each maxFrequency ]) max