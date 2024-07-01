Class {
	#name : #Spooky2RampWaveform,
	#superclass : #Spooky2Waveform,
	#instVars : [
		'up'
	],
	#category : 'AKG-Spooky2-Waveforms'
}

{ #category : #private }
Spooky2RampWaveform >> array [ 
	| array |

	array := Array new: 1024.
	1 to: 1024 do: [ :i |
		array at: i put: i-1 ].
	up ifFalse: [ array := array reverse ].
	^ array
]

{ #category : #initialization }
Spooky2RampWaveform >> initialize [ 

	super initialize.
	up := true.
]

{ #category : #accessing }
Spooky2RampWaveform >> up [
	^ up
]

{ #category : #accessing }
Spooky2RampWaveform >> up: anObject [
	up := anObject
]
