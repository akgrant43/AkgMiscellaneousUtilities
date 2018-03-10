accessing
scanData
	"Answer the scan data as a DataFrame"

	| rawData columnNames frequencyIndex |

	rawData := self rawScanData.
	columnNames := rawData columnNames.
	frequencyIndex := columnNames indexOf: 'Frequency (Hz)'.
	frequencyIndex = 0 ifTrue: [ ^nil ].
	^rawData columnsAt: #(1 2 3 4)