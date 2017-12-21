private
writePresetAt: freq
	"Write the preset file for the supplied frequency"

	| programName fileName fileReference presetDictionary |

	programName := self programNameAt: freq.
	fileName := programName, ' xover.txt'.
	fileReference := outDir / fileName.

	presetDictionary := Dictionary new 
		at: 'presetName' put: programName;
		at: 'programName' put: programName;
		at: 'freqSum' put: (2 * freq + freqRange);
		yourself.

	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: (presetTemplate format: presetDictionary) ].