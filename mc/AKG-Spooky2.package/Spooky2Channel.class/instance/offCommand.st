commands
offCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (60 + channel);
			<< '0' ]