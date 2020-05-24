updating
updateState 
	"The generator has changed state, update the display"

	c1Freq label: model generator channel1 frequency asString, ' Hz'.
	c2Freq label: model generator channel2 frequency asString, ' Hz'.
	time label: (model time roundTo: 1 second) asString