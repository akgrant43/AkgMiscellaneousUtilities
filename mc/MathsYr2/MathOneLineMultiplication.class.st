"
Generate multiplications with two elements that are written on a single line.

Config items:

- #minValue
- #maxValue
- #maxResult

The multiplcations will have values between #minValue and #maxValue and add up to something no greater than #maxResult.



Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #MathOneLineMultiplication,
	#superclass : #MathProblemYr2,
	#category : 'MathsYr2'
}

{ #category : #accessing }
MathOneLineMultiplication >> maxResult [
	"Answer the maximum allowed result"

	^configDictionary at: #maxResult
]

{ #category : #accessing }
MathOneLineMultiplication >> maxValue [
	"Answer the maximum allowed value in the problem"

	^configDictionary at: #maxValue
]

{ #category : #accessing }
MathOneLineMultiplication >> minValue [
	"Answer the minimum allowed value in the problem"

	^configDictionary at: #minValue
]

{ #category : #accessing }
MathOneLineMultiplication >> next [
	"Answer the next sum"

	| valid x y |

	valid := false.
	[ valid ] whileFalse: [ 
		x := (self minValue to: self maxValue) atRandom.
		y := (self minValue to: self maxValue) atRandom.
		valid := (x * y) <= self maxResult ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' * ';
			<< y printString;
			<< ' =' ]
]
