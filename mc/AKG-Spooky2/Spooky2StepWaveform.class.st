"
Create a 1024 value array that represents a step waveform that can be downloaded to the MHS-2300 / Spooky2 signal generator.

The number of steps is configurable between 2 and 10.

Public API and Key Messages

- steps[:] - the number of steps in the waveform.
- array - the waveform data to be downloaded.

 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Spooky2StepWaveform,
	#superclass : #Spooky2Waveform,
	#instVars : [
		'steps'
	],
	#category : 'AKG-Spooky2-Waveforms'
}

{ #category : #private }
Spooky2StepWaveform >> array [ 
	| yIncrement yValues xIncrement array i |

	yIncrement := 1024 / (steps-1).
	yValues := Array streamContents: [ :stream |
		stream nextPut: 0.
		1 to: (steps - 2) do: [ :step |
			stream nextPut: (yIncrement * step) rounded ].
		stream nextPut: 1023 ].
	xIncrement := (1024 / steps) rounded.
	i := 0.
	array := Array streamContents: [ :stream |
		1 to: steps do: [ :step |
			xIncrement timesRepeat: 
				[ stream nextPut: (yValues at: step).
				i := i + 1 ] ].
		i to: 1023 do: [ :x |
			array nextPut: 1023 ] ].
	^ array
]

{ #category : #accessing }
Spooky2StepWaveform >> steps [
	^ steps
]

{ #category : #accessing }
Spooky2StepWaveform >> steps: anInteger [

	self assert: (anInteger between: 2 and: 10).
	steps := anInteger
]
