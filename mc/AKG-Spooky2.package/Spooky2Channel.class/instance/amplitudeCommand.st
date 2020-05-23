commands
amplitudeCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (24 + channel);
			print: (amplitude * 100) rounded ]