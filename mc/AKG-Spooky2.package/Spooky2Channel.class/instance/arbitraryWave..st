accessing - wave forms
arbitraryWave: number
	"Set the channel to arbitrary wave number"

	self assert: (number between: 1 and: 15).
	waveform := 100 + number.