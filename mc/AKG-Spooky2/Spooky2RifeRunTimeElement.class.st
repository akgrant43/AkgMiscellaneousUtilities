Class {
	#name : #Spooky2RifeRunTimeElement,
	#superclass : #Spooky2RifeElement,
	#instVars : [
		'runTime'
	],
	#category : 'AKG-Spooky2-Rife-UI'
}

{ #category : #compiling }
Spooky2RifeRunTimeElement >> compileRunTime: aString [

	^ self class compiler evaluate: aString
]

{ #category : #configuration }
Spooky2RifeRunTimeElement >> configure [

	self addChild: (BlTextElement new 
		constraintsDo: [ :c |
					c horizontal exact: 180.
					c vertical fitContent. ];
		text: ('Run Time:' asRopedText fontSize: 32)).

	runTime := BrEditorElement new 
		constraintsDo: [ :c |
					c horizontal exact: 250.
					c vertical fitContent. ];
		background: self inputBackgroundColor;
		editor: (BrTextEditor new 
			text: '<not set>' asString asRopedText).
	runTime addShortcut: (BlShortcut new 
		combination: (BlSingleKeyCombination key: BlKeyboardKey return);
		action: [ self updateRunTime ]).
	self addChild: runTime.

	rifeModel ifNotNil: [ self updateModel ].
]

{ #category : #events }
Spooky2RifeRunTimeElement >> updateModel [ 
	| runTimeString |

	runTimeString := (rifeModel runTime asSeconds / 60.0) asString, ' minutes.'.
	runTime dataSource text: (runTimeString asRopedText fontSize: 32).
]

{ #category : #events }
Spooky2RifeRunTimeElement >> updateRunTime [

	rifeModel runTime: (self compileRunTime: runTime dataSource text asString)
]
