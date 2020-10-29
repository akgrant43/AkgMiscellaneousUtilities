accessing
timeOffset: anObject
	| oldOffset |

	oldOffset := timeOffset.
	timeOffset := anObject.
	self announcer announce: (Spooky2ParameterChanged new 
		oldValue: oldOffset;
		newValue: timeOffset;
		parameterName: #timeOffset)