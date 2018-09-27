private
getAdded
	"Build the set of methods that don't exist in the system and are added by the receivers file"

	^Array streamContents: [ :stream |
		externalChanges do: [ :change |
			(change isMethodDeclaration and: 
				[ change existsBehavior not or: [ (change targetClass methodDict includesKey: change methodSelector) not ] ]) ifTrue: 
				[ stream nextPut: change ] ] ]