updating
updateModel
	"The model has changed, update the display"

	c1Function text: model c1FunctionString.
	c2Function text: model c2FunctionString.
	runTime text: model runTime asString.
	wobbleAmount text: model wobble asString.
	enableWobble state: model wobble > 0.