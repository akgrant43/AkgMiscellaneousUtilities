instance creation
problems20180521

	| generators |
	
	generators := { 
		MathOneLineAddition config: { 
			#minValue -> 0.
			#maxValue -> 50.
			#maxSum -> 100. } asDictionary.
		MathOneLineSubtraction config: { 
			#minValue -> 0.
			#maxValue -> 50. } asDictionary. }.
	^self new initializeWithGenerators: generators.