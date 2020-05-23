commands
waveformCommand

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (20 + channel);
			print: waveform ]