Class {
	#name : #HashDeepFiles,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'header',
		'files',
		'fileDictionary'
	],
	#category : 'AKG-HashDeep'
}

{ #category : #'instance creation' }
HashDeepFiles class >> fromFileName: fileReferenceOrString [

	| fileReference |

	fileReference := fileReferenceOrString asFileReference.
	^fileReference readStreamDo: [ :stream |
		self fromName: fileReference stream: stream ]
]

{ #category : #'instance creation' }
HashDeepFiles class >> fromName: fileName stream: aStream [

	| files header line hdf |

	header := ''.
	line := aStream nextLine.
	files := Array streamContents: [ :stream |
		[ line isNil ] whileFalse: [
			(#($# $%) includes: line first) ifTrue: 
				[ header := String streamContents: [ :headertream |
						headertream
							<< header;
							nextPut: Character cr;
							<< line ] ]
			ifFalse: [ 
				hdf := HashDeepFile fromString: line.
				hdf source: self.
				stream nextPut: hdf ].
			line := aStream nextLine ] ].
	^self new 
		fileName: fileName;
		files: files;
		header: header;
		yourself
]

{ #category : #accessing }
HashDeepFiles >> fileName [
	^ fileName
]

{ #category : #accessing }
HashDeepFiles >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
HashDeepFiles >> files [
	^ files
]

{ #category : #accessing }
HashDeepFiles >> files: anObject [

	files := anObject.
	fileDictionary := nil.
]

{ #category : #selecting }
HashDeepFiles >> filesMatchingName: aRegex [
	"Answer the collection of files with names matching aRegex"

	| regex |

	regex := aRegex asRegex.
	^Array streamContents: [ :stream |
		self files do: [ :file |
			(regex search: file fileName) ifTrue: 
				[ stream nextPut: file ] ] ].
]

{ #category : #accessing }
HashDeepFiles >> header [
	^ header
]

{ #category : #accessing }
HashDeepFiles >> header: anObject [
	header := anObject
]
