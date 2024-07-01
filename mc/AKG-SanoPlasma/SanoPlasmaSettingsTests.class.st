Class {
	#name : #SanoPlasmaSettingsTests,
	#superclass : #TestCase,
	#category : 'AKG-SanoPlasma-Tests'
}

{ #category : #tests }
SanoPlasmaSettingsTests >> testDefaults [

	| settings |
	
	settings := SanoPlasmaSettings new.
	self assert: (settings at: 'Out 1 Freq. Limit Max.') equals: 900000.
	self assert: (settings at: 'Out 1 Freq. Limit Min.') equals: 1.
	"self assert: (settings at: #out2Voltage) equals: 12."
]
