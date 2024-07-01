Class {
	#name : #Spooky2RampProgramme,
	#superclass : #Object,
	#instVars : [
		'startFrequency',
		'endFrequency',
		'up',
		'duration'
	],
	#category : 'AKG-Spooky2-Rife-Programmes'
}

{ #category : #accessing }
Spooky2RampProgramme >> duration [
	^ duration
]

{ #category : #accessing }
Spooky2RampProgramme >> duration: aDuration [
	"Set the duration in seconds"

	duration := aDuration asSeconds asFloat.
	self assert: duration >= 10.

]

{ #category : #accessing }
Spooky2RampProgramme >> endFrequency [
	^ endFrequency
]

{ #category : #accessing }
Spooky2RampProgramme >> endFrequency: aNumber [

	self assert: (aNumber between: 1 and: 1000000).
	startFrequency ifNotNil: [ self assert: startFrequency < aNumber ].
	endFrequency := aNumber
]

{ #category : #initialization }
Spooky2RampProgramme >> initialize [ 

	super initialize.
	up := true.

]

{ #category : #accessing }
Spooky2RampProgramme >> maxFrequency [
	"The maximum frequency is always the end frequency"

	^ endFrequency
]

{ #category : #accessing }
Spooky2RampProgramme >> minFrequency [
	"The minimum frequency is always the start frequency"

	^ startFrequency
]

{ #category : #accessing }
Spooky2RampProgramme >> startFrequency [
	^ startFrequency
]

{ #category : #accessing }
Spooky2RampProgramme >> startFrequency: aNumber [

	self assert: (aNumber between: 1 and: 1000000).
	endFrequency ifNotNil: [ self assert: startFrequency < endFrequency ].
	startFrequency := aNumber
]

{ #category : #accessing }
Spooky2RampProgramme >> up [
	^ up
]

{ #category : #accessing }
Spooky2RampProgramme >> up: anObject [
	up := anObject
]

{ #category : #accessing }
Spooky2RampProgramme >> value: time [ 
	"Answer the frequency at the given time (in seconds)"

	self error: 'old'
]

{ #category : #accessing }
Spooky2RampProgramme >> valueAt: time [ 
	"Answer the frequency at the given time (in seconds)"
	| offset |

	offset := ((endFrequency - startFrequency) * (time / duration \\ 1)) rounded.
	^ up 
		ifTrue: [ startFrequency + offset ]
		ifFalse: [ endFrequency - offset ].
]
