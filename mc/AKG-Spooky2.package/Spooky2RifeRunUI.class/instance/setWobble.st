initialization
setWobble

	model wobble: (enableWobble state 
				ifTrue: [ wobbleAmount text asNumber ]
				ifFalse: [ 0 ]).
