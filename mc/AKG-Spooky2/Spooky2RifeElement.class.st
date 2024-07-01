Class {
	#name : #Spooky2RifeElement,
	#superclass : #BlElement,
	#instVars : [
		'rifeModel'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #'private - accessing' }
Spooky2RifeElement >> inputBackgroundColor [

	^ Color fromHexString: #f0f0f0
]

{ #category : #accessing }
Spooky2RifeElement >> rifeModel [
	^ rifeModel
]

{ #category : #accessing }
Spooky2RifeElement >> rifeModel: aRifeModel [

	rifeModel := aRifeModel.
	rifeModel announcer when: Spooky2Step send: #safelyUpdateModel to: self.
	rifeModel announcer when: Spooky2ParameterChanged send: #safelyUpdateParameters to: self.

]

{ #category : #events }
Spooky2RifeElement >> safelyUpdateModel [
	"Update the receiver's model in the UI thread"

	self enqueueTask: (BlTaskAction new action: [ self updateModel ])
]

{ #category : #events }
Spooky2RifeElement >> safelyUpdateParameters [
	"Update the receiver's model in the UI thread"

	self enqueueTask: (BlTaskAction new action: [ self updateParameters ])
]

{ #category : #events }
Spooky2RifeElement >> updateModel [
	"The receiver's model has changed state, e.g. the time has changed, update the receiver to reflect it.
	Subclasses should override this method as required."
]

{ #category : #events }
Spooky2RifeElement >> updateParameters [
	"The receiver's parameters have changed state, update the receiver to reflect it.
	Subclasses should override this method as required."
]
