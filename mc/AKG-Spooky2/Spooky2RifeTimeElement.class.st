Class {
	#name : #Spooky2RifeTimeElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'time'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
Spooky2RifeTimeElement >> configure [ 

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 170.
					c vertical exact: 30. ];
		text: ('Time: ' asRopedText fontSize: 32)).

	time := BlTextElement new 
		constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical exact: 30. ];
		text: ('Not Started' asRopedText fontSize: 32).
	self addChild: time.
]

{ #category : #events }
Spooky2RifeTimeElement >> updateModel [ 
	| timeString colour |

	timeString := rifeModel isStopped
		ifTrue: [ '<not running>' ]
		ifFalse: [ String streamContents: [ :s | rifeModel time printHMSOn: s ] ].
	colour := rifeModel isRunning ifTrue: 
			[ Color fromHexString: #'47d147' ]
		ifFalse: [ rifeModel isHeld ifTrue: 
			[ Color red ]
		ifFalse:
			[ Color black ] ].
	time text: ((timeString asRopedText fontSize: 32) foreground: colour)
]
