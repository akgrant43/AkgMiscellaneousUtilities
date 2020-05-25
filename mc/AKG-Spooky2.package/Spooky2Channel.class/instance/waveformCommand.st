commands
waveformCommand
	"Answer the command that will set the generator to the selected waveform"

	^ String streamContents: [ :stream |
		stream
			<< ':w';
			print: (20 + channel);
			print: waveform ]