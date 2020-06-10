private
defaultFunctionUp: aBoolean

	^ String streamContents: [ :stream |
		stream 
			<< 'Spooky2RampProgramme new'; cr;
			<< '	startFrequency: 1000;'; cr;
			<< '	endFrequency: 2000;'; cr;
			<< '	duration: 1 minute;'; cr;
			<< '	up: ';
				print: aBoolean; cr ].