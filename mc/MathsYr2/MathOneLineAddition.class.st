"
Generate additions with two elements that are written on a single line.

Config items:

- #minValue
- #maxValue
- #maxSum

The sums will have values between #minValue and #maxValue and add up to something no greater than #maxSum.



Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #MathOneLineAddition,
	#superclass : #MathProblemYr2,
	#category : 'MathsYr2'
}

{ #category : #accessing }
MathOneLineAddition >> maxSum [

	^configDictionary at: #maxSum
]

{ #category : #accessing }
MathOneLineAddition >> maxValue [

	^configDictionary at: #maxValue
]

{ #category : #accessing }
MathOneLineAddition >> minValue [

	^configDictionary at: #minValue
]

{ #category : #accessing }
MathOneLineAddition >> next [
	"Answer the next sum"

	| valid x y |

	valid := false.
	[ valid ] whileFalse: [ 
		x := (self minValue to: self maxValue) atRandom.
		y := (self minValue to: self maxValue) atRandom.
		valid := (x + y) <= self maxSum ].
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' + ';
			<< y printString;
			<< ' =' ]
]
