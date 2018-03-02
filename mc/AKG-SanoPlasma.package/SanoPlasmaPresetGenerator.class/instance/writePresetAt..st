private
writePresetAt: freq
	"Write the preset file for the supplied frequency"

	| programName fileName fileReference stream subDir chain preset program frequencyRange |

	programName := self programNameAt: freq.
	fileName := String streamContents: [ :fstream |
		fstream 
			<< programName;
			<< ' xover'.
		namePostfix ifNotEmpty: [ 
			fstream
				<< ' ';
				<< namePostfix ].
		fstream
			<< '.txt' ].
	subDir := outDir / ('Step ', (freq printPaddedWith: $0 to: 6) first asString, '00').
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	frequencyRange := SanoPlasmaFrequencyRange new 
								fromFrequency: freq;
								toFrequency: (freq + freqRange);
								dwell: programSeconds;
								yourself.
	program := SanoPlasmaProgram new 
						name: programName;
						dwell: programSeconds;
						addFrequency: frequencyRange;
						yourself.
	settings	at: 'Program Name' put: programName.
	preset := SanoPlasmaPreset new 
					add: program;
					name: programName;
					settings: settings;
					yourself.
	chain := SanoPlasmaChain new
					add: preset;
					name: programName;
					yourself.

	stream := (File named: fileReference fullName) writeStream.
	[ chain writeOn: (ZnCrPlatformWriteStream 
							on: (ZnCharacterWriteStream on: stream encoding: 'utf8')
							lineEnd: String crlf) ]
		ensure: [ stream close ].
