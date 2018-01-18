writing
writeOn: aStream
	"Write the receiver on aStream"

	| program frequencyRange |

	self assert: name isNotNil description: 'Preset Name not supplied'.
	self assert: programs size = 1 description: 'Can only save a preset with a single program for now'.
	program := programs first.
	self assert: program frequencies size = 1 description: 'Can only handle a single frequency range'.
	frequencyRange := program frequencies first.

	settings 
		at: 'PresetName' put: self name;
		at: 'Text17' put: program name;
		at: 'Text22(1)' put: frequencyRange sum;
		at: 'List2' put: program name, ' (CUST)';
		at: 'List4' put: frequencyRange asString;
		at: 'List5' put: frequencyRange asString1.

	aStream lineEndConvention: #crlf.
	aStream << '"[Preset]"'; cr.
	settings writeOn: aStream.
	aStream << '"[/Preset]"'; cr.
