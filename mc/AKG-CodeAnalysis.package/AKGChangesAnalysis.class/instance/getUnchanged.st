private
getUnchanged
	"Build the set of methods that haven't changed"

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			change isMethodDeclaration ifTrue: [ 
				(change existsBehavior and: 
					[ change contents = (change targetClass sourceCodeAt: change methodSelector ifAbsent: []) ]) ifTrue: [ 
						stream nextPut: change ] ] ] ]