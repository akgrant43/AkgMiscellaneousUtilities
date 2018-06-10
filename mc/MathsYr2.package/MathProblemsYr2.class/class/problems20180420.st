instance creation
problems20180420

	| generators |
	
	generators := { 
		MathOneLineAddition config: { 
			#minValue -> 0.
			#maxValue -> 100.
			#maxSum -> 100. } asDictionary.
		MathOneLineSubtraction config: { 
			#minValue -> 0.
			#maxValue -> 100. } asDictionary. }.
	^self new initializeWithGenerators: generators.