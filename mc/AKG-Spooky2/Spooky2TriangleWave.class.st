Class {
	#name : #Spooky2TriangleWave,
	#superclass : #Object,
	#instVars : [
		'period'
	],
	#category : 'AKG-Spooky2-Rife-Model'
}

{ #category : #accessing }
Spooky2TriangleWave >> at: aTime [ 
	"Answer the value (-1 to 1) for the given time"
	| baseTime |

	baseTime := aTime \\ period.

	baseTime <= (period * 0.25) ifTrue:
		[ ^ baseTime * 4 / period ].
	baseTime < (period * 0.75) ifTrue: 
		[ ^ (period / 2 - baseTime) * 4 / period ].
	^ (baseTime - (period * 0.75)) * 4 / period - 1.
]

{ #category : #accessing }
Spooky2TriangleWave >> period [
	^ period
]

{ #category : #accessing }
Spooky2TriangleWave >> period: anObject [
	period := anObject
]
