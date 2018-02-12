private
writePresetAt: freq
	"Write the preset file for the supplied frequency"

	| programName fileName fileReference presetDictionary subDir |

	programName := self programNameAt: freq.
	fileName := programName, ' xover.txt'.
	subDir := outDir / ('Step', freq asString first asString).
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	presetDictionary := Dictionary new 
		at: 'presetName' put: programName;
		at: 'programName' put: programName;
		at: 'programSeconds' put: programSeconds;
		at: 'freqSum' put: (2 * freq + freqRange);
		yourself.

	fileReference writeStreamDo: [ :stream |
		stream nextPutAll: (presetTemplate format: presetDictionary) ].