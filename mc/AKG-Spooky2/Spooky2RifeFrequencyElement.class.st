"
Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	rifeModel: 		<Spooky2RifeChannelModel>
	frequency:		<BlTextElement>


!!!Implementation Points
"
Class {
	#name : #Spooky2RifeFrequencyElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'frequency'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
Spooky2RifeFrequencyElement >> configure [ 
	| label |

	label := rifeModel label, ' (kHz): '.
	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 250.
					c vertical exact: 30. ];
		text: ((label asRopedText fontSize: 32) foreground: rifeModel suggestedColor)).

	frequency := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: (rifeModel frequency asString asRopedText fontSize: 32).
	self addChild: frequency.
]

{ #category : #events }
Spooky2RifeFrequencyElement >> updateModel [ 
	| frequencyString |

	frequencyString := rifeModel isStopped 
		ifTrue: [ '<not running>' ]
		ifFalse: [ (rifeModel frequency / 1000.0) printShowingDecimalPlaces: 3 ].
	frequency text: (frequencyString asRopedText fontSize: 32)
]
