instance creation
problems20180601

	| generators |
	
	generators := { 
		MathOneLineAddition config: { 
			#minValue -> 0.
			#maxValue -> 50.
			#maxSum -> 100. } asDictionary.
		MathOneLineSubtraction config: { 
			#minValue -> 0.
			#maxValue -> 50. } asDictionary.
		MathOneLineMultiplication config: { 
			#minValue -> 1.
			#maxValue -> 10.
			#maxResult -> 60. } asDictionary.
		MathOneLineDivision config: { 
			#maxDividend -> 40.
			#maxDivisor -> 10. } asDictionary. }.
	^self new initializeWithGenerators: generators.