as yet unclassified
saveIn: aDirectory
	"Save the receiver in the supplied directory"

	| fileName templateDictionary program |

	self assert: name isNotNil description: 'Preset Name not supplied'.
	self assert: programs size = 1 description: 'Can only save a preset with a single program for now'.
	fileName := self fileNameIn: aDirectory.

	program := programs first.
	templateDictionary := Dictionary new 
		at: 'presetName' put: self name;
		at: 'programName' put: self name;
		at: 'fromFrequency' put: program fromFrequency;
		at: 'toFrequency' put: program toFrequency;
		at: 'freqSum' put: (program fromFrequency + program toFrequency);
		at: 'timeInSeconds' put: program timeInSeconds;
		at: 'out1FreqLimitMin' put: settings out1FreqLimitMin;
		at: 'out1FreqLimitMax' put: settings out1FreqLimitMax;
		yourself.

	fileName writeStreamDo: [ :stream |
		stream nextPutAll: (self class template format: templateDictionary) ]
