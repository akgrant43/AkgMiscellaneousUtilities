Class {
	#name : #Spooky2ParameterChanged,
	#superclass : #Announcement,
	#instVars : [
		'oldValue',
		'newValue',
		'parameterName',
		'channel'
	],
	#category : 'AKG-Spooky2-Rife-Announcements'
}

{ #category : #accessing }
Spooky2ParameterChanged >> channel [
	^ channel
]

{ #category : #accessing }
Spooky2ParameterChanged >> channel: anObject [
	channel := anObject
]

{ #category : #accessing }
Spooky2ParameterChanged >> newValue [
	^ newValue
]

{ #category : #accessing }
Spooky2ParameterChanged >> newValue: anObject [
	newValue := anObject
]

{ #category : #accessing }
Spooky2ParameterChanged >> oldValue [
	^ oldValue
]

{ #category : #accessing }
Spooky2ParameterChanged >> oldValue: anObject [
	oldValue := anObject
]

{ #category : #accessing }
Spooky2ParameterChanged >> parameterName [
	^ parameterName
]

{ #category : #accessing }
Spooky2ParameterChanged >> parameterName: anObject [
	parameterName := anObject
]
