instance creation
problems20180702
	<script>

	| generators problems |
	
	generators := { 
		MathOneLineAddition config: { 
			#minValue -> 2.
			#maxValue -> 50.
			#maxSum -> 100. } asDictionary.
		MathOneLineSubtraction config: { 
			#minValue -> 2.
			#maxValue -> 50. } asDictionary.
		MathOneLineMultiplication config: { 
			#minValue -> 2.
			#maxValue -> 10.
			#maxResult -> 60. } asDictionary.
		MathOneLineDivision config: { 
			#maxDividend -> 40.
			#maxDivisor -> 10.
			#minValue -> 2. } asDictionary. }.
	problems := self new initializeWithGenerators: generators.
	problems printProblems.
	^problems