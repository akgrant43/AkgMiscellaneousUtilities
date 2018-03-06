accessing
scanData
	"Answer the scan data as a DataFrame"

	^self rawScanData columnsAt: #(1 2 3 4)