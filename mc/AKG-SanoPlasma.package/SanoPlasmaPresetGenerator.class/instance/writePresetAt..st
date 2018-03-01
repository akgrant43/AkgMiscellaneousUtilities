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
	subDir := outDir / ('Step ', freq asString first asString, '00').
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	presetDictionary := Dictionary new 
		at: 'presetName' put: programName;
		at: 'programName' put: programName;
		at: 'programSeconds' put: programSeconds;
		at: 'fromFrequency' put: freq;
		at: 'toFrequency' put: (freq + freqRange);
		at: 'freqSum' put: (2 * freq + freqRange);
		yourself.

	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: (presetTemplate format: presetDictionary) ].