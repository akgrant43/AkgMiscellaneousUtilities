as yet unclassified
saveIn: aDirectory
	"Save the receiver in the supplied directory"

	| fileName templateDictionary program frequencyRange |

	self assert: name isNotNil description: 'Preset Name not supplied'.
	self assert: programs size = 1 description: 'Can only save a preset with a single program for now'.
	self assert: aDirectory parent isDirectory description: 'Parent directory must exist'.
	program := programs first.
	self assert: program frequencies size = 1 description: 'Can only handle a single frequency range'.
	frequencyRange := program frequencies first.
	aDirectory ensureCreateDirectory.
	fileName := self fileNameIn: aDirectory.

	templateDictionary := Dictionary new 
		at: 'presetName' put: self name;
		at: 'programName' put: self name;
		at: 'fromFrequency' put: frequencyRange fromFrequency;
		at: 'toFrequency' put: frequencyRange toFrequency;
		at: 'freqSum' put: frequencyRange sum;
		at: 'timeInSeconds' put: program timeInSeconds;
		at: 'out1FreqLimitMin' put: settings out1FreqLimitMin;
		at: 'out1FreqLimitMax' put: settings out1FreqLimitMax;
		yourself.

	fileName writeStreamDo: [ :stream |
		stream lineEndConvention: #crlf.
		stream nextPutAll: (self class template format: templateDictionary) ]
