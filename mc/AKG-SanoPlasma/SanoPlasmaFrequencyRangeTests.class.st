Class {
	#name : #SanoPlasmaFrequencyRangeTests,
	#superclass : #TestCase,
	#category : 'AKG-SanoPlasma-Tests'
}

{ #category : #tests }
SanoPlasmaFrequencyRangeTests >> testAsString1 [

	| range testString |

	testString := '123000-456000=1234'.
	range := SanoPlasmaFrequencyRange fromString: testString.

	self assert: range asString equals: testString.
]

{ #category : #tests }
SanoPlasmaFrequencyRangeTests >> testFromString1 [

	| range |

	range := SanoPlasmaFrequencyRange fromString: '123000-456000=1234'.

	self assert: range fromFrequency equals: 123000.
	self assert: range toFrequency equals: 456000.
	self assert: range dwell equals: 1234.
	self assert: range gating equals: 0.
	self assert: range waveform equals: 1.
]
