accessing
scanData
	"Answer the scan data as a DataFrame"

	| rawData columnNames frequencyIndex |

	^scanData ifNil: [ 
		rawData := self rawScanData.
		rawData ifNotNil:
			[ columnNames := rawData columnNames.
			frequencyIndex := columnNames indexOf: 'Frequency (Hz)'.
			frequencyIndex = 0 ifTrue: [ ^nil ].
			scanData := rawData columnsAt: #(1 2 3 4) ] ].