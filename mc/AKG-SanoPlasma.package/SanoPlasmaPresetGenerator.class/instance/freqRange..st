accessing
freqRange: anInteger

	freqRange := anInteger.
	crossoverCount ifNil: 
		[ self crossoverCount: 1 ]