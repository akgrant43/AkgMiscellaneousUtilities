reports
saveReportStringIn: aDirectory
	"Answer the receivers report string in aDirectory"

	| reportName |
	reportName := aDirectory / (self fileReference basenameWithoutExtension, '.txt').
	reportName binaryWriteStreamDo: [ :outputStream |
		(ZnCharacterWriteStream on: outputStream encoding: 'utf8')
			nextPutAll: self reportString.
	].
	UIManager default inform: 'Saved report to: ', reportName fullName