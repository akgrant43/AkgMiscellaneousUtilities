accessing
channel: channelNumber functionString: aString

	functionStrings at: channelNumber put: aString.
	functions at: channelNumber put: (self compileFunction: aString).