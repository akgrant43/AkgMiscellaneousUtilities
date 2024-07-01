Class {
	#name : #Spooky2RifeControlButtonsElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'play',
		'pause',
		'hold',
		'stop',
		'wobble'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #configuration }
Spooky2RifeControlButtonsElement >> configure [

	play := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Play' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPlay ].
	self addChild: play.

	pause := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Pause' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doPause ].
	self addChild: pause.

	hold := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		vFitContent;
		hExact: 150;
		look: BrGlamorousButtonWithLabelLook;
		label: 'Hold' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doHold ].
	self addChild: hold.

	wobble := BrButton new 
		beHuge;
		margin: (BlInsets left: 0 right: 10);
		look: BrGlamorousButtonWithLabelLook;
		label: 'Wobble' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doWobble ].
	self addChild: wobble.

	stop := BrButton new 
		beHuge;
		constraintsDo: [ :c |
					c horizontal exact: 30.
					c vertical exact: 30. ];
		look: BrGlamorousButtonWithLabelLook;
		label: 'Stop' asRopedText;
		action: [ :theButton :aButtonModel :anEvent | self doStop ].
	self addChild: stop.

	self setButtonState.

	^ self.
]

{ #category : #'private - button actions' }
Spooky2RifeControlButtonsElement >> doHold [
	| label |

	label := 'Hold' asRopedText.
	rifeModel isHeld ifTrue: 
		[ rifeModel unhold; stopWobble.
		(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel hold.
		label := 'Hold' asRopedText.
		(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color red ].
	hold label: label.
	self setButtonState.

]

{ #category : #'private - button actions' }
Spooky2RifeControlButtonsElement >> doPause [

	rifeModel isPaused ifTrue: 
		[ rifeModel unpause.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel pause.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color red ].
	self setButtonState.

]

{ #category : #'private - button actions' }
Spooky2RifeControlButtonsElement >> doPlay [

	rifeModel isStopped ifFalse: [ ^ self ].

	rifeModel start.
	self setButtonState.

]

{ #category : #'private - button actions' }
Spooky2RifeControlButtonsElement >> doStop [

	rifeModel isStopped ifTrue: [ ^self ].

	rifeModel stop.
	self setButtonState.
]

{ #category : #'private - button actions' }
Spooky2RifeControlButtonsElement >> doWobble [

	rifeModel isWobbling ifTrue: 
		[ rifeModel stopWobble.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color white ]
	ifFalse: 
		[ rifeModel startWobble.
		(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: Color green ].
	self setButtonState.

]

{ #category : #initialization }
Spooky2RifeControlButtonsElement >> setButtonState [
	"Enable / Disable all buttons as appropriate"
	| stopped |

	stopped := rifeModel isStopped.
	stop enabled: stopped not.
	play enabled: stopped.
	pause enabled: (rifeModel isRunning or: [ rifeModel isPaused ]).
	(pause look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: 
		(rifeModel isPaused
			ifTrue: [ Color red ]
			ifFalse: [ Color white ]).	
	hold enabled: (rifeModel isRunning or: [rifeModel isHeld ]).
	(hold look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: 
		(rifeModel isHeld
			ifTrue: [ Color red ]
			ifFalse: [ Color white ]).	
	wobble enabled: (rifeModel isRunning or: [rifeModel isHeld ]).
	(wobble look findActor: BrGlamorousButtonExteriorLook) backgroundPaint: 
		(rifeModel isWobbling
			ifTrue: [ Color green ]
			ifFalse: [ Color white ]).	
	wobble invalidate.
]

{ #category : #events }
Spooky2RifeControlButtonsElement >> updateModel [ 

	super updateModel.
	self setButtonState.
]
