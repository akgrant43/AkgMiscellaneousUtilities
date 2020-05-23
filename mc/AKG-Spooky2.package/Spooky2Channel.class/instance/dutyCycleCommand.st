commands
dutyCycleCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (28 + channel);
			print: dutyCycle ]