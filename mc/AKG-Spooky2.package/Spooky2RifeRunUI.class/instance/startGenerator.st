private
startGenerator

	self acceptInput.
	model c1FunctionString: c1Function text asString.
	model c2FunctionString: c2Function text asString.
	model runTime: (runTime text asNumber * 60) asSeconds.
	model wobble: (enableWobble state 
				ifTrue: [ wobbleAmount text asNumber ]
				ifFalse: [ 0 ]).
	model start.