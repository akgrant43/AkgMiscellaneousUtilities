reports
saveReportStringIn: aDirectory
	"Answer the receivers report string in aDirectory"

	| reportName |
	reportName := aDirectory / self reportFilename.
	reportName binaryWriteStreamDo: [ :outputStream |
		(ZnNewLineWriterStream on:
			(ZnCharacterWriteStream on: outputStream encoding: 'utf8'))
				forCrLf;
				nextPutAll: self reportString.
	].
	UIManager default inform: 'Saved report to: ', reportName fullName