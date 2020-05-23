accessing
c2FunctionString: aString

	c2FunctionString := aString.
	c2Function := self compileFunction: aString.