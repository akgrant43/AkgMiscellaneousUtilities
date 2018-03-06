accessing
rawScanData
	"Answer the raw scan data as a DataFrame"

	| csv rows header rawData |

	rows := OrderedCollection new.
	self fileReference readStreamDo: [ :stream |
		csv := NeoCSVReader on: stream.
		header := csv readHeader.
		csv do: [ :row |
			rows add: (Array streamContents: [ :array |
				row do: [ :cell | array nextPut: cell asNumberOrNil ] ]) ] ].
	rawData := DataFrame fromRows: rows.
	rawData columnNames: header.
	^rawData