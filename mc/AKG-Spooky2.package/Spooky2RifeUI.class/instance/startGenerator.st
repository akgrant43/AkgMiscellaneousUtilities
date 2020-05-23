private
startGenerator

	self acceptInput.
	model c1FunctionString: c1Function text.
	model c2FunctionString: c2Function text.
	model runTime: (runTime text asNumber * 60) asSeconds.
	model start.