printing
printOn: aStream

	super printOn: aStream.
	aStream
		<< '(';
		<< name asString;
		<< ')'