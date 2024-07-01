"
MathProblemYr2 is an abstract superclass for all types of maths problems that are generated.

Each problem is passed a dictionary that represents the bounds of the generated problems.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

	configDictionary   <Dictionary>  Parameters for generating the problems.  Values are subclass specific.

    Implementation Points
"
Class {
	#name : #MathProblemYr2,
	#superclass : #Stream,
	#instVars : [
		'configDictionary'
	],
	#category : 'MathsYr2'
}

{ #category : #'instance creation' }
MathProblemYr2 class >> config: aConfig [

	^self basicNew initializeWithConfig: aConfig
]

{ #category : #testing }
MathProblemYr2 >> atEnd [
	"As a generated stream, there is no end"
	
	^false
]

{ #category : #accessing }
MathProblemYr2 >> contents [
	"We don't have contents"
	
	^self shouldNotImplement 
]

{ #category : #initialization }
MathProblemYr2 >> initializeWithConfig: aConfig [

	self initialize.
	configDictionary := aConfig.
]

{ #category : #accessing }
MathProblemYr2 >> nextPut: anObject [
	"We're read only"
	
	^self shouldNotImplement 
]
