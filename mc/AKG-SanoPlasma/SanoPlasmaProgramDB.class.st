Class {
	#name : #SanoPlasmaProgramDB,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'programs'
	],
	#category : 'AKG-SanoPlasma-Model'
}

{ #category : #'instance creation' }
SanoPlasmaProgramDB class >> rootDirectory: rootDir [

	^self new 
		fileName: rootDir / 'custom.csv';
		yourself
]

{ #category : #accessing }
SanoPlasmaProgramDB >> addOrReplace: aProgram [
	"Ensure the supplied program exists in the DB.
	If a program with the same name exists, replace it.
	If not program with the same name exists, add it."

	| index |

	index := self programs detectIndex: [ :each | each name = aProgram name ] 
						ifNone: [ 0 ].
	index = 0 
		ifTrue: [ programs := programs copyWith: aProgram ]
		ifFalse: [ programs at: index put: aProgram ].
	^aProgram
]

{ #category : #accessing }
SanoPlasmaProgramDB >> fileName [
	^ fileName
]

{ #category : #accessing }
SanoPlasmaProgramDB >> fileName: anObject [
	fileName := anObject
]

{ #category : #private }
SanoPlasmaProgramDB >> loadPrograms [

	| newPrograms csv |

	fileName readStreamDo: [ :stream |
		csv := NeoCSVReader on: stream.
		newPrograms := Array streamContents: [ :arrayStream |
			csv do: [ :record |
				arrayStream nextPut: (SanoPlasmaProgram fromCollection: record) ] ] ].
	^newPrograms
]

{ #category : #accessing }
SanoPlasmaProgramDB >> programs [
	^ programs ifNil: [ programs := self loadPrograms ]
]

{ #category : #actions }
SanoPlasmaProgramDB >> save [
	"Write the receiver back to the database"

	| csv |

	fileName ensureDelete.
	fileName writeStreamDo: [ :stream |
		csv := NeoCSVWriter on: stream.
		csv fieldWriter: #optionalQuoted.
		self programs do: [ :program |
			csv nextPut: program asArray ] ]
]
