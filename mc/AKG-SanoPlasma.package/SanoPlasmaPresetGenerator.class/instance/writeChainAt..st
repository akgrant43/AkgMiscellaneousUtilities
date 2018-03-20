private
writeChainAt: freq
	"Write the preset file for the supplied frequency creating the configured number of crossovers"

	| chainName presetName fileName fileReference bStream cStream subDir chain preset program frequencyRange fromFreq toFreq |

	chainName := self programNameAt: freq.
	fileName := String streamContents: [ :fstream |
		fstream << chainName.
		namePostfix ifNotEmpty: [ 
			fstream
				<< ' ';
				<< namePostfix ].
		fstream
			<< '.txt' ].
	subDir := outDir / ('Step ', (freq printPaddedWith: $0 to: 6) first asString, '00').
	subDir ensureCreateDirectory.
	fileReference := subDir / fileName.

	settings	at: 'Program Name' put: chainName.
	chain := SanoPlasmaChain new
					name: chainName;
					yourself.
	1 to: crossoverCount do: [ :i |
		fromFreq := freq + (freqRange * (i - 1) / crossoverCount) rounded.
		toFreq := freq + (freqRange * i / crossoverCount) rounded.
		presetName := self presetNameFrom: fromFreq to: toFreq.
		frequencyRange := SanoPlasmaFrequencyRange new 
								fromFrequency: fromFreq;
								toFrequency: toFreq;
								dwell: (programSeconds / crossoverCount) rounded;
								yourself.
		program := SanoPlasmaProgram new 
						name: presetName;
						dwell: (programSeconds / crossoverCount) rounded;
						addFrequency: frequencyRange;
						yourself.
		preset := SanoPlasmaPreset new 
					name: presetName;
					add: program;
					settings: settings;
					yourself.
		chain add: preset ].

	bStream := (File named: fileReference fullName) writeStream.
	cStream := ZnCrPlatformWriteStream 
							on: (ZnCharacterWriteStream on: bStream encoding: 'utf8')
							lineEnd: String crlf.
	[ chain writeOn: cStream ]
		ensure: [ cStream close ].
