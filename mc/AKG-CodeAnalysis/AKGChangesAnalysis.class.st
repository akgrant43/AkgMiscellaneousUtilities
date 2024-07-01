Class {
	#name : #AKGChangesAnalysis,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'externalChanges',
		'unchanged',
		'changed',
		'added',
		'removed',
		'other',
		'missing'
	],
	#category : 'AKG-CodeAnalysis'
}

{ #category : #'instance creation' }
AKGChangesAnalysis class >> openFile: aFilename [

	^self new
		openFile: aFilename;
		yourself
]

{ #category : #accessing }
AKGChangesAnalysis >> added [
	"Answer the set of methods that don't exist in the image and are added by the receivers file"

	^added ifNil: [ added := self getAdded asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]
]

{ #category : #accessing }
AKGChangesAnalysis >> changed [
	"Answer the set of methods that exist in the image and are changed by the receivers file"

	^changed ifNil: [ changed := self getChanged asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]
]

{ #category : #private }
AKGChangesAnalysis >> getAdded [
	"Build the set of methods that don't exist in the system and are added by the receivers file"

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			(change isMethodDeclaration and: 
				[ change existsBehavior not or: [ (change targetClass methodDict includesKey: change methodSelector) not ] ]) ifTrue: 
				[ stream nextPut: change ] ] ]
]

{ #category : #private }
AKGChangesAnalysis >> getChanged [
	"Build the set of methods that exist in the system but are changed by the receivers file"

	| imageSource |

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			(change isMethodDeclaration and: [ change existsBehavior ]) ifTrue: [ 
					imageSource := change targetClass sourceCodeAt: change methodSelector ifAbsent: [ #missing ].
					(imageSource ~= #missing and: [ change contents ~= imageSource ]) ifTrue: [ 
						stream nextPut: change ] ] ] ]
]

{ #category : #private }
AKGChangesAnalysis >> getMissing [
	"Answer the methods that are in the image but not the receiver's file.
	Answer for all classes modified in the change set (based on added and changed methods)"

	| classes selectors classSelectors newMissing |

	"Collect the set of classes and selectors"
	classes := Set new.
	selectors := Dictionary new.
	externalChanges do: [ :change |
		change isMethodDeclaration ifTrue: [ 
			classes add: change targetClass.
			classSelectors := selectors at: change targetClass 
										ifAbsentPut: [ Set new ].
			classSelectors add: change methodSelector ] ].

	"Iterate over all the classes and determine what's missing"
	newMissing := Array streamContents: [ :stream |
		classes do: [ :class |
			class selectors do: [ :selector |
				((selectors at: class) includes: selector) ifFalse: 
					[ stream nextPut: class >> selector ] ] ] ].

	^newMissing
]

{ #category : #private }
AKGChangesAnalysis >> getOther [
	"Answer any other chunks"

	| newOther |
	newOther := externalChanges copy.
	newOther 	
		removeAll: self added;
		removeAll: self changed;
		removeAll: self removed;
		removeAll: self unchanged.
	^newOther
]

{ #category : #private }
AKGChangesAnalysis >> getRemoved [
	"Build the set of methods that exist in the system and are removed by the receivers file"

	^Array streamContents: [ :stream | ]
]

{ #category : #private }
AKGChangesAnalysis >> getUnchanged [
	"Build the set of methods that haven't changed"

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			change isMethodDeclaration ifTrue: [ 
				(change existsBehavior and: 
					[ change contents = (change targetClass sourceCodeAt: change methodSelector ifAbsent: []) ]) ifTrue: [ 
						stream nextPut: change ] ] ] ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectAddedIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Added';
		display: [ self added ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectChangedIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Changed';
		display: [ self changed ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectMissingIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Missing';
		display: [ self missing ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectOtherIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Other';
		display: [ self other ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectRemovedIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Removed';
		display: [ self removed ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #inspecting }
AKGChangesAnalysis >> gtInspectUnchangedIn: composite [
	<gtInspectorPresentationOrder: 50>

	composite list 
		title: 'Unchanged';
		display: [ self unchanged ];
		format: [ :each | each gtDisplayString ]
]

{ #category : #accessing }
AKGChangesAnalysis >> missing [
	"Answer the set of methods that exist in the image but aren't in the receivers file"

	^missing ifNil: [ missing := self getMissing asSortedCollection: [ :a :b | a selector < b selector ] ]
]

{ #category : #'instance creation' }
AKGChangesAnalysis >> openFile: aFilename [

	| changeSet |
	
	fileName := aFilename asFileReference.
	changeSet := CodeImporter fileNamed: fileName.
	changeSet parseChunks.
	externalChanges := changeSet codeDeclarations.

]

{ #category : #accessing }
AKGChangesAnalysis >> other [
	"Answer any other chunks"

	^other ifNil: [ other := self getOther ]
]

{ #category : #accessing }
AKGChangesAnalysis >> removed [
	"Answer the set of methods that don't exist in the image and are added by the receivers file"

	^removed ifNil: [ removed := self getRemoved asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]
]

{ #category : #accessing }
AKGChangesAnalysis >> unchanged [
	"Answer the set of methods that haven't changed"

	^unchanged ifNil: [ unchanged := self getUnchanged asSortedCollection: [ :a :b | a methodSelector < b methodSelector ] ]
]
