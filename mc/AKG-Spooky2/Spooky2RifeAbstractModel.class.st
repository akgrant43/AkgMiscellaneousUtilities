Class {
	#name : #Spooky2RifeAbstractModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer',
		'state'
	],
	#category : 'AKG-Spooky2-Rife-Model'
}

{ #category : #accessing }
Spooky2RifeAbstractModel >> announcer [ 

	^ announcer
]

{ #category : #private }
Spooky2RifeAbstractModel >> compileFunction: aString [

	^ self class compiler evaluate: aString
]

{ #category : #operating }
Spooky2RifeAbstractModel >> hold [
	"Toggle the hold state of the programme"

	state = #stopped ifTrue: [ ^self ].
	state := #held.
]

{ #category : #initialization }
Spooky2RifeAbstractModel >> initialize [ 

	super initialize.
	announcer := Announcer new.

]

{ #category : #accessing }
Spooky2RifeAbstractModel >> isHeld [
	"Answer a boolean indicating if the receiver is held"

	^ state = #held
]

{ #category : #accessing }
Spooky2RifeAbstractModel >> isPaused [
	"Answer a boolean indicating if the receiver is paused"

	^ state = #paused
]

{ #category : #testing }
Spooky2RifeAbstractModel >> isRunning [

	^ state = #running
]

{ #category : #testing }
Spooky2RifeAbstractModel >> isStopped [ 

	^ state = #stopped
]

{ #category : #operating }
Spooky2RifeAbstractModel >> pause [ 

	state = #running ifFalse: [ ^ self ].
	state := #paused.
]

{ #category : #accessing }
Spooky2RifeAbstractModel >> start [ 

	state := #running.
]

{ #category : #operating }
Spooky2RifeAbstractModel >> stop [ 

	state := #stopped.
	announcer announce: Spooky2Step new.
]

{ #category : #operating }
Spooky2RifeAbstractModel >> unhold [

	state = #held ifFalse: [ ^ self ].
	state := #running.
]

{ #category : #operating }
Spooky2RifeAbstractModel >> unpause [ 

	state = #paused ifFalse: [ ^ self ].
	state := #running.
]
