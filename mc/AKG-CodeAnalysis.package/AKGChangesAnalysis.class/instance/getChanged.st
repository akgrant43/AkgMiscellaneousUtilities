private
getChanged
	"Build the set of methods that exist in the system but are changed by the receivers file"

	| imageSource |

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			(change isMethodDeclaration and: [ change existsBehavior ]) ifTrue: [ 
					imageSource := change targetClass sourceCodeAt: change methodSelector ifAbsent: [ #missing ].
					(imageSource ~= #missing and: [ change contents ~= imageSource ]) ifTrue: [ 
						stream nextPut: change ] ] ] ]