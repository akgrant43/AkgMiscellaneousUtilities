Class {
	#name : #AsciiFilenameSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'oldName',
		'newBasename'
	],
	#category : 'AKG-AsciiFilename'
}

{ #category : #accessing }
AsciiFilenameSignal >> newBasename [
	^ newBasename
]

{ #category : #accessing }
AsciiFilenameSignal >> newBasename: anObject [
	newBasename := anObject
]

{ #category : #accessing }
AsciiFilenameSignal >> oldName [
	^ oldName
]

{ #category : #accessing }
AsciiFilenameSignal >> oldName: anObject [
	oldName := anObject
]

{ #category : #printing }
AsciiFilenameSignal >> printOn: aStream [

	aStream
		print: oldName fullName;
		<< ' -> ';
		print: newBasename
]
