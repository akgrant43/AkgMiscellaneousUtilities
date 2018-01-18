tests
testFromStream

	| preset program range |

	preset := SanoPlasmaPreset fromStream: self template1 readStream.
	self assert: preset name equals: 'Preset Name'.
	self assert: preset programs size equals: 1.
	program := preset programs first.
	self assert: program frequencies size equals: 1.
	range := program frequencies first.
	self assert: range fromFrequency equals: 123000.
	self assert: range toFrequency equals: 456000.