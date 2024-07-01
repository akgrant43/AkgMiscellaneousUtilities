Class {
	#name : #MathProblemsYr2,
	#superclass : #Object,
	#instVars : [
		'generators',
		'problemCount',
		'columns'
	],
	#category : 'MathsYr2'
}

{ #category : #'instance creation' }
MathProblemsYr2 class >> problems20180420 [

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
]

{ #category : #'instance creation' }
MathProblemsYr2 class >> problems20180521 [

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
]

{ #category : #'instance creation' }
MathProblemsYr2 class >> problems20180601 [

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
]

{ #category : #'instance creation' }
MathProblemsYr2 class >> problems20180702 [
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
]

{ #category : #converting }
MathProblemsYr2 >> asText [

	^(self textOn: (TextStream on: (Text new: 4986))) contents
]

{ #category : #accessing }
MathProblemsYr2 >> columns [
	^ columns
]

{ #category : #accessing }
MathProblemsYr2 >> columns: anObject [
	columns := anObject
]

{ #category : #accessing }
MathProblemsYr2 >> generators [
	^ generators
]

{ #category : #inspecting }
MathProblemsYr2 >> gtTextIn: composite [
	<gtInspectorPresentationOrder: 1>

	composite text
		title: 'Text';
		format: #asText;
		display: [ self asText ]
]

{ #category : #initialization }
MathProblemsYr2 >> initialize [

	super initialize.
	problemCount := 25.
	columns := 2.
]

{ #category : #initialization }
MathProblemsYr2 >> initializeWithGenerators: generatorCollection [

	generators := generatorCollection.
]

{ #category : #printing }
MathProblemsYr2 >> printOn: stream [
	"Answer the string representing the list of problems"

	| generatorSize generator line |

	generatorSize := generators size.
	problemCount timesRepeat: [ 
		line := String streamContents: [ :lineStream |
			columns timesRepeat: [ 
				generator := generators at: (1 to: generatorSize) atRandom.
				lineStream nextPutAll: (generator next padRightTo: 40) ] ].
		line := line trimRight.
		stream 
			<< line;
			cr; cr. ].
]

{ #category : #actions }
MathProblemsYr2 >> printProblems [
	"Print the receiver"

	| problems |

	problems := String streamContents: [ :stream | self printOn: stream ].
	AKGPrintStream printStream: problems readStream.

]

{ #category : #accessing }
MathProblemsYr2 >> problemCount [
	^ problemCount
]

{ #category : #accessing }
MathProblemsYr2 >> problemCount: anObject [
	problemCount := anObject
]

{ #category : #printing }
MathProblemsYr2 >> textOn: aTextStream [

	aTextStream
		nextPutAll: self printString;
		applyAttribute: (TextFontReference
					toFont: (LogicalFont 
						familyName: 'Source Code Pro' 
						pointSize: StandardFonts defaultFont pointSize)) beginningAt: 1.
	^aTextStream
]
