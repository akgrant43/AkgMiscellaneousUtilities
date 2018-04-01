accessing
crossoverCount: anInteger
	"Set the number of crossovers for each chain.
	If not already set, make the crossover range the chain range / crossoverCount"
	crossoverCount := anInteger.
	crossoverRange ifNil: [ 
		freqRange ifNil: 
			[ self error: 'Frequency range must be set before crossoverCount' ].
		self crossoverRange: (freqRange / crossoverCount) rounded ]