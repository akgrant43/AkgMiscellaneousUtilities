"
Generate divisions with two elements that are written on a single line.

Config items:

- #minValue
- #maxValue

The divisions will be of the form: x / y = z, where:

- x <= maxValue
- minValue <= y <= maxValue




Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #MathOneLineDivision,
	#superclass : #MathProblemYr2,
	#category : 'MathsYr2'
}

{ #category : #accessing }
MathOneLineDivision >> maxDividend [
	"Answer the maximum allowed dividend in the problem"

	^configDictionary at: #maxDividend
]

{ #category : #accessing }
MathOneLineDivision >> maxDivisor [
	"Answer the maximum allowed divisor in the problem"

	^configDictionary at: #maxDivisor
]

{ #category : #accessing }
MathOneLineDivision >> maxValue [
	"Answer the maximum allowed value in the problem"

	^configDictionary at: #maxValue
]

{ #category : #accessing }
MathOneLineDivision >> minValue [
	"Answer the minimum allowed value in the problem"

	^configDictionary at: #minValue
]

{ #category : #accessing }
MathOneLineDivision >> next [
	"Answer the next sum"

	| valid x y maxZ |
	"x / y = z"

	valid := false.
	[ valid ] whileFalse: [ 
		y := (2 to: self maxDivisor) atRandom.
		maxZ := (self maxDividend / y) rounded.
		x := (2 to: maxZ) atRandom * y.
		valid := x <= self maxDividend and: [ (x/y) >= self minValue ] ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' / ';
			<< y printString;
			<< ' =' ]
]
