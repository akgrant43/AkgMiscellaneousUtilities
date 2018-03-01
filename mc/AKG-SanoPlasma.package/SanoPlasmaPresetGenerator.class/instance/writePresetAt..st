private
writePresetAt: freq
	"Write the preset file for the supplied frequency"

	| programName fileName fileReference presetDictionary subDir |

	programName := self programNameAt: freq.
	fileName := String streamContents: [ :stream |
		stream 
			<< programName;
			<< ' xover'.
		namePostfix ifNotEmpty: [ 
			stream
				<< ' ';
				<< namePostfix ].
		stream
			<< '.txt' ].
	subDir := outDir / ('Step ', (freq printPaddedWith: $0 to: 6) first asString, '00').
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	presetDictionary := Dictionary new 
		at: 'presetName' put: programName;
		at: 'programName' put: programName;
		at: 'programSeconds' put: programSeconds;
		at: 'fromFrequency' put: freq;
		at: 'toFrequency' put: (freq + freqRange);
		at: 'freqSum' put: (2 * freq + freqRange);
		at: 'harmonicWobble' put: 'None';
		at: 'out2VoltageMultiplier' put: '2.3';
		yourself.

	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: (presetTemplate format: presetDictionary) ].