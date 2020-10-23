accessing
runTime: anObject
	| oldRunTime |

	oldRunTime := runTime.
	runTime := anObject.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldRunTime;
		newValue: runTime;
		parameterName: #runTime)