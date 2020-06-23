private
defaultFunctionUp: aBoolean
	| duration |
	
	duration := #('20' '6') at: self channelNumber.
	^ String streamContents: [ :stream |
		stream 
			<< 'Spooky2RampProgramme new'; cr;
			<< '	startFrequency: 1000;'; cr;
			<< '	endFrequency: 2000;'; cr;
			<< '	duration: ';
			<< duration;
			<< ' minutes;'; cr;
			<< '	up: ';
				print: aBoolean; cr ].