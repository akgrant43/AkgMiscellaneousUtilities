accessing
maxY 

	^ maxY ifNil: [ maxY := programme endFrequency + offset ]