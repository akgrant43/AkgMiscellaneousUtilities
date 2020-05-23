commands
offsetCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (26 + channel);
			print: offset ]