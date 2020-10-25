accessing
minFrequency

	^ (channelModels collect: [ :each | each minFrequency ]) min