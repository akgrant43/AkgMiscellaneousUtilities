"
Generate additions with two elements that are written on a single line.

Config items:

- #minValue
- #maxValue

The sums will have values between #minValue and #maxValue.  The larger number always comes first (no negative results).
 
Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #MathOneLineSubtraction,
	#superclass : #MathProblemYr2,
	#category : 'MathsYr2'
}

{ #category : #accessing }
MathOneLineSubtraction >> maxValue [

	^configDictionary at: #maxValue
]

{ #category : #accessing }
MathOneLineSubtraction >> minValue [

	^configDictionary at: #minValue
]

{ #category : #accessing }
MathOneLineSubtraction >> next [
	"Answer the next sum"

	| a b x y |

	a := (self minValue to: self maxValue) atRandom.
	b := (self minValue to: self maxValue) atRandom.
	x := a max: b.
	y := a min: b.
	^String streamContents: [ :stream |
		stream
			<< x printString;
			<< ' - ';
			<< y printString;
			<< ' =' ]
]
