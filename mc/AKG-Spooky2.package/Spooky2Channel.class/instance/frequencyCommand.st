commands
frequencyCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (22 + channel);
			print: (frequency * 100) rounded ]