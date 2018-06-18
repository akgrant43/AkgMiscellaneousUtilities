private
download: fileName from: aStringURL
	"Download the requested file from the supplied directory (URL)"

	| fullURL response downloadDir |

	fullURL := self downloadURL: fileName from: aStringURL.
	downloadDir := FileLocator home / 'Downloads'.
	self assert: downloadDir isDirectory.
	response := ZnEasy get: fullURL.
	(downloadDir / fileName) binaryWriteStreamDo: [ :stream |
		response writeOn: stream ].
	UIManager inform: 'Downloaded ', fileName.