commands
phaseCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (30 + channel);
			print: phase ]