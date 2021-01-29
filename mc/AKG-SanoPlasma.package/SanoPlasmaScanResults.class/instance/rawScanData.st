accessing
rawScanData
	"Answer the raw scan data as a DataFrame"

	| csv rows header rawData |

	rows := OrderedCollection new.
	self fileReference readStreamDo: [ :stream |
		csv := NeoCSVReader on: stream.
		header := csv readHeader.
		(header includes: 'Frequency (Hz)') ifFalse: [ ^ nil ].
		csv do: [ :row |
			rows add: (Array streamContents: [ :array |
				row do: [ :cell | array nextPut: cell asNumberOrNil ] ]) ] ].
	rawData := DataFrame withRows: rows.
	header doWithIndex: [ :title :index |
		title = 'Spare' ifTrue: 
			[ header at: index put: 'Spare', index asString ] ].
	rawData columnNames: header.
	^rawData