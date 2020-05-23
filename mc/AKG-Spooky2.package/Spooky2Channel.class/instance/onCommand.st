commands
onCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (60 + channel);
			<< '1' ]