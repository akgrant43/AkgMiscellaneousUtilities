accessing
addOrReplace: aProgram
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