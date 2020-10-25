accessing
functionString: aString
	| oldString |

	oldString := functionString.
	functionString := aString.
	function := self compileFunction: aString.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldString;
		newValue: functionString;
		parameterName: #functionString)