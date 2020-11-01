as yet unclassified
updateRange

	range := maxFrequencyInput editor text asString asNumber. 
	sliderElement 
		startValue: 0 - range;
		endValue: range;
		regeneratePlot.
	sliderElement valueHolder value: 0.5.
