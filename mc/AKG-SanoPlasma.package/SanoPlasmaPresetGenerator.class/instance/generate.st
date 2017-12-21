actions
generate
	"Generate the custom.csv file and associated presets in the specified directory"

	| customCSV |

	customCSV := outDir / 'custom.csv'.
	customCSV writeStreamDo: [ :customCsvStream |
		startFreq to: endFreq by: stepFreq do: [ :freq |
			self writeProgramAt: freq to: customCsvStream.
			self writePresetAt: freq. ] ].