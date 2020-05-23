accessing
pWaveform: aNumber values: anArray

	self assert: (aNumber between: 1 and: 15).
	self assert: anArray size = 1024.
	self assert: (anArray allSatisfy: [ :each | each between: 0 and: 1023 ]).

	pWaveforms at: aNumber put: anArray.