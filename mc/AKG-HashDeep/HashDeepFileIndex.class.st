"
Index the supplied HashDeepFiles and provide convenience methods.

To find out which files exist only in leftSide:

| dir leftSide domcich1 domcich1Filenames |

dir := '/home/alistair/Documents/2017/1711Nov/hashdeep' asFileReference.
leftSide := HashDeepFiles fromFileName: (dir resolveString: 'domcich1/zdata03-backups-xps13-1703xx.hash').
domcich1Filenames := #('zdata03-backups-alistair-xps13.hash')
	collect: [ :fn | dir resolveString: 'domcich1/', fn ].
domcich1 := HashDeepFileIndex new.
domcich1Filenames do: [ :fn | domcich1 add: (HashDeepFiles fromFileName: fn) ].
{
	leftSide.
	domcich1. 
	domcich1 filesOnlyIn: leftSide.
}



 
Internal Representation and Key Implementation Points.

    Instance Variables
	collections:		<Object>
	fileDictionary:		<Object>


    Implementation Points
"
Class {
	#name : #HashDeepFileIndex,
	#superclass : #Object,
	#instVars : [
		'collections',
		'fileDictionary'
	],
	#category : 'AKG-HashDeep'
}

{ #category : #collections }
HashDeepFileIndex >> add: aHashDeepFiles [
	"Add the supplied file collection to the receiver"

	fileDictionary := nil.
	^collections add: aHashDeepFiles 
]

{ #category : #collections }
HashDeepFileIndex >> addFileName: fileReferenceOrString [
	"Add the collection in the supplied file to the receiver"

	^self add: (HashDeepFiles fromFileName: fileReferenceOrString)
]

{ #category : #private }
HashDeepFileIndex >> constructFileDictionary [

	| newDictionary bag |

	newDictionary := Dictionary new.
	collections do: [ :collection |
		collection files do: [ :file |
			bag := newDictionary at: file hash ifAbsentPut: [ OrderedCollection new ].
			bag add: file ] ].
	^newDictionary
]

{ #category : #comparing }
HashDeepFileIndex >> duplicates [
	"Answer the collection of files that are duplicates in the receivers index"

	^Array streamContents: [ :stream |
		self fileDictionary valuesDo: [ :each |
			each size > 1 ifTrue: [ stream nextPut: each ] ] ]
]

{ #category : #private }
HashDeepFileIndex >> fileDictionary [
	^ fileDictionary ifNil: [ fileDictionary := self constructFileDictionary ]
]

{ #category : #selecting }
HashDeepFileIndex >> filesMatchingName: aRegex [
	"Answer the collection of files with names matching aRegex"

	| regex |

	regex := aRegex asRegex.
	^Array streamContents: [ :stream |
		collections do: [ :collection |
			stream nextPutAll: (collection filesMatchingName: aRegex) ] ].
]

{ #category : #comparing }
HashDeepFileIndex >> filesOnlyIn: hashDeepFiles [
	"Answer the set of files that hashDeepFiles has but the receiver doesn't"

	| missing hdfDictionary |

	missing := Set new.
	hdfDictionary := self fileDictionary.
	hashDeepFiles files do: [ :file |
		(hdfDictionary includesKey: file hash) ifFalse: 
			[ missing add: file ] ].
	^missing
]

{ #category : #initialize }
HashDeepFileIndex >> initialize [

	super initialize.
	collections := OrderedCollection new.
]
