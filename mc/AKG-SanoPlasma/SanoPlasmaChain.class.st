Class {
	#name : #SanoPlasmaChain,
	#superclass : #SanoPlasmaModel,
	#instVars : [
		'name',
		'presets'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaChain class >> fromFile: aFilename [

	^aFilename asFileReference readStreamDo: [ :stream |
		(self fromStream: stream)
			name: aFilename basename;
			yourself ]
]

{ #category : #'instance creation' }
SanoPlasmaChain class >> fromStream: aStream [

	| chain |

	chain := self new.
	[ aStream atEnd ] whileFalse: [ 
		chain add: (SanoPlasmaPreset fromStream: aStream) ].
	^chain
]

{ #category : #accessing }
SanoPlasmaChain >> add: aPreset [

	^presets add: aPreset
]

{ #category : #printing }
SanoPlasmaChain >> descriptionText [

	^String streamContents: [ :stream |
		 ]
]

{ #category : #inspecting }
SanoPlasmaChain >> gtInspectEditIn: composite [
	<gtInspectorPresentationOrder: 3>

	^ composite spec
		title: 'Edit';
		display: [:arg1 | 
			SanoPlasmaChainUI new
				chain: arg1;
				buildWithSpec;
				yourself ].
]

{ #category : #initialization }
SanoPlasmaChain >> initialize [

	super initialize.
	presets := OrderedCollection new.
]

{ #category : #accessing }
SanoPlasmaChain >> name [
	^ name
]

{ #category : #accessing }
SanoPlasmaChain >> name: anObject [
	name := anObject
]

{ #category : #accessing }
SanoPlasmaChain >> presets [
	^ presets
]

{ #category : #printing }
SanoPlasmaChain >> printOn: aStream [

	super printOn: aStream.
	aStream
		<< '(';
		<< name asString;
		<< ')'
]

{ #category : #writing }
SanoPlasmaChain >> saveIn: aDirectory [
	"Write the receiver in aDirectory"

	| fileName stream |

	self assert: aDirectory isDirectory 
		description: aDirectory fullName, ' isn''t a directory'.
	self assert: (name isNotNil and: [ name isNotEmpty ])
		description: 'The Chain name cannot be nil or empty'.

	fileName := aDirectory / name.
	stream := (File named: fileName fullName) writeStream.
	[ self writeOn: (ZnCrPlatformWriteStream 
							on: (ZnCharacterWriteStream on: stream encoding: 'utf8')
							lineEnd: String crlf) ]
		ensure: [ stream close ].

]

{ #category : #writing }
SanoPlasmaChain >> writeOn: aStream [

	self assert: presets isNotEmpty 
		description: 'Error: no presets'.

	presets do: [ :preset | preset writeOn: aStream ]
]
