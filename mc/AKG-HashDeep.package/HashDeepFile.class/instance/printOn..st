printing
printOn: aStream

	fileName ifNil: [ ^super printOn: aStream ].
	aStream
		<< self class name;
		<< '(';
		<< fileName;
		<< ')'