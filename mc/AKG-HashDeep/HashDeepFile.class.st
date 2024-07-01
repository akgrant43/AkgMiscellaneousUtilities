Class {
	#name : #HashDeepFile,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'fileSize',
		'hash1',
		'hash2',
		'source'
	],
	#category : 'AKG-HashDeep'
}

{ #category : #'instance creation' }
HashDeepFile class >> fromString: aString [
	"Answer a new instance of the receiver from the supplied string.
	The string is assumed to be a line from a hashdeep file, i.e. CSV with:
	1. File Size
	2. Hash1
	3. Hash2
	4. File Name"

	| size fileName hash1 hash2 index lastIndex |

	index := aString indexOf: $,.
	self assert: index > 1.
	size := (aString copyFrom: 1 to: index-1) asNumber.
	lastIndex := index.
	index := aString indexOf: $, startingAt: lastIndex+1.
	hash1 := aString copyFrom: lastIndex+1 to: index-1.
	lastIndex := index.
	index := aString indexOf: $, startingAt: lastIndex+1.
	hash2 := aString copyFrom: lastIndex+1 to: index-1.
	fileName := aString copyFrom: index+1 to: aString size.
	^self new 
		fileName: fileName;
		fileSize: size;
		hash1: hash1;
		hash2: hash2;
		yourself.
]

{ #category : #comparing }
HashDeepFile >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ fileSize = anObject fileSize
		and: [ hash1 = anObject hash1 and: [ hash2 = anObject hash2 ] ]
]

{ #category : #accessing }
HashDeepFile >> fileName [
	^ fileName
]

{ #category : #accessing }
HashDeepFile >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
HashDeepFile >> fileSize [
	^ fileSize
]

{ #category : #accessing }
HashDeepFile >> fileSize: anObject [
	fileSize := anObject
]

{ #category : #comparing }
HashDeepFile >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ fileSize hash bitXor: (hash1 hash bitXor: hash2 hash)
]

{ #category : #accessing }
HashDeepFile >> hash1 [
	^ hash1
]

{ #category : #accessing }
HashDeepFile >> hash1: anObject [
	hash1 := anObject
]

{ #category : #accessing }
HashDeepFile >> hash2 [
	^ hash2
]

{ #category : #accessing }
HashDeepFile >> hash2: anObject [
	hash2 := anObject
]

{ #category : #printing }
HashDeepFile >> printOn: aStream [

	fileName ifNil: [ ^super printOn: aStream ].
	aStream
		<< self class name;
		<< '(';
		<< fileName;
		<< ')'
]

{ #category : #accessing }
HashDeepFile >> source [
	^ source
]

{ #category : #accessing }
HashDeepFile >> source: anObject [
	source := anObject
]
